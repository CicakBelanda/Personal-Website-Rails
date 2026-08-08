# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# iOS App Projects
Project.create!([
  {
    title: "MoldDetect Pro",
    description: "iOS application for indoor mold detection using computer vision and ML models. Users can scan rooms for potential mold growth factors and receive actionable recommendations.",
    category: "ios",
    tech_stack: ["Swift", "SwiftUI", "CoreML", "Computer Vision", "TensorFlow Lite", "TestFlight"],
    github_url: "https://github.com/CicakBelanda/MoldDetect-Pro",
    demo_url: "https://apps.apple.com/app/molddetect-pro/id1234567890",
    featured: true,
    position: 1
  },
  {
    title: "HealthTrack+",
    description: "Comprehensive health monitoring app that integrates with Apple HealthKit to track vital signs, exercise, and wellness metrics with personalized insights.",
    category: "ios",
    tech_stack: ["Swift", "SwiftUI", "HealthKit", "Combine", "CoreData", "Firebase Analytics"],
    github_url: "https://github.com/CicakBelanda/HealthTrack",
    demo_url: "https://apps.apple.com/app/healthtrack/id9876543210",
    featured: true,
    position: 2
  },
  {
    title: "TaskMaster",
    description: "Productivity app with AI-powered task categorization, smart scheduling, and natural language processing for task creation.",
    category: "ios",
    tech_stack: ["Swift", "SwiftUI", "Natural Language Framework", "CoreData", "WidgetKit"],
    github_url: "https://github.com/CicakBelanda/TaskMaster",
    demo_url: "https://apps.apple.com/app/taskmaster/id1122334455",
    featured: false,
    position: 4
  }
])

# Data Science Projects
Project.create!([
  {
    title: "Mold Growth Prediction Model",
    description: "Machine learning pipeline analyzing environmental factors that contribute to indoor mold growth. Includes data preprocessing, anomaly detection, and predictive modeling with deployment recommendations.",
    category: "data_science",
    tech_stack: ["Python", "Pandas", "Scikit-learn", "PyTorch", "MLflow", "Jupyter", "Docker"],
    github_url: "https://github.com/CicakBelanda/mold-prediction-model",
    demo_url: "https://cicakbelanda.github.io/mold-prediction-dashboard",
    featured: true,
    position: 3
  },
  {
    title: "Customer Segmentation Engine",
    description: "Unsupervised learning system that segments customers based on purchasing behavior, demographics, and engagement patterns to improve marketing strategies.",
    category: "data_science",
    tech_stack: ["Python", "Pandas", "NumPy", "Scikit-learn", "K-Means Clustering", "ElasticSearch", "Plotly"],
    github_url: "https://github.com/CicakBelanda/customer-segmentation",
    demo_url: "https://customer-segmentation.cicakbelanda.dev",
    featured: true,
    position: 5
  },
  {
    title: "Real-time Anomaly Detection",
    description: "Stream processing system for detecting anomalies in IoT sensor data using statistical methods and machine learning models with real-time alerts.",
    category: "data_science",
    tech_stack: ["Python", "Pandas", "Scikit-learn", "Kafka", "Redis", "AWS Lambda", "Grafana"],
    github_url: "https://github.com/CicakBelanda/anomaly-detection",
    demo_url: "https://anomaly.cicakbelanda.dev",
    featured: false,
    position: 7
  }
])

# Software Development Projects
Project.create!([
  {
    title: "HoMoold - Indoor Mold Detection",
    description: "Rails-based web platform for tracking and managing indoor mold detection for real estate and property management companies. Features automated reports, user management, and integration with IoT sensors.",
    category: "software_dev",
    tech_stack: ["Ruby on Rails 8", "PostgreSQL", "Bootstrap 5", "Hotwire Turbo", "ActiveStorage", "Sidekiq", "Docker"],
    github_url: "https://github.com/CicakBelanda/HoMoold",
    demo_url: "https://holmold.com",
    featured: true,
    position: 0
  },
  {
    title: "Data Pipeline Framework",
    description: "Modular data engineering framework for building, managing, and monitoring ETL pipelines with support for multiple data sources, transformations, and quality checks.",
    category: "software_dev",
    tech_stack: ["Python", "Apache Airflow", "PostgreSQL", "Docker", "Kubernetes", "Celery", "Redis"],
    github_url: "https://github.com/CicakBelanda/data-pipeline-framework",
    demo_url: "https://github.com/CicakBelanda/data-pipeline-framework#readme",
    featured: false,
    position: 6
  },
  {
    title: "API Gateway Service",
    description: "High-performance API gateway built with Rails that provides rate limiting, authentication, caching, and monitoring for microservices architecture.",
    category: "software_dev",
    tech_stack: ["Ruby on Rails", "JWT", "Redis", "Prometheus", "Grafana", "Docker Swarm", "REST API"],
    github_url: "https://github.com/CicakBelanda/api-gateway",
    demo_url: "https://api.cicakbelanda.dev",
    featured: false,
    position: 8
  }
])

puts "✅ Seeded #{Project.count} projects across all categories!"