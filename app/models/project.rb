class Project < ApplicationRecord
  # For SQLite, store tech_stack as JSON/text
  def tech_stack
    self[:tech_stack] ||= []
    self[:tech_stack] = JSON.parse(self[:tech_stack]) if self[:tech_stack].is_a?(String)
    self[:tech_stack]
  rescue JSON::ParserError
    self[:tech_stack] = []
  end
  
  def tech_stack=(value)
    self[:tech_stack] = value.is_a?(Array) ? value.to_json : value
  end
  
  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: %w[ios data_science software_dev] }
  validates :tech_stack, presence: true
  
  scope :featured, -> { where(featured: true).order(:position) }
  scope :by_category, ->(category) { where(category: category) }
  scope :ordered, -> { order(:position) }
  
  def self.categories
    %w[ios data_science software_dev]
  end
  
  def self.category_labels
    {
      'ios' => 'iOS Apps',
      'data_science' => 'Data Science',
      'software_dev' => 'Software Dev'
    }
  end
end