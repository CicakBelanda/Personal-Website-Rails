class Publication < ApplicationRecord
  validates :title, presence: true
  scope :ordered, -> { order(:position) }
end
