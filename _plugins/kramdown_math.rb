# 让 kramdown 原生识别 $...$ 作为行内数学分隔符
# kramdown 自带的 math_engine 只认 $$...$$，不认 $...$
# 这个扩展包含两部分：
# 1. Jekyll Hook: 在 kramdown 处理之前替换数学环境中的 | 为 \vert
# 2. kramdown 扩展: 注册 $...$ 行内数学解析器 + 二次保险替换 |

require 'jekyll'

# Part 1: Jekyll Hook - 预处理数学环境中的 |
# 在 Jekyll 层面工作，比 monkey-patch kramdown 更可靠，CI 环境也稳定
Jekyll::Hooks.register [:posts, :pages, :documents], :pre_render do |doc|
  next unless doc.respond_to?(:content) && doc.content.is_a?(String)

  # 处理 $$...$$ 显示数学块
  doc.content = doc.content.gsub(/\$\$(.+?)\$\$/m) do |match|
    match.gsub(/(?<!\\)\|/) { '\vert ' }
  end

  # 处理 $...$ 行内数学（排除 $$...$$）
  doc.content = doc.content.gsub(/(?<!\$)\$(.+?)\$(?!\$)/m) do |match|
    match.gsub(/(?<!\\)\|/) { '\vert ' }
  end
end

# Part 2: kramdown 扩展 - 注册 $...$ 行内数学解析器
module Kramdown
  module Parser
    class Kramdown
      # 注册 $...$ 行内数学解析器
      # 正则：$ + 一个以上非$字符 + $，支持跨行
      INLINE_MATH_SINGLE_START = /\$([^$]+)\$/m

      define_parser(:inline_math_single, INLINE_MATH_SINGLE_START, '\$')

      # 将新解析器插入 span_parsers 列表最前面
      # 确保 $...$ 在 emphasis (_) 解析之前被匹配
      alias_method :__original_initialize, :initialize

      def initialize(source, options)
        # 二次保险：在 kramdown 层面也替换 |
        # 如果 Jekyll Hook 已经处理过（Jekyll 场景），这里就是 no-op
        # 如果直接使用 kramdown CLI（非 Jekyll 场景），这里仍然生效

        # Step 1: 处理 $$...$$ 显示数学块（行间公式）
        source = source.gsub(/\$\$(.+?)\$\$/m) do |match|
          match.gsub(/(?<!\\)\|/) { '\vert ' }
        end

        # Step 2: 处理 $...$ 行内数学
        source = source.gsub(/(?<!\$)\$(.+?)\$(?!\$)/m) do |match|
          match.gsub(/(?<!\\)\|/) { '\vert ' }
        end

        __original_initialize(source, options)
        @span_parsers.unshift(:inline_math_single) unless @span_parsers.include?(:inline_math_single)
      end

      def parse_inline_math_single
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        @tree.children << Element.new(
          :math, @src[1], nil,
          category: :span,
          location: start_line_number
        )
      end
    end
  end
end
