class Certification < ApplicationRecord
  validates :name, presence: true
  scope :ordered, -> { order(:position) }
end
