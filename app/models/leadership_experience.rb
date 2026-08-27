class LeadershipExperience < ApplicationRecord
  serialize :highlights, coder: JSON
  validates :role, presence: true
  scope :ordered, -> { order(:position) }

  # Accept newline-separated strings from the admin form and store as array.
  def highlights=(value)
    value = value.split(/\r?\n/).map(&:strip).reject(&:empty?) if value.is_a?(String)
    super(value)
  end
end
