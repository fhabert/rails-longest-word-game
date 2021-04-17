require 'json'
require 'open-uri'

class GamesController < ApplicationController
    def new
        @letters = lettersInit()
    end
    
    def score
        @word = params['word']
        @letters = params[:grid].split(' ')
        @canBuild = can_build?(@word)
        @score = 0
        @englishWord = real_word?(@word)
        if @canBuild && @englishWord
            @score = @word.length
        end
        if session['score']
            session['score'] += @score
        else
            session['score'] = 0
        end
    end

    def real_word?(word)
        url = "https://wagon-dictionary.herokuapp.com/#{word}"
        html = open(url).read
        data = JSON.parse(html)
        if data['found']
            return true
        else 
            return false
        end
    end

    def can_build?(word)
        counter = 0
        @word.each_char do |letter|
            if @letters.include?(letter)
                counter += 1
            end
        end
        if counter == @word.length
            return true
        else 
            return false
        end
    end
end
