#import "@preview/diatypst:0.9.3": *
#let meta = json("../../../misc/metadata.json")
#show: slides.with(
  title: [Real-World AI Application: \ Autonomous Vehicles],
  date: "Artificial Intelligence \nALA - I",
  authors: meta.name + "\n" + meta.roll_no,
  title-color: blue.darken(40%),
  ratio: 16 / 9,
  layout: "medium",
  toc: true,
  count: "dot",
  footer: false,
  theme: "normal",
)

// Custom helper components for consistent polished styling
#let badge(body, fill: rgb("e2e8f0"), text-color: rgb("1e293b")) = [
  #box(
    fill: fill,
    inset: (x: 8pt, y: 4pt),
    radius: 12pt,
    baseline: 0%,
    text(fill: text-color, size: 8pt, weight: "bold", body),
  )
]

#let card(title, body, fill: rgb("f8fafc"), stroke-color: rgb("cbd5e1"), title-color: blue.darken(40%)) = [
  #box(
    fill: fill,
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    stroke: 1pt + stroke-color,
    [
      #text(weight: "bold", fill: title-color, size: 10.5pt, title)
      #v(0.3em)
      #text(size: 9pt, body)
    ],
  )
]

= \\\\ Overview

== SAE Autonomy Spectrum

Autonomous Vehicles (AVs) represent one of the most complex real-world integrations of Artificial Intelligence, combining *computer vision*, *sensor fusion*, *deep learning*, and *real-time control* in safety-critical physical environments.

#v(0.4em)

#table(
  columns: (.5fr, .8fr, 2.2fr),
  fill: (x, y) => if y == 0 { blue.lighten(85%) } else if y == 3 { rgb("dbeafe") } else if calc.even(y) {
    rgb("f8fafc")
  } else { white },
  stroke: 0.5pt + luma(180),
  align: (center + horizon, left + horizon, left + horizon),
  [*SAE Level*], [*Classification*], [*Human vs. AI Operational Boundary*],
  [Level 0 - 2], [Driver Assistance], [Human actively drives; AI provides warnings, lane keep, or ACC],
  [Level 3], [Conditional Automation], [AI drives under specific conditions; Human fallback mandatory],
  [*Level 4*], [*High Automation*], [*AI drives completely within defined geofenced zones*],
  [Level 5], [Full Automation], [AI operates in all weather, roads, and conditions worldwide],
)

#v(0.4em)
#box(fill: blue.lighten(92%), inset: 9pt, radius: 5pt, stroke: 0.5pt + blue.darken(20%))[
  *Architectural Shift:* Moving from Level 2+ to Level 4 requires eliminating human fallback, demanding *fail-operational hardware redundancy* and *99.9999% perception reliability*.
]

= \\\\ Hardware Infrastructure

== Multi-Modal Sensor Suite

#v(0.3em)

#grid(
  columns: (1fr, 2fr),
  gutter: 14pt,
  [
    #image("assets/av_sensor_suite.jpg", width: 100%)
  ],
  [
    #grid(
      columns: (1fr, 1fr),
      gutter: 8pt,
      card(
        "LiDAR (905 / 1550 nm)",
        [
          Fires millions of laser pulses/sec to build 3D point clouds at 10-20 Hz. Complete lighting independence.
        ],
        fill: rgb("f8fafc"),
        stroke-color: rgb("cbd5e1"),
      ),
      card(
        "Radar (77-79 GHz)",
        [
          Measures target velocity & distance via Doppler shift up to 300m+. Pierces fog, heavy rain, and dust.
        ],
        fill: rgb("f8fafc"),
        stroke-color: rgb("cbd5e1"),
      ),

      card(
        "Cameras (8-12 MP)",
        [
          HDR 120dB+ optical vision to decode traffic signals, lane markers, and semantic road sign text.
          \
          \
        ],
        fill: rgb("f8fafc"),
        stroke-color: rgb("cbd5e1"),
      ),
      card(
        "Ultrasonic & Audio",
        [
          Near-field sonar proximity mapping (under 5m) & acoustic siren directional detection for emergency vehicles.
        ],
        fill: rgb("f8fafc"),
        stroke-color: rgb("cbd5e1"),
      ),
    )
  ],
)
A Level 4 Autonomous Vehicle relies on a *multi-modal sensor suite* to construct a continuous 360-degree 3D digital twin of surrounding road environments.


== Hardware Synchronization Mechanics

Real-time fusion of multi-modal sensors requires microsecond-level hardware time-stamping, high-speed data buses, and active environmental resilience.

#v(0.4em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  card(
    "1. Microsecond Time-Sync",
    [
      - *PTP (IEEE 1588v2)* hardware time-stamping.
      - Synchronizes camera exposure shutters and LiDAR laser sweeps under $< 100 mu s$ to eliminate motion blur artifacts.

    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
  card(
    "2. High-Bandwidth Bus",
    [
      - *10GBASE-T1 Automotive Ethernet* streaming over $2.5 text(" GB/s")$ of raw uncompressed sensor data.
      - Low-latency PCIe Gen4 interconnects to onboard TPU/GPU compute cluster.
    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
  card(
    "3. Fail-Operational Redundancy",
    [
      - Dual isolated power buses and redundant CAN networks.
      - Active sensor cleaning (heated lenses, fluid jets, and forced air purging).

    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
)

#v(0.6em)
#box(fill: blue.lighten(92%), inset: 9pt, radius: 4pt, stroke: 0.5pt + blue.darken(20%))[
  *Hardware Integrity:* Fail-operational architecture ensures that even if an individual sensor or compute node experiences physical failure, secondary systems maintain safe operational control.
]

== Sensor Modality Comparison

No single sensor modality is sufficient for full autonomy. \ Sensor redundancy compensates for inherent physical limitations.

#v(0.3em)

#table(
  columns: (1.2fr, 1fr, 1fr, 1.2fr, 1.2fr),
  fill: (x, y) => if y == 0 { blue.lighten(85%) } else if calc.even(y) { rgb("f8fafc") } else { white },
  stroke: 0.5pt + luma(180),
  align: (center + horizon, center + horizon, center + horizon, center + horizon, center + horizon),
  [*Sensor Modality*], [*3D Spatial Res.*], [*Max Range*], [*Adverse Weather*], [*Color and Text*],
  [*LiDAR*], [Very High (cm)], [250m - 300m], [Moderate], [No],
  [*Radar*], [Low], [300m+], [*Excellent*], [No],
  [*Camera*], [*Highest (2D)*], [150m - 200m], [Poor (Glare/Fog)], [*Yes*],
  [*Ultrasonic*], [Low], [< 10m], [Good], [No],
)

#v(0.5em)
#align(center)[
  #badge("MULTI-SENSOR FUSION", fill: rgb("fef3c7"), text-color: rgb("92400e"))
  #h(6pt)
  #text(
    size: 9.5pt,
  )[\ Combines point clouds, radar tensors, and optical RGB framesinto a unified 3D spatio-temporal scene graph.]
]

== 3D LiDAR Perception

#grid(
  columns: (1fr, 1.1fr),
  gutter: 14pt,
  [
    #image("assets/lidar.jpg", width: 100%)
  ],
  [
    #v(-0.2em)
    #badge("POINT CLOUD PROCESSING", fill: rgb("fae8ff"), text-color: rgb("86198f"))
    #v(0.4em)

    _Dense 3D point cloud processing requires specialized neural network architectures designed for sparse 3D spatial data._

    - *Voxelization and 3D Convolutions:* Converts unstructured LiDAR points into regular 3D grid voxels or pillars (*PointPillars*, *VoxelNet*).
    - *3D Object Bounding Boxes:* Predicts $(x, y, z)$ position, dimension, heading angle, and velocity for all surrounding actors.
    - *Semantic Segmentation:* Classifies every point in space (differentiating drivable road surface from curbs and vegetation).
  ],
)

= \\\\ Software Pipeline

== Real-Time Sensor Fusion

The AI software pipeline converts multi-gigabit/sec raw sensor streams into high-confidence environmental comprehension.

#v(0.3em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  card(
    "1. Sensor Ingestion",
    [
      - Camera RGB frames
      - LiDAR 3D Point Clouds
      - Radar Doppler tensors
      - IMU / Odometry data
    ],
    fill: rgb("f1f5f9"),
    stroke-color: rgb("cbd5e1"),
  ),
  card(
    "2. Deep Neural Processing",
    [
      - *3D Bounding Boxes*: PointPillars / CenterPoint
      - *Segmentation*: Mask R-CNN
      - *Tracking*: Kalman Filters + Deep SORT
    ],
    fill: rgb("e0f2fe"),
    stroke-color: rgb("38bdf8"),
  ),
  card(
    "3. Sensor Fusion Engine",
    [
      - *Early Fusion*: Feature-level concatenation
      - *Late Fusion*: Cross-verifying bounding box hypotheses
    ],
    fill: rgb("dbeafe"),
    stroke-color: rgb("3b82f6"),
  ),
)

#v(0.7em)
- *HD Map Centimeter Localization:* Real-time point clouds are aligned against pre-mapped 3D point cloud priors using Iterative Closest Point (ICP) and NDT algorithms to localize the car within 2 cm precision.

== Trajectory Motion Planning

Once objects are perceived, the AI must forecast future actor intent and safely plan smooth, legal vehicle trajectories.

#v(0.4em)

- *Behavioral Intent Prediction:*
  - Employs *Transformer Networks* and *Graph Neural Networks (GNNs)* to model multi-agent interactions.
  - Generates probabilistic trajectory distributions (e.g., 70% probability pedestrian waits, 30% crosses).

- *Trajectory Optimization and Motion Control:*
  - Evaluates candidate trajectories against *Cost Functions* balancing _Safety Buffer_, _Kinematic Feasibility_, _Passenger Comfort_, and _Progressive Velocity_.
  - Employs *Model Predictive Control (MPC)* for precise micro-second actuation steering and throttle signals.

#v(0.3em)
#box(fill: rgb("fef2f2"), inset: 8pt, radius: 4pt, stroke: 0.5pt + rgb("ef4444"))[
  *Safety Envelope Layer:* A deterministic rule-based safety monitor overrides neural net outputs if any trajectory violates distance buffers or traffic regulations.
]

== Architectural Paradigms

#grid(
  columns: (1fr, 1.1fr),
  gutter: 14pt,
  [
    #image("assets/waymo_vs_tesla.jpg", width: 100%)
  ],
  [
    #v(-0.2em)
    #badge("PHILOSOPHICAL COMPARISON", fill: rgb("ecfdf5"), text-color: rgb("065f46"))
    #v(0.4em)

    - *Waymo (Modular Stack):*
      - Uses LiDAR + Radar + Cameras + HD Maps.
      - Separate interpretable modules (Perception $->$ Prediction $->$ Planning).
      - *Pros:* High safety, explicit verification.

    - *Tesla (End-to-End Vision):*
      - Camera-only + Vision Transformers (ViT).
      - Single large neural net directly maps pixels to control signals.
      - *Pros:* Low hardware cost, scalable globally without HD Maps.
  ],
)

= \\\\ System Evaluation

== Key System Advantages

// #v(1em)

AI-driven autonomous driving offers profound safety, social accessibility, and environmental advantages.

#v(0.4em)

#grid(
  columns: (1fr, 1fr),
  gutter: 15pt,
  [
    #card(
      "1. Drastic Crash Reduction",
      [
        Human error causes ~94% of traffic accidents. AI eliminates driver fatigue, texting, intoxication, and road rage.
      ],
      fill: rgb("f0fdf4"),
      stroke-color: rgb("4ade80"),
    )

    // #v(6pt)

    #card(
      "2. Universal Accessibility",
      [
        Delivers on-demand mobility for senior citizens, visually impaired individuals, and non-drivers.
      ],
      fill: rgb("faf5ff"),
      stroke-color: rgb("c084fc"),
    )
  ],
  [
    #card(
      "3. Traffic and Fuel Efficiency",
      [
        Optimized acceleration/deceleration curves reduce energy consumption by 15-20% and prevent phantom traffic jams.
      ],
      fill: rgb("eff6ff"),
      stroke-color: rgb("60a5fa"),
    )

    // #v(6pt)

    #card(
      "4. Urban Land Reclamation",
      [
        Shared autonomous robotaxi fleets could eliminate up to 80% of urban parking space, unlocking land for parks and housing.
      ],
      fill: rgb("fff7ed"),
      stroke-color: rgb("fb923c"),
    )
  ],
)

== Technical Limitations

Despite impressive progress, autonomous driving faces severe technical and edge-case challenges.

#v(0.4em)

- *The "Long-Tail" Edge Case Problem:* Rare, unmapped scenarios—such as unusual construction layouts, erratic human gestures, or debris—are difficult for deep learning models to generalize.
- *Adverse Weather Degradation:* Dense fog, heavy snow, or torrential rain scatter LiDAR laser beams and blind optical lenses.
- *Compute and Thermal Limits:* Real-time processing of multi-gigabit/sec sensor data requires high-power onboard GPUs/TPUs and liquid cooling.

#v(0.4em)
#table(
  columns: (.7fr, 2.5fr),
  fill: (x, y) => if y == 0 { rgb("fee2e2") } else { white },
  stroke: 0.5pt + luma(180),
  [*Failure Category*], [*Technical Manifestation and Mitigation*],
  [Ghost Braking], [False-positive radar/camera detection causing sudden unexpected deceleration],
  [Occluded Vision], [Pedestrians stepping out from behind large parked vehicles],
  [HD Map Staleness], [Performance drop when real-world construction differs from stored HD maps],
)

= \\\\ Commercial Case Study

== Waymo Level 4 Architecture

#grid(
  columns: (1fr, 1.1fr),
  gutter: 12pt,
  [
    #image("assets/waymo_robotaxi.jpg", width: 100%)
  ],
  [
    #badge("WAYMO DRIVER 5TH / 6TH GEN", fill: rgb("e0f2fe"), text-color: rgb("0369a1"))
    // #v(0.4em)

    _Waymo operates the world's premier commercial Level 4 Autonomous Robotaxi service across major US metropolitan areas._

    // #v(0.4em)

    *Hardware Specification:*
    - 29 Optical Cameras (360° overlapping coverage)
    - 5 LiDAR Sensors (perimeter & long-range dome)
    - High-resolution imaging radar arrays
    - Dual fail-operational compute architecture

    #v(0.3em)
    *Scale and Mileage:*
    - Over *20 Million* fully autonomous commercial miles driven.
    - Operating in San Francisco, Phoenix, Los Angeles, and Austin.
  ],
)

== Empirical Safety Benchmarks

Independent comparative studies across 20+ million driverless miles demonstrate substantial safety improvements over human driver baselines.

#v(0.4em)

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #box(fill: rgb("f0fdf4"), inset: 10pt, radius: 8pt, stroke: 1.5pt + rgb("22c55e"))[
      #align(center)[
        #text(size: 22pt, weight: "bold", fill: rgb("15803d"))[85% Lower]
        \
        #v(0.1em)
        #text(weight: "bold", size: 10pt)[Bodily Injury Crash Rate]
        \
        #v(0.2em)
        #text(size: 8pt, fill: rgb("374151"))[Injury-causing crashes reduced by over 6.8x compared to human benchmarks.]
      ]
    ]
    #box(fill: rgb("fdf4ff"), inset: 10pt, radius: 8pt, stroke: 1.5pt + rgb("a855f7"))[
      #align(center)[
        #text(size: 22pt, weight: "bold", fill: rgb("7e22ce"))[91% Lower]
        \
        #v(0.1em)
        #text(weight: "bold", size: 10pt)[Vulnerable Road User Crashes]
        \
        #v(0.2em)
        #text(
          size: 8pt,
          fill: rgb("374151"),
        )[Drastic safety gains for pedestrians, cyclists, and micro-mobility riders.]
      ]
    ]
  ],
  [
    #box(fill: rgb("eff6ff"), inset: 10pt, radius: 8pt, stroke: 1.5pt + rgb("3b82f6"))[
      #align(center)[
        #text(size: 22pt, weight: "bold", fill: rgb("1d4ed8"))[57% Lower]
        \
        #v(0.1em)
        #text(weight: "bold", size: 10pt)[Police-Reported Crashes]
        \
        #v(0.2em)
        #text(size: 8pt, fill: rgb("374151"))[Significant reduction in overall incidents including low-speed contacts.]
      ]
    ]
    #box(fill: rgb("fff7ed"), inset: 10pt, radius: 8pt, stroke: 1.5pt + rgb("f97316"), width: 221pt)[
      #align(center)[
        #text(size: 22pt, weight: "bold", fill: rgb("c2410c"))[84% Lower]
        \
        #v(0.1em)
        #text(weight: "bold", size: 10pt)[Airbag Deployment Events]
        \
        #v(0.2em)
        #text(size: 8pt, fill: rgb("374151"))[High-severity kinetic impact events near-entirely mitigated. \ \ ]
      ]
    ]
  ],
)

== Benchmark Normalization & Severity Analysis

To ensure scientific rigor, autonomous safety performance is evaluated against geographically matched human baselines.

#v(0.4em)

#grid(
  columns: (1.1fr, 1.3fr),
  gutter: 12pt,
  [
    #card(
      "Actuarial Benchmark Methodology",
      [
        - *Location Matching:* Human baseline data filtered by exact ZIP codes where robotaxis operate (SF, Phoenix, LA).
        - *Exposure Weighting:* Adjusted for road geometry, speed limits, and time-of-day traffic density.
        - *Elimination of Human Factors:* Zero incidents caused by intoxication, texting, fatigue, or aggressive driving.
      ],
      fill: rgb("f8fafc"),
      stroke-color: rgb("cbd5e1"),
    )
  ],
  [
    #table(
      columns: (1.4fr, 1fr, 1fr),
      fill: (x, y) => if y == 0 { rgb("e0f2fe") } else if calc.even(y) { rgb("f8fafc") } else { white },
      stroke: 0.5pt + luma(180),
      [*Incident Severity*], [*Human Baseline*], [*Level 4 AV*],
      [Bodily Injury / M-V], [2.78 / M miles], [0.41 / M miles],
      [Police Reported], [4.85 / M miles], [2.10 / M miles],
      [VRU Collisions], [0.62 / M miles], [0.05 / M miles],
      [Airbag Deployments], [0.38 / M miles], [0.06 / M miles],
    )
  ],
)

= \\\\ Future Horizon

== Regulatory Frameworks

Deploying autonomous systems on public roads introduces complex moral, regulatory, and security challenges.

#v(0.4em)

- *Ethical Dilemmas and Moral Algorithms:*
  - In unavoidable accident situations, how should AI prioritize risk between vehicle occupants and external pedestrians?
  - Prioritizes rule-based safety guarantees over uninterpretable neural network outputs.

- *Legal and Regulatory Frameworks:*
  - Shifting legal responsibility from human drivers to *manufacturer software liability*.
  - Establishing standardized safety validation frameworks and federal AV certification.

- *Cybersecurity and Adversarial Risks:*
  - Defending against physical adversarial attacks (e.g., sticker patterns on stop signs misleading optical classifiers).
  - Encrypted Over-The-Air (OTA) updates backed by hardware root-of-trust modules.

== Autonomous Industry Trajectory

The next decade will see autonomous driving expand from urban robotaxis to nationwide freight logistics.

#v(0.5em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 10pt,
  card(
    "1. V2X Mesh Networks",
    [
      Direct 5G vehicle-to-everything communication with traffic lights and infrastructure to see around physical corners.
    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
  card(
    "2. Autonomous Trucking",
    [
      Long-haul interstate freight corridors operating 24/7, solving highway driver shortages and boosting supply chains.
    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
  card(
    "3. Path to Level 5",
    [
      Evolving from HD-map geofenced regions to zero-shot generalized driving across unmapped rural roads worldwide.
    ],
    fill: rgb("f8fafc"),
    stroke-color: rgb("cbd5e1"),
  ),
)

#v(0.7em)
#box(fill: blue.lighten(92%), inset: 9pt, radius: 4pt, stroke: 0.5pt + blue.darken(20%))[
  *Prediction:* The convergence of End-to-End Multimodal Transformers, custom AI silicon, and V2X networking will reshape global transportation over the next decade.
]

== Conclusion

#v(0.4em)

#table(
  columns: (1.2fr, 2fr, 2fr),
  fill: (x, y) => if y == 0 { blue.lighten(85%) } else if calc.even(y) { rgb("f8fafc") } else { white },
  stroke: 0.5pt + luma(180),
  align: (center + horizon, left + horizon, left + horizon),
  [*Performance Dimension*], [*Traditional Human Driver*], [*AI Autonomous System (Level 4)*],
  [Reaction Speed], [250 ms - 1500 ms], [*< 100 ms (Continuous multi-sensor)*],
  [Perception Horizon], [Forward cone (~120°)], [*360° Continuous 3D Point Cloud*],
  [Primary Error Cause], [Distraction, fatigue, alcohol], [Unseen long-tail edge cases, weather],
  [Safety Benchmark], [1.35M global annual fatalities], [*Up to 85% reduction in injury crashes*],
)

==
#pagebreak()

#v(7em)

#align(center)[
  #text(size: 64pt, weight: "bold", fill: blue.darken(50%))[Thank You!]
]
