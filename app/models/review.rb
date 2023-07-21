class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  STARS = [1, 2, 3, 4, 5].freeze

  validates :comment, length: { minimum: 4 }
  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }
end
