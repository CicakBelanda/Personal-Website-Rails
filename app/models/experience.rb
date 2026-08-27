class Experience < ApplicationRecord
  serialize :highlights, coder: JSON
  validates :title, :organization, presence: true
  scope :ordered, -> { order(:position) }
end
