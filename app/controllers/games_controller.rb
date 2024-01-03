class GamesController < ApplicationController

    def new
    end

    def create
      Game.create!(status: 'in_progress')
      #redirect_to new_game_progress_path(game) #新しい進行を作成するためのゲームのインスタンス
      redirect_to step1_cocktails_path
    end

end
