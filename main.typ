#set document(
  title: "My Resume",
  author: "Alexander Krantz <alex@krantz.dev>",
  keywords: ("resume", "cv"),
)
#set page(
  paper: "a4",
  margin: (x: 0.5cm, y: 0.75cm),
)
#set text(
  size: 8pt,
  font: "Montserrat",
)

#set list(indent: 1em, marker: [--])
#show link: underline
#show link: set underline(offset: 3pt)

#import "template/common.typ": section
#import "template/education.typ": entry, education
#import "template/heading.typ": header

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
    details: (
      "GPA: 93%",
      "Coursework: Web Development I & II, Programming Methods, Business Analysis and System Design",
    ),
  ),
  (
    school: "University of British Columbia",
    degree: "Bachelor's of Applied Science",
    area: "Electrical Engineering",
    start: datetime(year: 2020, month: 9, day: 1),
    end: datetime(year: 2023, month: 12, day: 31),
    location: "Vancouver, BC, Canada",
    details: (
      "Major: Electrical Engineering (unfinished)",
    ),
  )
)

#section("Experience")
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      *Sanctuary AI*, _Systems Integration Intern_ \
      #list(
        "Declaratively created a collection of continuous deployment pipelines on AWS to deploy two services across multiple accounts, ensuring the separation of environments using AWS CDK and CodePipelines.",
        "Removed all usages of static AWS credentials in favor of assume role credentials to increase security.",
        "Reduced the size of a service's container by 85% and sped up its startup time by 100 times.",
      )
    ],
    align(right)[
      Sept - Dec 2023 \
      _Vancouver, BC, Canada_
    ],
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      *Shopify*, _Payments Infrastructure, Backend Developer Intern_ \
      #list(
        "Made a parameter optional across the service to reduce data duplication and streamline usage for clients.",
        "Assisted in preparing the service for scaling to Black Friday/Cyber Monday traffic spikes by performing load tests and validating and updating Grafana alerts.",
        "Prevented potential fines from NACHA by handling account errors in ACH return transaction processing.",
      )
    ],
    align(right)[
      May - Aug 2023 \
      _Vancouver, BC, Canada_
    ],
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      *Shuttle*, _Open Source Contractor_ \
      #list(
        "Discovered a vulnerability that allowed remote code execution and full database access via SQL injection.",
        "Designed and implemented a system that issues TLS certificates for custom domains using LetsEncrypt.",
      )
    ],
    align(right)[
      Oct 2022 - Feb 2023 \
      _Vancouver, BC, Canada_
    ],
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      *Shopify*, _Shopify Fulfillment Network, Backend Developer Intern_ \
      #list(
        "Minimized shipping time for packages by selecting carriers based on historical performance data.",
        "Improved error handling for parcel carriers not supporting tracking created labels.",
        "Added strict typing to the codebase using Sorbet to improve developer experience and prevent errors.",
      )
    ],
    align(right)[
      May - Aug 2022 \
      _Redwood City, CA, USA_
    ],
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (80%, 20%),
    align(left)[
      *InfluxData*, _Software Engineering Intern_ \
      #list(
        "Maintained an open-source data acquisition tool called Telegraf written in Go.",
        "Implemented upwards of 25 bug fixes and features concerning Telegraf's interaction with databases, cloud services, and deployment solutions.",
        "Interacted with community developers to resolve issues and pull requests on GitHub.",
      )
    ],
    align(right)[
      May - Sept 2021 \
      _Redwood City, CA, USA_
    ],
  )
}

#section("Volunteering")
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (3fr, 1fr),
    align(left)[
      *WaffleHacks*, _Director of Technology_ \
      #list(
        "Developed and deployed a custom application portal using Python and TypeScript that was utilized by 1000s of participants over 4 events.",
        "Leveraged OpenTelemetry for distributed tracing to reduce P99 latency by 250ms and detect issues and service disruptions via configured alerting.",
        "Coordinated a team of 4 developers to build an application portal, Discord bot, and website.",
      )
    ],
    align(right)[
      Feb 2021 - present \
      _Remote US & Canada_
    ],
  )
}

#section("Projects")
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (90%, 10%),
    align(left)[ *lers*, _An asynchronous, user-friendly ACME client_ ],
    align(right)[ May 2023 ],
  )
  pad(left: 1em, top: -0.5em)[Languages: Rust]
  list(
    "Implements the full RFC 8555 specification, including external account bindings",
    "Provides robust, bundled challenge solvers for the HTTP-01, DNS-01, and TLS-ALPN-01 challenges",
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (90%, 10%),
    align(left)[ *DAVOxide*, _A simple WebDAV server with a basic web UI, authentication, and authorization_ ],
    align(right)[ Jul - Aug 2022 ],
  )
  pad(left: 1em, top: -0.5em)[Languages: Rust, TypeScript]
  list(
    "Read-only access to files through a web UI using GraphQL",
    "Directory- and file-level permissions for each user backed by a custom authorization system",
  )
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (88%, 12%),
    align(left)[ *Lights*, _Internet-controlled LEDs for my dorm running on a Raspberry Pi 4_ ],
    align(right)[ Sept - Nov 2022 ],
  )
  pad(left: 1em, top: -0.5em)[Languages: Rust, Golang, TypeScript]
  list(
    "Real-time control and viewing from anywhere in the world using WebSockets and Redux.",
    "Implemented presets, schedules, and custom animations using WebAssembly modules.",
  )
}

#section("Awards")
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left)[ *Best Startup by YCombinator*, _TreeHacks 2023_ ],
    align(right)[Feb 2023],
  )
  pad(left: 1em, top: -0.5em, box(width: 90%)[
    Developed a web-based tool called #link("https://devpost.com/software/cognito-uf3rs1", "Cognito") with a 
    friend. It is a platform that uses AI combined with natural language queries to provide companies insight 
    into their customers, audiences, potential leads using publicly available data.
  ])
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left)[ *1st Place*, _FrontierHacks_ ],
    align(right)[Nov 2019],
  )
  pad(left: 1em, top: -0.5em, box(width: 90%)[
    Developed a hardware and software solution called #link("https://devpost.com/software/atomicnet")[AtomicNet] 
    to prevent internet outages in a team of 4. The project uses low-cost, low-power Rasperry Pis to route 
    internet traffic between each other to an internet-connected endpoint, ensuring that internet outages are 
    minimized. The software component is a suite of applications that proide basic chat, forums, and information 
    sharing functionality.
  ])
}
#{
  set block(above: 0.7em, below: 1em)
  grid(
    columns: (85%, 15%),
    align(left)[ *Eagle Scout*, _Boy Scouts of America_ ],
    align(right)[Jan 2019],
  )
}

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

#place(bottom + right, dy: 1.5em, block[
  #set text(size: 4pt, font: "Fira Code Retina")
  Last updated on #datetime.today().display()
])
