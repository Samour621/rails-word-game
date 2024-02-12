require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
    @letters << [*'A'..'Z'].sample
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    url_open = URI.open(url).read
    hash = JSON.parse(url_open)

    result = hash["found"]

    thingy = params[:letters]
    user_input = params[:word].upcase
    user_input.chars.each do |letter|
      valid = thingy.include?(letter)
      if valid == true && result == true
        @display = "Congrats! #{params[:word]} is a word"
      elsif result == true && valid == false
        @display = "#{params[:word]} is a word, but not part of the letter grid"
      else
        @display = "#{params[:word]} is not a word"
      end
    end
  end
end
