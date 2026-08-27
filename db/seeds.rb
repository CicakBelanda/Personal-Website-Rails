# Seeds the four real portfolio projects from the PRD (§17). Content is
# grounded in the PRD's stated categories / technologies / emphasis — no
# invented metrics or achievements (PRD §53).

# Only seed when the database is empty. On redeploys this is a no-op so any
# content edited through the admin CMS is preserved.
if Project.count == 0
Project.delete_all

projects = [
  {
    title: "HoMoold",
    category: "ios",
    category_label: "iOS Development · Machine Learning",
    description: "Indoor mold risk detection and assessment for second-hand property seekers — an on-device iOS app that turns environmental readings and visual checks into a clear, decision-ready risk report.",
    role: "iOS Developer & ML Engineer",
    problem: "Home buyers and renters have no quick, trustworthy way to gauge indoor mold risk before committing. Professional inspections are slow and costly, and generic advice ignores a property's actual environmental conditions.",
    solution: "HoMoold runs entirely on-device: it captures environmental inputs and on-device ML predictions, then presents a real-time risk assessment with visual indicators a non-expert can act on — including clear guidance on what to ask a seller or landlord.",
    tech_details: "Built in SwiftUI with a Core ML model for on-device inference. Environmental signals are gathered through CoreLocation and device sensors; predictions run locally for privacy and instant feedback. Native iOS implementation with a focus on accessible, decision-oriented visual indicators (red-flag / remediate / walk-away framing).",
    tech_stack: ["Swift", "SwiftUI", "Core ML"],
    github_url: "https://github.com/CicakBelanda/HoMoold",
    demo_url: "",
    project_date: "2024",
    featured: true,
    position: 1
  },
  {
    title: "K-SINI",
    category: "ios",
    category_label: "iOS Development · Navigation",
    description: "Indoor navigation for large venues — checkpoint-based turn-by-turn guidance with a live compass and haptic feedback.",
    role: "iOS Developer",
    problem: "Indoor spaces such as campuses, malls and transit hubs lack reliable GPS, so people get lost with no turn-by-turn help.",
    solution: "K-SINI uses checkpoint-based routing with CoreLocation positioning, MapKit rendering and a live compass for orientation, plus CoreHaptics feedback at each turn so guidance keeps working without the user constantly looking at the screen.",
    tech_details: "SwiftUI UI over MapKit annotations and routes. CoreLocation drives location detection and checkpoint proximity; a live compass view orients the user; CoreHaptics delivers discrete turn signals for eyes-free navigation.",
    tech_stack: ["SwiftUI", "MapKit", "CoreLocation", "CoreHaptics"],
    github_url: "https://github.com/CicakBelanda/K-SINI",
    demo_url: "",
    project_date: "2025",
    featured: true,
    position: 2
  },
  {
    title: "Petik.in",
    category: "ios",
    category_label: "iOS Development · Computer Vision · Machine Learning",
    description: "A guitar learning companion that uses computer vision to analyze playing in real time and give actionable feedback.",
    role: "iOS Developer & ML Engineer",
    problem: "Self-taught guitarists struggle to know whether their technique and timing are correct without a teacher present.",
    solution: "Petik.in watches the player through the camera, runs on-device computer vision to assess performance, and returns real-time feedback on form and timing so learners can correct mistakes as they play.",
    tech_details: "SwiftUI camera integration feeding an on-device ML / computer-vision pipeline for performance analysis and real-time feedback. Inference runs locally for low latency and privacy.",
    tech_stack: ["SwiftUI", "Computer Vision", "On-device ML"],
    github_url: "https://github.com/CicakBelanda/Petik.in",
    demo_url: "",
    project_date: "2025",
    featured: true,
    position: 3
  },
  {
    title: "Flippa77",
    category: "ios",
    category_label: "iOS Development",
    description: "iOS application currently in development.",
    role: "iOS Developer",
    problem: "Technical details to be finalized with the shipped implementation.",
    solution: "Technical details to be finalized with the shipped implementation.",
    tech_details: "Technical details to be finalized with the shipped implementation.",
    tech_stack: ["SwiftUI", "Swift"],
    github_url: "https://github.com/CicakBelanda/Flippa77",
    demo_url: "",
    project_date: "2026",
    featured: true,
    position: 4
  }
]

projects.each { |p| Project.create!(p) }

puts "✅ Seeded #{Project.count} projects."

# ----------------------------------------------------------------------------
# Experience (PRD §19)
# ----------------------------------------------------------------------------
Experience.delete_all
experiences = [
  {
    title: "Junior iOS Developer",
    organization: "Apple Developer Academy @BINUS Tangerang",
    start_date: "March 2026",
    end_date: "Present",
    current: true,
    position: 1,
    highlights: [
      "Develop native iOS applications using Swift and SwiftUI.",
      "Apply Core ML, MapKit, CoreLocation and CoreHaptics in production features.",
      "Collaborate with developers, designers and business members on shipped app features."
    ]
  },
  {
    title: "Multimedia Coach",
    organization: "PT Digikidz Indonesia",
    start_date: "July 2025",
    end_date: "January 2026",
    current: false,
    position: 2,
    highlights: [
      "Delivered 40+ technology lessons spanning software development, AI, robotics, game development and IoT.",
      "Mentored 60+ students, with measurable improvement across cohorts."
    ]
  },
  {
    title: "Laboratory Teaching Assistant",
    organization: "Bina Nusantara University",
    start_date: "September 2024",
    end_date: "December 2024",
    current: false,
    position: 3,
    highlights: [
      "Led C programming laboratory instruction for 70+ students.",
      "Evaluated assignments and provided hands-on support during lab sessions."
    ]
  }
]
experiences.each { |e| Experience.create!(e) }
puts "✅ Seeded #{Experience.count} experiences."

# ----------------------------------------------------------------------------
# Education (PRD §25)
# ----------------------------------------------------------------------------
Education.delete_all
Education.create!(
  school: "Bina Nusantara University",
  degree: "Bachelor of Computer Science",
  location: "Jakarta, Indonesia",
  start_date: "September 2023",
  end_date: "Present",
  expected_graduation: "2027",
  gpa: "4.00 / 4.00",
  position: 1
)
puts "✅ Seeded education."

# ----------------------------------------------------------------------------
# Publications / Research (PRD §27)
# ----------------------------------------------------------------------------
Publication.delete_all
publications = [
  {
    title: "Molecule World: Enhancing Chemistry Education Through Web-Based Augmented Reality Using Assemblr",
    publisher: "Elsevier",
    publication_date: "November 2024",
    description: "Explores how web-based augmented reality can improve chemistry education through interactive 3D molecular visualization.",
    methods: "Web-based AR (Assemblr), interactive molecular visualization, education study design.",
    doi_url: "",
    position: 1
  },
  {
    title: "Utilizing AI-Powered Anomaly Detection to Counter DDoS Attacks: A Comparative Study of Random Forest and XGBoost Algorithm in Network Protection",
    publisher: "IEEE",
    publication_date: "December 2025",
    description: "Compares Random Forest and XGBoost for AI-powered DDoS anomaly detection in network protection.",
    methods: "Random Forest, XGBoost, comparative ML evaluation on network anomaly datasets.",
    doi_url: "",
    position: 2
  },
  {
    title: "Harnessing Transformer-Based Deep Learning for Online Discourse Classification in Indonesia: A Comparative Study of RoBERTa and IndoBERT Models",
    publisher: "IEEE",
    publication_date: "May 2026",
    description: "Comparative study of transformer models (RoBERTa vs IndoBERT) for classifying Indonesian online discourse.",
    methods: "RoBERTa, IndoBERT, transformer fine-tuning, text classification.",
    doi_url: "",
    position: 3
  }
]
publications.each { |p| Publication.create!(p) }
puts "✅ Seeded #{Publication.count} publications."

# ----------------------------------------------------------------------------
# Leadership & Organizations (PRD §29)
# ----------------------------------------------------------------------------
LeadershipExperience.delete_all
leaderships = [
  {
    role: "Learning and Training Staff",
    organization: "Bina Nusantara Computer Club",
    position: 1,
    highlights: [
      "Designed and delivered learning materials for club members.",
      "Supported technical training sessions and workshops."
    ]
  },
  {
    role: "Product and Curriculum Core Team",
    organization: "Google Developer Group on Campus BINUS @Malang",
    position: 2,
    highlights: [
      "Shaped product and curriculum direction for community programs.",
      "Coordinated sessions bridging developers and learners."
    ]
  },
  {
    role: "Freshmen Leader and Freshmen Partner",
    organization: "First Year Program B2028, Student Development Center BINUS @Malang",
    position: 3,
    highlights: [
      "Guided incoming students through their first-year transition.",
      "Coordinated peer-support activities and onboarding."
    ]
  }
]
leaderships.each { |l| LeadershipExperience.create!(l) }
puts "✅ Seeded #{LeadershipExperience.count} leadership experiences."

# ----------------------------------------------------------------------------
# Certifications & Awards (PRD §30)
# ----------------------------------------------------------------------------
Certification.delete_all
certifications = [
  { name: "Back-End Development", issuer: "Bina Nusantara Computer Club", position: 1 },
  { name: "Azure AI Fundamentals", issuer: "Microsoft", position: 2 },
  { name: "Data Visualization", issuer: "FreeCodeCamp", position: 3 },
  { name: "Machine Learning with Python", issuer: "FreeCodeCamp", position: 4 }
]
certifications.each { |c| Certification.create!(c) }
puts "✅ Seeded #{Certification.count} certifications."

Award.delete_all
awards = [
  { name: "Finalist — The Idea Business Pitching Competition", issuer: "2024", position: 1 },
  { name: "Finalist — Electra 12 National Olympiad", issuer: "2023", position: 2 }
]
awards.each { |a| Award.create!(a) }
puts "✅ Seeded #{Award.count} awards."
end
