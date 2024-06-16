#set document(
  title: "My Resume",
  author: "Alexander Krantz <alex@krantz.dev>",
  keywords: ("resume", "cv"),
)
#set page(
  paper: "a4",
  margin: (x: 0.5cm, top: 0.75cm, bottom: 0.5em),
)
#set text(
  size: 8pt,
  font: "Montserrat",
)

#set list(indent: 1em, marker: [--])
#show link: underline
#show link: set underline(offset: 3pt)

#import "template/awards.typ": awards
#import "template/common.typ": section
#import "template/education.typ": education
#import "template/experience.typ": experience
#import "template/heading.typ": header
#import "template/projects.typ": projects

#header("Alexander Krantz", (
  ( type: "email", email: "alex@krantz.dev" ),
  ( type: "phone", phone: "+1 778 873 1160" ),
  ( type: "website", text: "krantz.dev", url: "https://krantz.dev" ),
  ( type: "github", username: "akrantz01" ),
  ( type: "linkedin", username: "akrantz01" ),
))

#education(
  (
    school: "British Columbia Institute of Technology",
    degree: "Computer System Technology Diploma",
    start: datetime(year: 2024, month: 1, day: 8),
    end: datetime(year: 2026, month: 4, day: 30),
    location: "Vancouver, BC, Canada",
    gpa: "93%",
    courses: (
      "Web Development I & II",
      "Programming Methods",
      "Business Analysis and System Design",
    ),
  ),
  (
    school: "University of British Columbia",
    degree: "Bachelor's of Applied Science",
    area: "Electrical Engineering (unfinished)",
    start: datetime(year: 2020, month: 9, day: 8),
    end: datetime(year: 2023, month: 12, day: 23),
    location: "Vancouver, BC, Canada",
    courses: (
      "Introduction to Microcomputers",
      "Data Structures and Algorithms",
      "Symbolic Logic",
    ),
  )
)

#experience(
  (
    company: "Sanctuary AI",
    title: "Systems Integration Intern",
    start: datetime(year: 2023, month: 9, day: 1),
    end: datetime(year: 2023, month: 12, day: 31),
    location: "Vancouver, BC, Canada",
    highlights: (
      "Declaratively created a collection of continuous deployment pipelines on AWS to deploy two services across multiple accounts, ensuring the separation of environments using AWS CDK and CodePipelines.",
      "Removed all usages of static AWS credentials in favor of assume role credentials to increase security.",
      "Reduced the size of a service's container by 85% and sped up its startup time by 100 times.",
    ),
  ),
  (
    company: "Shopify",
    title: "Payments Infrastructure, Backend Developer Intern",
    start: datetime(year: 2023, month: 5, day: 1),
    end: datetime(year: 2023, month: 8, day: 31),
    location: "Vancouver, BC, Canada",
    highlights: (
      "Made a parameter optional across the service to reduce data duplication and streamline usage for clients.",
      "Assisted in preparing the service for scaling to Black Friday/Cyber Monday traffic spikes by performing load tests and validating and updating Grafana alerts.",
      "Prevented potential fines from NACHA by handling account errors in ACH return transaction processing.",
    ),
  ),
  (
    company: "Shuttle",
    title: "Open Source Contractor",
    start: datetime(year: 2022, month: 10, day: 1),
    end: datetime(year: 2023, month: 2, day: 28),
    location: "Vancouver, BC, Canada",
    highlights: (
      "Discovered a vulnerability that allowed remote code execution and full database access via SQL injection.",
      "Designed and implemented a system that issues TLS certificates for custom domains using LetsEncrypt.",
    ),
  ),
  (
    company: "Shopify",
    title: "Shopify Fulfillment Network, Backend Developer Intern",
    start: datetime(year: 2022, month: 5, day: 1),
    end: datetime(year: 2022, month: 8, day: 31),
    location: "Redwood City, CA, USA",
    highlights: (
      "Minimized shipping time for packages by selecting carriers based on historical performance data.",
      "Improved error handling for parcel carriers not supporting tracking created labels.",
      "Added strict typing to the codebase using Sorbet to improve developer experience and prevent errors.",
    ),
  ),
  (
    company: "InfluxData",
    title: "Software Engineering Intern",
    start: datetime(year: 2021, month: 5, day: 1),
    end: datetime(year: 2021, month: 9, day: 30),
    location: "Redwood City, CA, USA",
    highlights: (
      "Maintained an open-source data acquisition tool called Telegraf written in Go.",
      "Implemented upwards of 25 bug fixes and features concerning Telegraf's interaction with databases, cloud services, and deployment solutions.",
      "Interacted with community developers to resolve issues and pull requests on GitHub.",
    ),
  )
)

#experience(
  title: "Volunteering",
  (
    company: "WaffleHacks",
    title: "Director of Technology",
    start: datetime(year: 2021, month: 2, day: 1),
    location: "Remote US & Canada",
    highlights: (
      "Developed and deployed a custom application portal using Python and TypeScript that was utilized by 1000s of participants over 4 events.",
      "Leveraged OpenTelemetry for distributed tracing to reduce P99 latency by 250ms and detect issues and service disruptions via configured alerting.",
      "Coordinated a team of 4 developers to build an application portal, Discord bot, and website.",
    ),
  )
)

#projects(
  (
    title: "lers",
    description: "An asynchronous, user-friendly ACME client written in Rust",
    start: datetime(year: 2023, month: 3, day: 14),
    end: datetime(year: 2023, month: 3, day: 30),
    details: (
      "Implements the full RFC 8555 specification, including external account bindings.",
      "Provides robust, bundled challenge solvers for the HTTP-01, DNS-01, and TLS-ALPN-01 challenges.",
    ),
  ),
  (
    title: "DAVOxide",
    description: "A simple WebDAV server with a basic web UI, authentication, and authorization",
    start: datetime(year: 2022, month: 7, day: 21),
    end: datetime(year: 2022, month: 8, day: 13),
    details: (
      "A Rust-based class 1 WebDAV server implementing all required features of RFC 4918",
      "Read-only access to files through a web UI using GraphQL written in TypeScript using React.",
      "Directory- and file-level permissions for each user using an SSO proxy for authentication and database for authorization.",
    ),
  ),
  (
    title: "Lights",
    description: "Internet-controlled LEDs for my dorm running on a Raspberry Pi 4",
    start: datetime(year: 2021, month: 9, day: 30),
    end: datetime(year: 2022, month: 4, day: 3),
    details: (
      "Drives a strip of Adafruit NeoPixels with a Rasperry Pi 4 through a Rust-based library for GPIO control.",
      "Real-time control and viewing from anywhere in the world using Cloudflare Tunnels, a Golang-powered WebSockets server, and client-side synchronization through React and Redux.",
      "Implemented presets, schedules, and custom animations with WebAssembly modules loaded and executed on-demand.",
    ),
  ),
)

#awards(
  (
    name: "Best Startup by YCombinator",
    organization: "TreeHacks 2023",
    on: datetime(year: 2023, month: 2, day: 19),
    description: "Developed a web-based tool called #link(\"https://devpost.com/software/cognito-uf3rs1\")[Cognito] with a friend that uses AI combined with natural language queries to provide companies insight into their customers, audiences, potential leads using publicly available data.",
  ),
  (
    name: "1st Place",
    organization: "FrontierHacks",
    on: datetime(year: 2019, month: 11, day: 24),
    description: "Developed a hardware and software solution called #link(\"https://devpost.com/software/atomicnet\")[AtomicNet] to prevent internet outages in a team of 4. It uses low-cost, low-power Rasperry Pis to act as an alternative or more resilient internet, ensuring that internet outages are minimized. The software component is a suite of applications that proide basic chat, forums, and information sharing functionality.",
  ),
  (
    name: "Eagle Scout",
    organization: "Boy Scouts of America",
    on: datetime(year: 2019, month: 1, day: 8),
  )
)

#section("Skills")
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: 1fr,
    row-gutter: 1em,
    box[
      *Programming Languages*:
      Python, Rust, Go, TypeScript, Ruby, SQL, C, Java
    ],
    box[
      *Frameworks & Libraries*:
      React, Ruby on Rails, Next.js, Svelte, OpenTelemetry, Terraform
    ],
    box[
      *Tools & Technologies*:
      Amazon Web Serivces, Google Cloud Platform, Docker, Kubernetes, Linux, PostgreSQL, Redis, Git, GitHub Actions
    ],
  )
}

#place(bottom + right, dx: 1.5em, block[
  #set text(size: 4pt, font: "Fira Code Retina")
  Last updated on #datetime.today().display()
])
