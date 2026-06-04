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
