# frozen_string_literal: true

class Progress < ApplicationRecord
  belongs_to :game
  belongs_to :question

  def assign_sequence
    next_sequence = 1
    if game.present?
      all_progress = game.progresses
      next_sequence = all_progress.maximum(:sequence) + 1 if all_progress.count.positive?
    end
    self.sequence = next_sequence
  end
end
