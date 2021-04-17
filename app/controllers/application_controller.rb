class ApplicationController < ActionController::Base
    def lettersInit
        letters = []
        for i in (0..10)
            num = rand(97...123)
            letters.push(num.chr)
        end
        return letters
    end
end
