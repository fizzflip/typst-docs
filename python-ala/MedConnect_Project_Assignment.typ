#set document(title: "IT Project Assignment: MedConnect", author: "Project Manager")
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2.5cm),
  // header: align(right)[#text(fill: luma(120))[IT Project Management Assignment]],
  footer: align(center)[#context counter(page).display("1 / 1", both: true)],
  numbering: "1",
)
#set text(font: "Magnisa Sans", size: 11pt)
// #set heading(numbering: "1.1")
#set par(justify: true)

#align(center)[
  #v(2em)
  #text(size: 24pt, weight: "bold", fill: rgb("#1a5276"))[MedConnect] \
  #v(1em)
  #text(size: 16pt, weight: "regular")[Patient Triage and Scheduling System] \
  #v(1.5em)
  // #text(size: 12pt, style: "italic")[Project Definition] \
  // #v(2em)
  #line(length: 60%, stroke: 1.5pt + rgb("#1a5276"))
  #v(2em)
]
#rect(
  width: 100%,
  fill: rgb("#f4f6f7"),
  stroke: 1pt + rgb("#d5d8dc"),
  radius: 4pt,
  inset: 12pt,
)[


  *Abstract* \
  This project proposes the development of "MedConnect," an integrated IT solution designed to address the significant administrative bottlenecks and operational inefficiencies currently plaguing outpatient medical clinics. Relying heavily on manual, phone-based scheduling processes, these clinics suffer from high administrative error rates, overwhelmed staff, and unoptimized physician schedules.

  MedConnect solves this business challenge by transitioning the clinic from a manual workflow to a highly automated, patient-centric digital platform. The project centers on building a secure web portal that facilitates real-time appointment self-scheduling, automated reminders, and seamless calendar management. Crucially, MedConnect introduces a digital triage system requiring patients to complete an intelligent symptom questionnaire prior to booking. This system utilizes decision-tree logic to flag high-urgency cases for immediate clinical review while auto-routing routine cases to standard availability slots.

  By implementing MedConnect, the target clinics can project an estimated 40% reduction in inbound scheduling calls, the near-total elimination of manual double-booking errors, and a vastly improved patient experience characterized by 24/7 accessibility and significantly shorter wait times for critical care.
]


#v(1em)

= Problem Identification

Small to medium-sized medical clinics frequently experience severe administrative bottlenecks due to manual, phone-based appointment scheduling. These inefficiencies result in poor patient experiences, burnout among administrative staff, and unoptimized resource allocation for medical professionals.

== Specific Challenges
- *Overwhelmed Staff:* Receptionists spend approximately 60-70% of their day managing phone calls, retrieving voicemails, and calling back patients, rather than assisting in-person patients and handling critical administrative tasks.
- *Inefficient Triage:* Patients often struggle to communicate the urgency of their symptoms over the phone. Medical receptionists, lacking clinical training, cannot effectively triage patients, leading to sub-optimal scheduling (e.g., urgent cases waiting too long, while routine check-ups consume prime slots).
- *Scheduling Errors:* Manual entry across disparate systems frequently leads to double-bookings, missed cancellations, and inefficient gaps in a physician's daily schedule, reducing the clinic's overall throughput and revenue.

#pagebreak()
= The Opportunity

The primary opportunity is to develop a secure, web-based application (MedConnect) that completely automates the scheduling process and introduces digital pre-appointment triage.

== Proposed System Features
1. *Patient Self-Scheduling Portal:* A secure interface allowing patients to view real-time calendar availability and book, modify, or cancel appointments independently.
2. *Intelligent Triage Logic:* A digital symptom questionnaire that patients must complete prior to confirming an appointment. The system uses clinical decision-tree algorithms to categorize the urgency of the visit.
4. *Data Management:* A streamlined backend database to store patient appointments, triage results, and scheduling logs efficiently.

#v(.5em)

= Project Summary
#rect(
  width: 100%,
  fill: rgb("#f4f6f7"),
  stroke: 1pt + rgb("#d5d8dc"),
  radius: 4pt,
  inset: 12pt,
)[
  *Key Stakeholders:* Clinic Administrators, Medical Staff (Physicians/Nurses), Receptionists, and Patients. \
  *Estimated Timeline:* 4 Months (Iterative SDLC) \
  *Core Technology Stack:* HTML/CSS with Jinja2 (Frontend), Python with Flask (Backend Server), SQLite (Database)
]
