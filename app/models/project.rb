class Project < ApplicationRecord
  # Device uploads (Active Storage, local disk) — cover is a single image,
  # gallery is a set of images. Replaces the old URL-string columns.
  has_one_attached :cover_image
  has_many_attached :gallery_images

  # For SQLite, store tech_stack as JSON/text
  def tech_stack
    self[:tech_stack] ||= []
    self[:tech_stack] = JSON.parse(self[:tech_stack]) if self[:tech_stack].is_a?(String)
    self[:tech_stack]
  rescue JSON::ParserError
    self[:tech_stack] = []
  end
  
  def tech_stack=(value)
    value = value.split(/\r?\n/).map(&:strip).reject(&:empty?) if value.is_a?(String)
    self[:tech_stack] = value.is_a?(Array) ? value.to_json : value
  end

  # Array-backed fields stored as JSON text; accept newline-separated strings from forms.
  %w[key_features].each do |field|
    define_method("#{field}=") do |value|
      value = value.split(/\r?\n/).map(&:strip).reject(&:empty?) if value.is_a?(String)
      self[field] = value.is_a?(Array) ? value.to_json : value
    end

    define_method(field) do
      raw = self[field]
      return [] if raw.nil? || raw == ""
      parsed = raw.is_a?(Array) ? raw : JSON.parse(raw)
      parsed.is_a?(Array) ? parsed : []
    rescue JSON::ParserError
      []
    end
  end

  # Metrics: stored as JSON array of { value:, label: } hashes.
  def metrics=(value)
    return self[:metrics] = nil if value.nil? || value == ""
    arr = value.is_a?(Array) ? value : JSON.parse(value)
    self[:metrics] = arr.is_a?(Array) ? arr.to_json : value
  rescue JSON::ParserError
    self[:metrics] = value
  end

  def metrics
    raw = self[:metrics]
    return [] if raw.nil? || raw == ""
    parsed = raw.is_a?(Array) ? raw : JSON.parse(raw)
    parsed.is_a?(Array) ? parsed : []
  rescue JSON::ParserError
    []
  end

  def short_description
    self[:short_description].presence || description
  end

  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true
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