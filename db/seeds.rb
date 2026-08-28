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

# ----------------------------------------------------------------------------
# Real portfolio projects added 2026-08 (appended; 4 defaults above preserved).
# All non-featured, ordered by position 5..11.
# ----------------------------------------------------------------------------
projects.each { |p| Project.create!(p) }

puts "✅ Seeded #{Project.count} projects."

# ----------------------------------------------------------------------------
# Real portfolio projects added 2026-08 (appended; runs every seed, idempotent by
# title so it does not wipe the 4 defaults or duplicate on repeat runs). All
# non-featured, ordered by position.
# ----------------------------------------------------------------------------
APPENDED_PROJECTS = [
  {
    title: "Pacman Reimagined",
    category: "software_dev",
    category_label: "Software Development",
    short_description: "A Java-based arcade game project that combines object-oriented programming with AI-driven gameplay mechanics.",
    description: "Pacman Reimagined is a remake of the classic arcade game developed using Java and LibGDX. The project applies object-oriented programming principles to structure game entities, gameplay mechanics, and interactions while integrating persistent data storage for player information and high scores.",
    role: "Game Developer",
    problem: "The project required recreating a familiar arcade gameplay experience while maintaining a structured and extensible software architecture.",
    solution: "Developed a Pacman-inspired game using object-oriented programming principles and LibGDX. Gameplay components were organized into reusable entities and systems, while MySQL provided persistent storage for player records and high scores.",
    tech_details: "Implemented the game using Java and LibGDX with object-oriented architecture for game entities and gameplay logic. MySQL was integrated to store player names and high-score information, while Gradle was used for dependency management and project builds.",
    tech_stack: ["Java", "LibGDX", "MySQL", "Gradle"],
    github_url: "https://github.com/CicakBelanda/Pacman-Reimaginated-LibGDX",
    demo_url: "",
    project_date: "2024",
    featured: false,
    position: 5
  },
  {
    title: "DiddySec",
    category: "software_dev",
    category_label: "Machine Learning · Cybersecurity · Software Development",
    short_description: "A real-time network monitoring system that analyzes network traffic to detect potential DDoS attacks using machine learning.",
    description: "DiddySec is a network security monitoring tool designed to detect suspicious network traffic and potential DDoS attacks. The system combines packet capture, traffic analysis, and machine learning to identify abnormal network behavior and present monitoring results through a web interface.",
    role: "Machine Learning & Front-End Developer",
    problem: "Traditional network monitoring can make it difficult to identify abnormal traffic patterns quickly, particularly when large volumes of network traffic need to be analyzed in real time.",
    solution: "Built a monitoring pipeline that captures network packets, extracts traffic characteristics, and applies machine learning-based anomaly detection. The resulting information is presented through a web-based monitoring dashboard.",
    tech_details: "Implemented a network traffic monitoring pipeline using TShark for packet capture and preprocessing. Machine learning models, including XGBoost, were integrated into the detection workflow, with Flask providing backend services and SvelteKit supporting the monitoring interface.",
    tech_stack: ["Python", "scikit-learn", "XGBoost", "TShark", "Flask", "SvelteKit"],
    github_url: "https://github.com/CicakBelanda/DiddySec-AI-Based-DDoS-Detector",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 6
  },
  {
    title: "Suntik.In",
    category: "data_science",
    category_label: "Cloud Computing",
    short_description: "A cloud-based immunization management platform designed to manage vaccination records and scheduling using AWS services.",
    description: "Suntik.In is a cloud-based immunization management system designed to improve the management of vaccination records and schedules. The system leverages cloud infrastructure and database technologies to provide centralized access to immunization information while supporting scalable data management.",
    role: "Data Scientist",
    problem: "Immunization records and schedules can become difficult to manage when information is distributed across different systems and requires reliable access at scale.",
    solution: "Designed a centralized cloud-based immunization management system using AWS infrastructure to support vaccination records, scheduling, and data access.",
    tech_details: "Designed a cloud-based architecture for managing immunization records and scheduling. The system focuses on centralized data management, scalable infrastructure, secure access, and supporting analytics for healthcare-related information.",
    tech_stack: ["Amazon Web Services", "Cloud Computing"],
    github_url: "https://github.com/CicakBelanda/Suntik.In-Cloud-Based-Immunization-Management-System-AWS",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 7
  },
  {
    title: "Human Development Index (HDI) in Indonesia 2024",
    category: "data_science",
    category_label: "Data Science",
    short_description: "A data analysis and visualization project exploring regional disparities and human development trends across Indonesia.",
    description: "This project examines Indonesia's Human Development Index using regional socioeconomic data. The analysis combines data collection, preprocessing, exploratory analysis, and visualization to investigate differences in education, income, and health indicators across Indonesian provinces.",
    role: "Data Analyst",
    problem: "Indonesia's human development outcomes vary across regions, making it difficult to understand disparities using a single national-level indicator.",
    solution: "Analyzed provincial-level HDI data and related socioeconomic indicators to identify regional patterns in education, health, and income. The results were transformed into visual insights to make regional differences easier to interpret.",
    tech_details: "Collected and consolidated data from multiple online sources, performed data cleaning and preprocessing, and analyzed regional HDI indicators. Findings were presented through an analytical poster using R and R Markdown.",
    tech_stack: ["R", "R Markdown", "Plotly"],
    github_url: "https://github.com/CicakBelanda/Human-Development-Index-Indonesia-2024",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 8
  },
  {
    title: "Performance Evaluation of Bank's Marketing Campaign",
    category: "data_science",
    category_label: "Data Science",
    short_description: "A data mining and visualization project analyzing customer responses to evaluate the effectiveness of a bank's marketing campaign.",
    description: "This project analyzes customer and campaign data to identify factors associated with marketing outcomes. Data mining techniques were combined with statistical analysis and interactive visualization to uncover customer response patterns and generate actionable insights for future campaigns.",
    role: "Data Analyst",
    problem: "The bank needed to understand which customer characteristics and previous interactions were associated with successful marketing campaign responses.",
    solution: "Analyzed campaign data using data mining techniques and interactive visualizations to identify customer behavior patterns. The analysis focused on factors related to subscription outcomes and previous customer interactions.",
    tech_details: "Performed data preprocessing, exploratory analysis, customer segmentation and visualization using R. Interactive Plotly visualizations were used to examine subscription behavior and compare campaign outcomes across customer characteristics.",
    tech_stack: ["R", "R Markdown", "Plotly"],
    github_url: "",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 9
  },
  {
    title: "NeuroLens",
    category: "software_dev",
    category_label: "Machine Learning",
    short_description: "A machine learning application that predicts personality types from behavioral traits using Support Vector Machine classification.",
    description: "NeuroLens is a Python and Streamlit-based personality assessment application that uses behavioral trait data to predict personality types. The system applies a Support Vector Machine (SVM) classifier and provides the prediction through an interactive web interface.",
    role: "Machine Learning Developer",
    problem: "Personality assessment can require manual interpretation of behavioral characteristics, making the process time-consuming and difficult to scale.",
    solution: "Developed a machine learning classification system that maps behavioral traits to personality predictions using an SVM model. The trained model was integrated into a Streamlit application to provide an accessible interface for real-time assessment.",
    tech_details: "Developed a classification pipeline using behavioral trait data, including data preprocessing, model training, evaluation, and integration into a Streamlit interface for interactive personality prediction.",
    tech_stack: ["Python", "scikit-learn", "SVM", "Streamlit", "Pandas"],
    github_url: "https://github.com/CicakBelanda/NeuroLens-Behavioral-Trait-Based-Personality-Detection",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 10
  },
  {
    title: "SUMA AI",
    category: "software_dev",
    category_label: "Machine Learning · NLP",
    short_description: "An end-to-end AI summarization system that transforms long-form news articles and video content into concise, structured summaries.",
    description: "SUMA AI is an AI-powered content summarization system designed to process both text-based news articles and video content. The system integrates OpenAI Whisper for automatic speech-to-text transcription and a fine-tuned BART transformer model for abstractive summarization. The complete NLP pipeline covers content preprocessing, transcription, model inference, and structured summary generation.",
    role: "Machine Learning & Back-End Developer",
    problem: "Long-form news articles and video content require significant time to consume and process. Video content also requires an additional transcription step before it can be analyzed or summarized automatically.",
    solution: "Developed an end-to-end AI summarization pipeline capable of handling both text and video inputs. OpenAI Whisper was used for automatic speech-to-text transcription, while a fine-tuned BART transformer generated concise, context-aware abstractive summaries. The components were integrated into a unified backend pipeline for automated content processing.",
    tech_details: "Built an end-to-end NLP pipeline capable of processing multiple content formats. OpenAI Whisper was integrated to transcribe video audio into text, while a fine-tuned BART transformer model generated abstractive summaries from long-form content. The backend pipeline handles preprocessing, transcription, model inference, and structured summary generation.",
    tech_stack: ["Python", "PyTorch", "BART", "Transformers", "OpenAI Whisper"],
    github_url: "https://github.com/CicakBelanda/SUMA-AI-Deep-Learning-Final-Project",
    demo_url: "",
    project_date: "2025",
    featured: false,
    position: 11
  }
]

APPENDED_PROJECTS.each do |attrs|
  next if Project.exists?(title: attrs[:title])   # idempotent: skip if already present
  Project.create!(attrs)
end
puts "✅ Ensured #{APPENDED_PROJECTS.size} appended projects present (idempotent)."

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
