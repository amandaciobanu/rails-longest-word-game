require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = (0...10).map { (65 + rand(26)).chr }.join
  end

  def word_made_of?(word, letters)
    word.upcase.chars.all? do |c|
      letters.include?(c)
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score
    answer = params[:answer]
    letters = params[:letters]

    # The word can’t be built out of the original grid
    if word_made_of?(answer, letters) == false
      @message = "Sorry, but #{answer} can't be built from #{letters}."
      # The word is valid according to the grid, but is not a valid English word
    elsif english_word?(answer) == false
      @message = "Sorry, but #{answer} is not a valid English word."
      # The word is valid according to the grid and is an English word
    else
      @message = "Congratulations your #{answer} is a valid English word"
    end
    
    
  end
end
