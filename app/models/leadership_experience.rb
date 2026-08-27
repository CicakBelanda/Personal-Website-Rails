class LeadershipExperience < ApplicationRecord
  serialize :highlights, coder: JSON
  validates :role, presence: true
  scope :ordered, -> { order(:position) }
end
