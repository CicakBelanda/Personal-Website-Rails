class Education < ApplicationRecord
  validates :school, :degree, presence: true
  scope :ordered, -> { order(:position) }
end
