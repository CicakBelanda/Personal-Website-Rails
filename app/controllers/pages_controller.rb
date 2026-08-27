class PagesController < ApplicationController
  # Skill taxonomy for the "Skills & Technologies" ecosystem.
  # Discipline -> ordered technologies, each with a short, neutral description.
  # Project relationships are derived from each Project's tech_stack (see build_skills_map),
  # so no relationship is ever invented.
  SKILLS_MAP = [
    {
      id: "ios",
      title: "iOS Development",
      blurb: "Native apps engineered end-to-end — interface, on-device intelligence, sensors, and shipping.",
      techs: [
        { name: "Swift", desc: "The primary language for modern native iOS development." },
        { name: "SwiftUI", desc: "Declarative UI framework used across all current projects." },
        { name: "UIKit", desc: "Imperative UI toolkit for fine-grained control and legacy integration." },
        { name: "Core ML", desc: "Apple's on-device machine learning framework." },
        { name: "MapKit", desc: "Map rendering and routing for location-aware experiences." },
        { name: "CoreLocation", desc: "Positioning and region monitoring for spatial features." },
        { name: "CoreHaptics", desc: "Precise haptic feedback for eyes-free interaction." },
        { name: "CoreData", desc: "On-device persistence for app state and caches." },
        { name: "Swift Package Manager", desc: "Dependency and module management." },
        { name: "TestFlight", desc: "Beta distribution and pre-release testing." },
        { name: "App Store Connect", desc: "Release management, metadata, and analytics." },
        { name: "Fastlane / CI-CD", desc: "Automated builds, signing, and release pipelines." }
      ]
    },
    {
      id: "ml",
      title: "Machine Learning",
      blurb: "Models trained and shipped — from research prototypes to on-device inference.",
      techs: [
        { name: "Python", desc: "Primary language for model development and tooling." },
        { name: "PyTorch", desc: "Deep learning framework for research and training." },
        { name: "scikit-learn", desc: "Classical ML: regression, clustering, and evaluation." },
        { name: "Core ML", desc: "Deployment of models for private on-device inference." },
        { name: "Computer Vision", desc: "Image and video understanding for real-time features." },
        { name: "Machine Learning", desc: "End-to-end modeling: data, training, and serving." },
        { name: "TensorFlow", desc: "Additional training and serving ecosystem." },
        { name: "NumPy", desc: "Numerical computing foundation for ML workflows." },
        { name: "Pandas", desc: "Structured data wrangling and feature preparation." },
        { name: "Jupyter", desc: "Interactive notebooks for experimentation and analysis." }
      ]
    },
    {
      id: "ds",
      title: "Data Science",
      blurb: "Turning raw data into decisions — analysis, forecasting, and clear visualization.",
      techs: [
        { name: "Python", desc: "Primary language for analysis and pipelines." },
        { name: "Pandas", desc: "Data manipulation and aggregation." },
        { name: "NumPy", desc: "Vectorized numerical computation." },
        { name: "SQL", desc: "Querying and modeling relational data." },
        { name: "Data Visualization", desc: "Charts and dashboards that communicate findings." },
        { name: "Jupyter", desc: "Reproducible analysis and reporting." },
        { name: "Time Series", desc: "Forecasting and trend analysis over time." },
        { name: "PostgreSQL", desc: "Production relational database and analytics store." },
        { name: "Statistics", desc: "Inference, testing, and quantitative reasoning." },
        { name: "Data Analysis", desc: "Exploration and insight from real datasets." }
      ]
    }
  ].freeze

  # Supporting / web technologies — shown smaller, never as a primary discipline.
  SKILLS_EXTRA = [
    { name: "Ruby on Rails", desc: "Full-stack web framework (this site)." },
    { name: "JavaScript", desc: "Client-side interactivity and tooling." },
    { name: "Hotwire", desc: "HTML-over-the-wire for progressive web apps." },
    { name: "PostgreSQL", desc: "Relational database for web services." },
    { name: "REST API", desc: "Service and integration design." },
    { name: "Docker", desc: "Containerized development and deployment." },
    { name: "Git", desc: "Version control and collaboration." }
  ].freeze

  def home
    @projects = Project.ordered
    @featured_projects = Project.featured.limit(4)
    @other_projects = Project.where(featured: false).order(:position)
    @experiences = Experience.ordered
    @educations = Education.ordered
    @publications = Publication.ordered
    @leaderships = LeadershipExperience.ordered
    @certifications = Certification.ordered
    @awards = Award.ordered

    # Skills ecosystem (data-driven; project links derived from tech_stack).
    @skills_map = build_skills_map
    @skills_extra = SKILLS_EXTRA

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

  # Build the skill map, enriching each technology with the projects that actually
  # use it (matched by exact name against Project#tech_stack). Includes only real
  # relationships — never fabricates a link.
  def build_skills_map
    used = Project.ordered.each_with_object({}) do |p, acc|
      techs = p.tech_stack.is_a?(Array) ? p.tech_stack : (JSON.parse(p.tech_stack || "[]") rescue [])
      techs.each { |t| (acc[t] ||= []) << { id: p.id, title: p.title } }
    end
    SKILLS_MAP.map do |disc|
      techs = disc[:techs].map do |t|
        t.merge(projects: (used[t[:name]] || []).map { |pr| { id: pr[:id], title: pr[:title] } })
      end
      disc.merge(techs: techs)
    end
  end

  # Public, absolute URL for an Active Storage attachment (served by the app,
  # no auth required) so the case-study modal can render uploaded media.
  def media_url(att)
    Rails.application.routes.url_helpers.rails_blob_url(att, host: request.base_url)
  end
end
