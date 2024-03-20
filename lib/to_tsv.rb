require "open3"
require "rbconfig"

exam_class = 'silver'
exam_class = 'gold'

lang = '_ja'

question_file = "#{exam_class}#{lang}.md"
answer_file = "#{exam_class}_answers#{lang}.md"
tsv_file = "outputs/ruby_#{exam_class}#{lang}.tsv"

questions = File.read(question_file).split(/^-------------.*\n/)
answers = File.read(answer_file).split(/^-------------.*\n/)

questions[0].sub!(/[\d\D]+\*\*Q1\./, "**Q1.")

if questions.size != 51 || answers.size != 51
  puts "#{questions.size}, #{answers.size}"
  puts "問題数か解答数が50問ではないです。コードを見直して下さい。"
  exit
end

# p tsv_file
File.open(tsv_file,"w") do |text|
  (0...50).each do |i|
    text.print('"' + questions[i].strip.gsub('"', '""') + '"' + "\t")
    text.print('"' + answers[i].strip.gsub('"', '""') + '"' + "\n")
  end
end
