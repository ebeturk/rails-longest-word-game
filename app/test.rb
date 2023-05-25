letters = Array.new(10) { ('A'..'Z').to_a.sample }
p letters
word = gets.chomp.upcase
word.each_char do |letter|
    letters.include?(letter) ? letters.delete(letter) && word.sub!(letter, "") : break
  end
  p word
  p word.empty?
