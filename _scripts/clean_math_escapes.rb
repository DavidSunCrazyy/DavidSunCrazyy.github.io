#!/usr/bin/env ruby
# 清理 _posts/ 和 _draft/ 下所有 .md 文件中的不必要转义
# 配合 kramdown math_engine: mathjax 使用
# 使用全局替换：所有 \_ \\{ \\} \\| \\letter 模式都在数学环境内

require 'find'

POSTS_DIRS = [
  File.join(__dir__, '..', '_posts'),
  File.join(__dir__, '..', '_draft'),
].freeze

def clean_escapes(text)
  prev = nil
  until text == prev
    prev = text
    # \\ + letters → \ + letters（如 \\mathcal → \mathcal）
    text = text.gsub(/\\\\([a-zA-Z]+)/) { "\\#{$1}" }
    # \\ + { } | → \{ \} \|
    text = text.gsub(/\\\\([{}|])/) { "\\#{$1}" }
    # \_ → _
    text = text.gsub(/\\_/, '_')
  end
  text
end

def fix_frontmatter(text)
  text.sub(/^use\\_math:/, 'use_math:')
end

def process_file(filepath)
  original = File.read(filepath)
  processed = clean_escapes(original)
  processed = fix_frontmatter(processed)

  if original != processed
    File.write(filepath, processed)
    puts "  ✓ #{filepath}"
    true
  else
    puts "  - #{filepath} (无需修改)"
    false
  end
end

changed_count = 0
total_count = 0

POSTS_DIRS.each do |dir|
  next unless Dir.exist?(dir)

  puts "\n处理目录: #{dir}"
  Find.find(dir) do |path|
    next unless path.end_with?('.md')
    next unless File.file?(path)

    total_count += 1
    changed_count += 1 if process_file(path)
  end
end

puts "\n===== 完成 ====="
puts "共处理 #{total_count} 个文件，修改了 #{changed_count} 个文件"
