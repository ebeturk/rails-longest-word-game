require "open-uri"

class GamesController < ApplicationController

   def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end



  def score

    @score = 0
    @word = params[:word]
    letter_string = params[:letters]
    @letters = letter_string.split
    # binding.pry
    # @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    if english_word?(@word)
        if included?(@word, @letters)
        @score = @word.length * 10

        else
        @score = 0
        "You used letters that are not in the grid"
      end
    else
      @score = 0
      "That's not an English word."
    end

  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
