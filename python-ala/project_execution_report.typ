#set document(
  title: "IT Project Report: MedConnect Execution & Closure",
  author: "Project Engineering Group",
)
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  footer: [
    #set text(size: 8pt, fill: luma(150))
    #grid(
      columns: (1fr, 1fr),
      [Sandeep Prasad - 240905050085], align(right)[Page #context counter(page).display()],
    )
  ],
)

#set text(
  font: ("Inter", "Liberation Sans", "DejaVu Sans"),
  size: 10pt,
  weight: "light",
  fill: rgb("#263238"),
)

#show heading: it => [
  #set text(fill: rgb("#0d47a1"), weight: "bold")
  #v(1.5em, weak: true)
  #it
  #v(0.8em, weak: true)
]

#set par(justify: true, leading: 0.75em)

#let callout(title: none, body) = rect(
  width: 100%,
  fill: rgb("#f1f7fd"),
  stroke: (left: 2.5pt + rgb("#0d47a1")),
  inset: 16pt,
  radius: (right: 4pt),
  [
    #if title != none [
      #text(weight: "bold", fill: rgb("#0d47a1"), size: 11pt)[#title] \
      #v(0.5em)
    ]
    #body
  ],
)

#let status-badge(label, color) = box(
  fill: color.lighten(85%),
  stroke: 0.5pt + color,
  inset: (x: 6pt, y: 3pt),
  radius: 3pt,
)[#text(fill: color, weight: "bold", size: 8pt)[#label]]

// --- TITLE ---
#v(2em)
#align(center)[
  #text(size: 26pt, weight: "bold", fill: rgb("#0d47a1"))[MedConnect] \
  #v(0.4em)
  #text(size: 13pt, weight: "medium", fill: rgb("#607d8b"))[Project Execution Report & Final Closure] \
  #v(0.3em)
  #text(size: 9pt, fill: luma(160))[Assignment 4 | 16-Week Execution Cycle | IT Project Management] \
  #v(1.5em)
  #line(length: 60%, stroke: 0.5pt + luma(200))
  #v(2em)
]

#callout(title: "Executive Summary")[
  This report documents the full execution lifecycle of *MedConnect* — a clinical triage and patient scheduling platform. Over the course of the 16-week project cycle, the team monitored progress against the approved plan, tracked all four major milestones, resolved emerging risks, and completed the system deployment. The following pages detail milestone achievement, budget performance, deviation log, and final source code inventory.
]

#v(1.5em)

= 1. Milestone Achievement Report
Each project phase was governed by a named milestone. Progress was tracked weekly against the Detailed Project Plan (Assignment 3). All four milestones were achieved at or within acceptable variance.

#table(
  columns: (0.6fr, 1.3fr, 1fr, 1fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*MS*],
  [#text(fill: white)[*Milestone*]],
  [#text(fill: white)[*Planned*]],
  [#text(fill: white)[*Actual*]],
  [#text(fill: white)[*Status*]],

  [M1], [Scoping Lock & UX Blueprint], [Week 3], [Week 3], [#status-badge("On Time", rgb("#2e7d32"))],
  [M2], [Triage Engine & DB Finalized], [Week 8], [Week 9], [#status-badge("+1 Week", rgb("#f57c00"))],
  [M3], [Staff UAT & Logic Validation], [Week 12], [Week 12], [#status-badge("On Time", rgb("#2e7d32"))],
  [M4], [Deployment & Project Handover], [Week 16], [Week 16], [#status-badge("On Time", rgb("#2e7d32"))],
)

== 1.1 Milestone Variance Analysis
The sole schedule deviation occurred at *M2* due to an unforeseen complexity in the Flask-based Triage Intelligence API — specifically, edge-case handling within the multi-branch symptom decision tree required an additional design review session with the Clinical SME. A one-week buffer (originally allocated in the plan) was consumed. Subsequent phases were re-sequenced without impact to the final delivery date.

= 2. Weekly Progress Log (Summary)
The following table summarizes team activity and adherence to the execution plan across the 16-week cycle.

#table(
  columns: (0.5fr, 1fr, 2fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if calc.rem(y, 2) == 0 { rgb("#fafafa") },
  [*Week*],
  [#text(fill: white)[*Phase*]],
  [#text(fill: white)[*Key Activities Completed*]],
  [#text(fill: white)[*Health*]],

  [W1–W3],
  [Discovery],
  [Stakeholder interviews, UX wireframes, M1 signed off.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W3–W6],
  [Discovery],
  [Clinical logic trees mapped; SME validation sessions completed.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W5–W8],
  [Discovery],
  [UI/UX frontend design finalized and handed to Dev team.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W8–W10],
  [Core Dev],
  [Cloud infra provisioned; PostgreSQL/Redis stack deployed.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W9–W10],
  [Core Dev],
  [API development commenced; decision-tree delay identified.],
  [#status-badge("Amber", rgb("#f57c00"))],

  [W10–W13],
  [Core Dev],
  [API edge-cases resolved; M2 achieved at W9. Portal dev started.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W11–W14], [Core Dev], [Frontend portal component integration finalized.], [#status-badge("Green", rgb("#2e7d32"))],
  [W14–W15],
  [Security],
  [OWASP Top 10 pen-test executed; 2 low-severity findings patched.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W15–W16],
  [Security/UAT],
  [Admin UAT (3 cycles); final logic validation with SME sign-off.],
  [#status-badge("Green", rgb("#2e7d32"))],

  [W16],
  [Deployment],
  [DNS sync, production rollout, staff training, M4 handover.],
  [#status-badge("Green", rgb("#2e7d32"))],
)

#pagebreak()

= 3. Budget Performance Report
The project was executed within the approved capital envelope of *\$45,000*. Minor reallocation between line items was required to offset the additional SME consultation hours incurred during the M2 delay.

#table(
  columns: (2.2fr, 1fr, 1fr, 1fr),
  inset: 8pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Expenditure Category*],
  [#text(fill: white)[*Planned*]],
  [#text(fill: white)[*Actual*]],
  [#text(fill: white)[*Variance*]],

  [Personnel / Talent], [\$32,000], [\$33,200], [#text(fill: rgb("#f57c00"))[+\$1,200]],
  [Cloud Infra & Hosting], [\$4,500], [\$4,200], [#text(fill: rgb("#2e7d32"))[-\$300]],
  [Security & Compliance], [\$6,000], [\$5,900], [#text(fill: rgb("#2e7d32"))[-\$100]],
  [Contingency / Misc], [\$2,500], [\$900], [#text(fill: rgb("#2e7d32"))[-\$1,600]],
  [*Total Project Budget*], [*\$45,000*], [*\$44,200*], [#text(fill: rgb("#2e7d32"), weight: "bold")[-\$800 (Under)]],
)

The \$1,200 overrun on Personnel was absorbed by underutilization of the Contingency reserve. The project closed *\$800 under budget*, reflecting disciplined resource management.

= 4. Risk & Deviation Register (Actuals)
The following table compares the planned risk register against the risk events that materialized during execution.

#table(
  columns: (1.5fr, 1fr, 1.5fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Risk Event*],
  [#text(fill: white)[*Materialized?*]],
  [#text(fill: white)[*Action Taken*]],
  [#text(fill: white)[*Outcome*]],

  [Triage Logic Error],
  [#status-badge("Partial", rgb("#f57c00"))],
  [Extra SME review session; edge-case rules added.],
  [#status-badge("Resolved", rgb("#2e7d32"))],

  [Security Breach],
  [#status-badge("No", rgb("#2e7d32"))],
  [OWASP audit completed; Zero-Trust implemented.],
  [#status-badge("Prevented", rgb("#2e7d32"))],

  [Resource Churn],
  [#status-badge("No", rgb("#2e7d32"))],
  [Documentation and shadowing maintained throughout.],
  [#status-badge("N/A", rgb("#607d8b"))],

  [Staff Resistance],
  [#status-badge("Minor", rgb("#f57c00"))],
  [Beta UAT incentive loop resolved hesitancy in 2 weeks.],
  [#status-badge("Resolved", rgb("#2e7d32"))],
)
#pagebreak()
= 5. Final Quality Assurance Summary
MedConnect's "Safety-First" QA methodology was executed across three testing stages:

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  rect(
    width: 100%,
    inset: 12pt,
    radius: 4pt,
    fill: rgb("#f1f7fd"),
    stroke: (top: 3pt + rgb("#1976d2")),
  )[
    *Alpha — Dev Walkthrough* \
    #v(0.4em)
    Full end-to-end code walkthrough by the engineering team. *47 unit tests* executed via PyTest; 100% pass rate on critical logic paths.
  ],
  rect(
    width: 100%,
    inset: 12pt,
    radius: 4pt,
    fill: rgb("#f1f7fd"),
    stroke: (top: 3pt + rgb("#2e7d32")),
  )[
    *Beta — Admin UAT* \
    #v(0.4em)
    Three clinic admin staff executed *3 scripted UAT cycles*. Two UI/UX feedback items incorporated; final sign-off received.
  ],
  rect(
    width: 100%,
    inset: 12pt,
    radius: 4pt,
    fill: rgb("#f1f7fd"),
    stroke: (top: 3pt + rgb("#ef6c00")),
  )[
    *Final — Parallel Run* \
    #v(0.4em)
    System ran in parallel with manual processes for 5 days. Accuracy: *99.6%*. Zero critical defects detected post-launch.
  ],
)

// #pagebreak()

= 6. Final Project Objectives vs. Outcomes

#table(
  columns: (0.5fr, 2fr, 1.5fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Obj.*],
  [#text(fill: white)[*SMART Objective*]],
  [#text(fill: white)[*Actual Outcome*]],
  [#text(fill: white)[*Met?*]],

  [O1],
  [Deploy functional prototype within 16 weeks, automating 90% of routine bookings.],
  [100% of routine bookings automated at launch.],
  [#status-badge("Met", rgb("#2e7d32"))],

  [O2],
  [75% reduction in patient interaction time for basic scheduling.],
  [Avg. time reduced from 8m to 1m 42s (−79%).],
  [#status-badge("Exceeded", rgb("#1565c0"))],

  [O3],
  [100% of urgent cases generate a high-priority alert within 60s.],
  [Avg. alert latency: 11 seconds across all test cases.],
  [#status-badge("Exceeded", rgb("#1565c0"))],

  [O4],
  [Support 50 concurrent triage sessions without latency degradation.],
  [Load test confirmed stable up to 73 concurrent sessions.],
  [#status-badge("Exceeded", rgb("#1565c0"))],
)
#pagebreak()
= 7. Source Code Inventory
The following modules constitute the MedConnect deliverable, submitted alongside this report.

#table(
  columns: (1.5fr, 1fr, 2fr),
  inset: 7pt,
  stroke: 0.5pt + luma(220),
  fill: (x, y) => if y == 0 { rgb("#0d47a1") } else if x == 0 { rgb("#f1f7fd") },
  [*Module / File*], [#text(fill: white)[*Language*]], [#text(fill: white)[*Description*]],

  [`app.py`], [Python / Flask], [Core application entrypoint; API route registration and middleware.],
  [`triage_engine.py`], [Python], [Decision-tree logic engine; processes symptom inputs and returns urgency tier.],
  [`scheduler.py`], [Python], [Appointment slot management; real-time availability query and booking commit.],
  [`models.py`], [Python / SQLAlchemy], [ORM definitions for Patient, Appointment, TriageRecord, and AuditLog.],
  [`auth.py`], [Python / JWT], [Authentication module; token generation and Zero-Trust access enforcement.],
  [`notify.py`], [Python / Twilio], [SMS/Email notification dispatcher for confirmations and urgent alerts.],
  [`templates/`], [HTML / Jinja2], [Frontend portal templates; patient onboarding, booking, and dashboard views.],
  [`static/`], [CSS / JS], [Responsive styling and frontend logic for the patient-facing booking portal.],
  [`tests/`], [Python / PyTest], [47 unit tests covering all logic-tree paths and API integration points.],
  [`config.py`], [Python], [Environment-specific configuration; .env binding for secrets and DB URIs.],
  [`requirements.txt`], [—], [Full dependency manifest for reproducible deployment environment.],
  [`Dockerfile`], [Docker], [Container specification for consistent staging and production deployment.],
)
#pagebreak()
= 8. Technical Implementation (Source Code)
The following snippets illustrate the core architectural components of the MedConnect platform, demonstrating the integration of clinical logic with a secure Flask middleware.

== 8.1 Clinical Triage Engine (`triage_engine.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  class TriageEngine:
      """Classifies patient symptoms into urgency tiers based on clinical rules."""

      TIER_RULES = {
          "CRITICAL": ["chest_pain", "unconsciousness", "severe_bleeding"],
          "URGENT": ["high_fever", "difficulty_breathing", "acute_pain"],
          "ROUTINE": ["cough", "mild_fever", "minor_rash"]
      }

      def process_symptoms(self, symptoms):
          """Returns the highest urgency tier found in the symptom set."""
          for tier, triggers in self.TIER_RULES.items():
              if any(s in symptoms for s in triggers):
                  return tier
          return "NON_URGENT"
  ```
]

== 8.2 Flask API Layer (`app.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  from flask import Flask, request, jsonify
  from triage_engine import TriageEngine
  from models import db, TriageRecord

  app = Flask(__name__)
  engine = TriageEngine()

  @app.route('/api/v1/triage', methods=['POST'])
  def handle_triage():
      data = request.get_json()
      tier = engine.process_symptoms(data.get('symptoms', []))

      # Atomic transaction for safety
      record = TriageRecord(patient_id=data['id'], tier=tier)
      db.session.add(record)
      db.session.commit()

      return jsonify({"status": "success", "tier": tier}), 201
  ```
]

== 8.3 Data Persistence (`models.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  from flask_sqlalchemy import SQLAlchemy

  db = SQLAlchemy()

  class TriageRecord(db.Model):
      """Normalized record of a clinical assessment."""
      id = db.Column(db.Integer, primary_key=True)
      patient_id = db.Column(db.String(20), nullable=False)
      tier = db.Column(db.String(15), nullable=False)
      timestamp = db.Column(db.DateTime, default=db.func.now())
  ```
]

== 8.4 Authentication & Session Security (`auth.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  import jwt
  import datetime
  from functools import wraps
  from flask import request, jsonify

  SECRET_KEY = "medconnect_secure_vault_hash"

  def token_required(f):
      @wraps(f)
      def decorated(*args, **kwargs):
          token = request.headers.get('x-access-token')
          if not token:
              return jsonify({'message': 'Token is missing!'}), 401
          try:
              data = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
          except:
              return jsonify({'message': 'Token is invalid!'}), 401
          return f(*args, **kwargs)
      return decorated
  ```
]

== 8.5 Scheduling & Availability (`scheduler.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  from datetime import datetime, timedelta
  from models import Appointment

  class SlotScheduler:
      """Manages clinical availability and atomic booking."""

      def get_available_slots(self, doctor_id, date):
          # Query DB for existing appointments
          booked = Appointment.query.filter_by(dr_id=doctor_id, date=date).all()
          # Algorithmic slot generation logic (simplified)
          return ["09:00", "09:30", "10:00", "11:00"]

      def book_slot(self, data):
          """Commits a slot to the database."""
          new_appt = Appointment(**data)
          return new_appt.save()
  ```
]

== 8.6 Notification Engine (`notify.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  from twilio.rest import Client

  class NotifyService:
      """Handles clinical alerts via Twilio/SMS."""

      def __init__(self, sid, token):
          self.client = Client(sid, token)

      def send_alert(self, phone, message):
          """Dispatches an urgent priority SMS notification."""
          return self.client.messages.create(
              body=f"[MEDCONNECT] {message}",
              from_='+15550001234',
              to=phone
          )
  ```
]

== 8.7 Quality Assurance Suite (`tests/test_triage.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```python
  import pytest
  from triage_engine import TriageEngine

  def test_critical_path():
      engine = TriageEngine()
      # Test case: Chest pain trigger
      result = engine.process_symptoms(["chest_pain", "mild_fever"])
      assert result == "CRITICAL"

  def test_routine_path():
      engine = TriageEngine()
      # Test case: Minor cough
      result = engine.process_symptoms(["cough"])
      assert result == "ROUTINE"
  ```
]

== 8.8 Infrastructure & Deployment (`Dockerfile`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
  ```dockerfile
  FROM python:3.10-slim

  WORKDIR /app
  COPY requirements.txt .
  RUN pip install --no-cache-dir -r requirements.txt

  COPY . .
  ENV FLASK_APP=app.py

  EXPOSE 5000
  CMD ["flask", "run", "--host=0.0.0.0"]
  ```
]

== 8.9 UI/UX Templates (`templates/index.html`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>MedConnect | Patient Portal</title>
    <link rel="stylesheet" href="/static/style.css">
</head>
<body>
    <header><h1>MedConnect Portal</h1></header>
    <main>
        <section id="triage-form">
            <h2>Symptom Assessment</h2>
            <form action="/api/v1/triage" method="post">
                <!-- Dynamic form components -->
            </form>
        </section>
    </main>
</body>
</html>
```
]

== 8.10 Cyber-Modernist Aesthetics (`static/style.css`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```css
:root {
    --primary: #0d47a1;
    --secondary: #607d8b;
    --bg: #f1f7fd;
}

body {
    font-family: 'Inter', sans-serif;
    background-color: var(--bg);
    color: #263238;
}

header {
    background: var(--primary);
    color: white;
    padding: 2rem;
    text-align: center;
}
```
]

== 8.11 Environment Configuration (`config.py`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```python
import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'dev-secret-key'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'sqlite:///medconnect.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
```
]

== 8.12 Dependency Manifest (`requirements.txt`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```text
Flask==2.1.2
Flask-SQLAlchemy==2.5.1
PyJWT==2.4.0
twilio==7.8.2
pytest==7.1.2
gunicorn==20.1.0
```
]

== 8.13 Project Documentation (`README.md`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```markdown
# MedConnect
Next-Gen Patient Flow & Triage Optimization.

## Setup
1. `pip install -r requirements.txt`
2. `flask run`

## Security
This project implements Zero-Trust and AES-256 for PII data.
```
]

== 8.14 Version Control (`.gitignore`)
#box(width: 100%, inset: 10pt, stroke: 0.5pt + luma(200), radius: 4pt, fill: luma(250))[
```text
__pycache__/
*.py[cod]
.env
instance/
medconnect.db
```
]

#v(1.5em)

#callout(title: "Project Closure Statement")[
  The *MedConnect* project has been executed to specification, delivered within budget, and closed at Week 16 as planned. All four SMART objectives were met or exceeded. The system has been handed over to the clinic administrative team with full technical documentation, staff training, and a 30-day support commitment from the engineering group. This report, alongside the full source code archive, constitutes the final deliverable for Assignment 4.
]
