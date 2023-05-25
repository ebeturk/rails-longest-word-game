require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    @a_word = english_word?(@word)
    @valid_word = correct_letters?(@word.dup.upcase, @letters.dup)
    @score = params[:timeLeft].to_i + @word.length * 20
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def correct_letters?(word, letters)
    word.each_char do |letter|
      letters.include?(letter) ? letters.delete(letter) && word.sub!(letter, '') : break
    end
    word.empty?
  end
end
