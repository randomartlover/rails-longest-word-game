require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    @letters = Array.new(10) { charset.sample }
    session[:score] = 0 unless session[:score]
  end

  def score
    word = params[:word]
    letters = params[:letters_array]
    get_result(word, letters)
  end

  private

  def get_result(word, letters)
    @result = if !in_grid?(word, letters.split(', '))
                "Sorry but <strong>#{word}</strong> can't be build out of #{letters}"
              elsif !get_result_from_api(word)['found']
                "Sorry but <strong>#{word}</strong> does not seem to be a valid English word..."
              else
                session[:score] = session[:score] + (word.length * 2)
                "<strong>Congratulations!</strong> #{word} is a valid English word"
              end
    @score = session[:score]
  end

  def in_grid?(attempt, letters)
    attempt_char_array = attempt.upcase.chars
    attempt_char_array.each do |char|
      return false unless letters.include?(char)

      letters.delete_at(letters.index(char))
    end
    true
  end

  def get_result_from_api(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    result_serialized = URI.parse(url).open.read
    JSON.parse(result_serialized)
  end
end
