require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid = Array.new(9) { ('A'..'Z').to_a.sample }
   @letters = grid.join(' ')
  end

  def score
    @word = params[:word]
    @grid = params[:letters]
    @message = ''
    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      json['found']
    end
    if @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }
      if english_word?(@word)
        @message = 'well done!'
      else
        @message = 'not an english word'
      end
    else
      @message = 'not in the grid'
    end
  end
  @message
end
