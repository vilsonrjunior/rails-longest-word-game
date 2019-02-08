require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:random_letters]
    @word = params[:word]

    if word_valid?(@word) && in_the_grid?(@word, @letters)
    @word = "Congratulations! #{@word} is an English word!"
    elsif !word_valid?(@word)
    @word = "Sorry, but #{@word} does not seem to be a valid English word"
    elsif
    @word = "Sorry, but a word cannot be built out for #{@letters}."
    end
  end

 def word_valid?(word)
   url = "https://wagon-dictionary.herokuapp.com/#{word}"
   user_serialized = open(url).read
   user = JSON.parse(user_serialized)
   return true if user["found"]
  end
 end

def in_the_grid?(attempt, grid)
  attempt.chars.all? do |char|
    attempt.count(char) <= grid.count(char)
  end
end
