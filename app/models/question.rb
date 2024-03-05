# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :progresses
end
