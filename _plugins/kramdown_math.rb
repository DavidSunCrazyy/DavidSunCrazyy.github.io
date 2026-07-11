# 让 kramdown 原生识别 $...$ 作为行内数学分隔符
# kramdown 自带的 math_engine 只认 $$...$$，不认 $...$
# 这个扩展添加了一个 span parser，在遇到 $ 时直接消耗整个 $...$ 块
# 这样 kramdown 的 emphasis 解析器就看不到 _ 了

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
        # 预处理：保护数学环境中的 | 不被 kramdown 表格解析器误识别
        # | 在 LaTeX 中用于条件概率 P(A|B)、绝对值 |x|、集合定义等
        # kramdown GFM 会将其识别为表格列分隔符，导致渲染错误
        # 解决方案：将数学环境内的字面量 | 替换为 \vert（MathJax 渲染效果相同）

        # Step 1: 处理 $$...$$ 显示数学块（行间公式）
        source = source.gsub(/\$\$(.+?)\$\$/m) do |match|
          # 仅替换未被反斜杠转义的 |（保留 \| 如范数符号）
          match.gsub(/(?<!\\)\|/) { '\vert ' }
        end

        # Step 2: 处理 $...$ 行内数学
        # 使用负向断言 (?<!\$)\$ 和 \$(?!\$) 确保匹配的是单个 $ 而不是 $$ 的一部分
        source = source.gsub(/(?<!\$)\$(.+?)\$(?!\$)/m) do |match|
          match.gsub(/(?<!\\)\|/) { '\vert ' }
        end

        __original_initialize(source, options)
        @span_parsers.unshift(:inline_math_single) unless @span_parsers.include?(:inline_math_single)
      end

      def parse_inline_math_single
        start_line_number = @src.current_line_number
        @src.pos += @src.matched_size
        # @src[1] 是捕获组，即 $ 之间的数学内容
        @tree.children << Element.new(
          :math, @src[1], nil,
          category: :span,
          location: start_line_number
        )
      end
    end
  end
end
