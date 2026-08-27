# Seeds the four real portfolio projects from the PRD (§17). Content is
# grounded in the PRD's stated categories / technologies / emphasis — no
# invented metrics or achievements (PRD §53).

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
