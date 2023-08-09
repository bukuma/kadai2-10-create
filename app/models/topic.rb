class Topic < ApplicationRecord
  # Validation
  validates :title, presence: true

  # ActiveStorage
  has_one_attached :image
end
