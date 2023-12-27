class GamesController < ApplicationController

    def new
    end

    def create
        Game.create!(status: 'in_progress')
        render plain: "game started! Let's start next section."
    end

end
