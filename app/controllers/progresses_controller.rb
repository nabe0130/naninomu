# frozen_string_literal: true

# ProgressesControllerはユーザーの進捗管理を担当するコントローラです。
# ユーザーが取り組んでいるゲームや学習の進捗を作成、更新するためのアクションを提供します。
class ProgressesController < ApplicationController
  def new
    current_game = Game.find(params[:game_id])
    @question = current_game.next_question # このメソッドは現在のゲームに基づいて次の質問を取得します
  end

  def create
    current_game = Game.find(params[:game_id])

    # 回答した内容を保存する
    progress = current_game.progresses.new(create_params)
    progress.assign_sequence
    progress.save!

    redirect_to new_game_progresses_path(current_game)
  end

  private

  def create_params
    params.require(:progress).permit(:question_id, :answer)
  end
end
