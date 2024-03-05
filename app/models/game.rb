# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :progresses

  def next_question
    # すでに答えた質問を除外して次の質問を選ぶ例
    Question.where.not(id: progresses.pluck(:question_id)).sample
  end
end
