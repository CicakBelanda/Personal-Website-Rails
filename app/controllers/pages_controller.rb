class PagesController < ApplicationController
  SKILLS = [
    { name: "Swift", logo: "devicon devicon-swift-plain", placeholder: nil, domain: :ios },
    { name: "SwiftUI", logo: "devicon devicon-swiftui-plain", placeholder: nil, domain: :ios },
    { name: "UIKit", logo: nil, placeholder: "U", domain: :ios },
    { name: "TestFlight", logo: "devicon devicon-apple-plain", placeholder: nil, domain: :ios },
    { name: "App Store Connect", logo: "devicon devicon-apple-plain", placeholder: nil, domain: :ios },
    { name: "Fastlane CI/CD", logo: nil, placeholder: "F", domain: :ios },
    { name: "CoreData", logo: nil, placeholder: "C", domain: :ios },
    { name: "Swift Package Manager", logo: "devicon devicon-swift-plain", placeholder: nil, domain: :ios },
    { name: "Python", logo: "devicon devicon-python-plain", placeholder: nil, domain: :ds },
    { name: "Pandas", logo: "devicon devicon-pandas-plain", placeholder: nil, domain: :ds },
    { name: "NumPy", logo: "devicon devicon-numpy-plain", placeholder: nil, domain: :ds },
    { name: "Scikit-learn", logo: "devicon devicon-scikitlearn-plain", placeholder: nil, domain: :ds },
    { name: "PyTorch", logo: "devicon devicon-pytorch-plain", placeholder: nil, domain: :ds },
    { name: "TensorFlow", logo: "devicon devicon-tensorflow-plain", placeholder: nil, domain: :ds },
    { name: "Machine Learning", logo: nil, placeholder: "M", domain: :ds },
    { name: "Jupyter", logo: "devicon devicon-jupyter-plain", placeholder: nil, domain: :ds },
    { name: "Data Viz", logo: "devicon devicon-numpy-plain", placeholder: nil, domain: :ds },
    { name: "SQL", logo: "devicon devicon-postgresql-plain", placeholder: nil, domain: :ds },
    { name: "Ruby on Rails", logo: "devicon devicon-rails-plain", placeholder: nil, domain: :web },
    { name: "PostgreSQL", logo: "devicon devicon-postgresql-plain", placeholder: nil, domain: :web },
    { name: "SQLite", logo: "devicon devicon-sqlite-plain", placeholder: nil, domain: :web },
    { name: "JavaScript", logo: "devicon devicon-javascript-plain", placeholder: nil, domain: :web },
    { name: "Hotwire", logo: nil, placeholder: "H", domain: :web },
    { name: "REST API", logo: nil, placeholder: "R", domain: :web },
    { name: "GraphQL", logo: nil, placeholder: "G", domain: :web },
    { name: "Docker", logo: "devicon devicon-docker-plain", placeholder: nil, domain: :web },
    { name: "Git", logo: "devicon devicon-git-plain", placeholder: nil, domain: :web },
    { name: "System Design", logo: nil, placeholder: "S", domain: :web },
    { name: "TDD", logo: nil, placeholder: "T", domain: :web }
  ].freeze

  def home
    @projects = Project.ordered
    @featured_projects = Project.featured.limit(3)
    @skill_rows = build_skill_rows
    @experiences = Experience.ordered
    @educations = Education.ordered
    @publications = Publication.ordered
    @leaderships = LeadershipExperience.ordered
    @certifications = Certification.ordered
    @awards = Award.ordered

    # Structured, DB-driven data for the public project modal (no hardcoded content).
    @projects_data = Project.ordered.map do |p|
      tech = p.tech_stack.is_a?(Array) ? p.tech_stack : (JSON.parse(p.tech_stack || "[]") rescue [])
      {
        id: p.id,
        title: p.title,
        category: p.category,
        categoryLabel: p.category_label.presence || Project.category_labels[p.category],
        shortDescription: p.short_description.presence || p.description,
        description: p.description,
        date: p.project_date,
        location: p.location,
        role: p.role,
        client: p.client,
        status: p.status,
        techStack: tech,
        problem: p.problem,
        solution: p.solution,
        techDetails: p.tech_details,
        keyFeatures: p.key_features,
        metrics: p.metrics,
        gallery: p.gallery_images.attached? ? p.gallery_images.map { |g| media_url(g) } : [],
        coverImage: p.cover_image.attached? ? media_url(p.cover_image) : nil,
        githubUrl: p.github_url,
        demoUrl: p.demo_url
      }
    end
  end

  private

  # Public, absolute URL for an Active Storage attachment (served by the app,
  # no auth required) so the case-study modal can render uploaded media.
  def media_url(att)
    Rails.application.routes.url_helpers.rails_blob_url(att, host: request.base_url)
  end

  # Balanced interleave: round-robin the domains (ios -> ds -> web -> ...),
  # shuffling the domain order each load so it varies, then chunk the single
  # balanced sequence into 3 rows. Guarantees every row mixes all 3 domains.
  def build_skill_rows
    by_domain = SKILLS.group_by { |s| s[:domain] }.transform_values(&:shuffle)
    domains = by_domain.keys.shuffle
    interleaved = []
    loop do
      placed = false
      domains.each do |d|
        q = by_domain[d]
        next if q.empty?
        interleaved << q.shift
        placed = true
      end
      break unless placed
    end
    # Split the balanced sequence into 3 contiguous rows (10/10/9).
    interleaved.each_slice((interleaved.length / 3.0).ceil).to_a
  end
end
