require 'json'
require 'open-uri'

class GamesController < ApplicationController
    def new
        @letters = lettersInit()
        @started_at = Time.now.to_time
    end
    
    def score
        ended_at = Time.now.to_time
        time = (ended_at.to_i - params['start_time'].to_i).abs * 1000
        @word = params['word']
        @letters = params[:grid].split(' ')
        @canBuild = can_build?()
        @score = 0
        @englishWord = real_word?()
        if @canBuild && @englishWord
            @score = (@word.length / time).abs
        end
        if session[:score]
            session[:score] += @score
        else
            session[:score] = @score
        end
    end

    private 

    def real_word?
        url = "https://wagon-dictionary.herokuapp.com/#{@word}"
        html = open(url).read
        data = JSON.parse(html)
        data['found']
    end

    def can_build?
        counter = 0
        letters = @letters
        @word.split("").each_with_index do |letter, index|
            if letters.include?(letter)
                counter += 1
                letters.delete_at(index)
            end
        end
        if counter == @word.length
            return true
        return false
        end
    end
end
