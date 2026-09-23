#set page(
  paper: "a4",
  margin: (top: 25.4mm, bottom: 25.4mm, left: 31.8mm, right: 25.4mm),
  header: none,
  footer: context {
    let p = here().page()
    if p == 7 {
      align(center)[#text(size: 12pt)[7]]
    } else if p >= 11 and p <= 26 {
      align(center)[#text(size: 12pt)[#(p - 10)]]
    }
  },
)

#set text(
  font: "Times New Roman",
  size: 12pt,
  lang: "en",
  hyphenate: false,
)

#set par(
  justify: true,
  leading: 0.8em,
)

// Helper definitions
#let toc-ch(title) = {
  v(0.4em)
  text(size: 13pt, weight: "bold")[#title]
}

#let toc-item(title, page, level: 1, bold: false) = {
  let indent = if level == 1 { 0pt } else if level == 2 { 11pt } else { 22pt }
  let sz = if level == 1 { 13pt } else { 12pt }
  let weight = if bold { "bold" } else { "regular" }
  v(0.18em)
  h(indent)
  text(size: sz, weight: weight)[#title]
  h(0.3em)
  box(width: 1fr, repeat[.])
  text(size: sz, weight: weight)[#page]
}

// ==========================================
// PAGE 1: COVER PAGE
// ==========================================
#align(center)[
  #image("image1.png", width: 90.8mm)

  #v(1.8em)
  #text(size: 18pt, weight: "bold")[PROJECT NAME]

  #v(1.6em)
  #text(size: 14pt, weight: "bold")[A PROJECT REPORT]

  #v(1.4em)
  #text(size: 14pt, weight: "bold", style: "italic")[Submitted By]

  #v(1.4em)
  #text(size: 16pt, weight: "bold")[STUDENT’S FULL NAME]

  #v(0.3em)
  #text(size: 14pt, weight: "bold")[Enrollment Number]

  #v(1.8em)
  #text(size: 14pt, weight: "bold", style: "italic")[In partial fulfillment for the award of the degree of]

  #v(1.5em)
  #text(size: 16pt, weight: "bold")[DIPLOMA ENGINEERING /BACHELOR OF\ TECHNOLOGY]

  #v(0.4em)
  #text(size: 16pt, weight: "bold", style: "italic")[In]

  #v(0.4em)
  #text(size: 14pt, weight: "bold")[COMPUTER ENGINEERING/COMPUTER SCIENCE AND\ ENGINEERING]

  #v(2.2em)
  #text(size: 16pt, weight: "bold")[GYANMANJARI INNOVATIVE UNIVERSITY]

  #v(0.3em)
  #text(size: 14pt, weight: "bold")[BHAVNAGAR]

  #v(1.4em)
  #text(size: 14pt, weight: "bold")[JUNE 2026]
]

#pagebreak()

// ==========================================
// PAGE 2: CERTIFICATE
// ==========================================
#align(center)[
  #image("image1.png", width: 90.8mm)

  #v(1.2em)
  #text(size: 16pt, weight: "bold")[GYANMANJARI INNOVATIVE UNIVERSITY]

  #v(0.4em)
  #text(size: 14pt, weight: "bold", style: "italic")[Survey No.30, Sidsar Road, near Iscon Eleven]

  #v(0.3em)
  #text(size: 14pt, weight: "bold", style: "italic")[Bhavnagar-364001, Gujarat]

  #v(3.5em)
  #text(size: 16pt, weight: "bold")[#underline[CERTIFICATE]]
]

#v(2.5em)
#set par(leading: 1.1em, justify: true)
#text(size: 14pt)[
  This is to certify that the project report submitted along with the project#linebreak(justify: true)
  entitled *PROJECT NAME* has been carried out by *STUDENT’S FULL*#linebreak(justify: true)
  *NAME* under my guidance in partial fulfillment in the *5#super[th] Semester* of degree#linebreak(justify: true)
  of *Diploma Engineering /Bachelor of Technology in Computer*#linebreak(justify: true)
  *Engineering / Computer Science and Engineering, Gyanmanjari*#linebreak(justify: true)
  *Innovative University*, Bhavnagar during the academic year *2026-27*.
]

#v(1fr)
#grid(
  columns: (1fr, 1fr),
  align: (left, center),
  [
    #text(size: 14pt, weight: "bold")[Prof. Mayank K. Champaneri]\
    #v(0.8em)
    #h(28pt)#text(size: 14pt, weight: "bold")[Internal Guide]
  ],
  [
    #text(size: 14pt, weight: "bold")[Prof. Dhaval R. Chandarana]\
    #v(0.8em)
    #text(size: 14pt, weight: "bold")[Head of the Department]
  ],
)
#v(1em)

#pagebreak()

// ==========================================
// PAGE 3: COMPANY CERTIFICATE
// ==========================================
#v(3em)
#align(center)[
  #text(size: 16pt, weight: "bold")[COMPANY’S LOGO]

  #v(3em)
  #text(size: 16pt, weight: "bold")[TO WHOM IT MAY CONCERN]
]

#v(2.5em)
#set par(leading: 1.1em, justify: true)
#text(size: 14pt)[
  This is to certify that *STUDENT’S NAME*, a student of *Gyanmanjari*#linebreak(justify: true)
  *Innovative University* has successfully completed his internship in the field#linebreak(justify: true)
  of *FIELD NAME* from 08-06-2026 to 30-06-2026 (Total number of#linebreak(justify: true)
  Weeks:2) under the guidance of *COMPANY PERSON NAME*.
]

#v(1.8em)
#text(size: 14pt)[
  His internship activities include *Web Development, Database Design, Optimization, Feedback & more*.
]

#v(1.8em)
#text(size: 14pt)[
  During the period of his internship program with us, he had been exposed to different processes and was found diligent, hardworking and inquisitive.
]

#v(1.8em)
#text(size: 14pt)[
  We wish him every success in his life and career.
]

#v(2.2em)
#text(size: 14pt, weight: "bold")[For COMPANY NAME]

#v(0.8em)
#text(size: 14pt)[Authorised Signature with Industry Stamp]

#v(1fr)
#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [#text(size: 14pt)[Authorised Signature]], [#text(size: 14pt)[Industry Stamp]],
)
#v(1em)

#pagebreak()

// ==========================================
// PAGE 4: DECLARATION
// ==========================================
#align(center)[
  #image("image1.png", width: 90.8mm)

  #v(1.2em)
  #text(size: 16pt, weight: "bold")[GYANMANJARI INNOVATIVE UNIVERSITY]

  #v(0.4em)
  #text(size: 14pt, weight: "bold", style: "italic")[Survey No.30, Sidsar Road, near Iscon Eleven]

  #v(0.3em)
  #text(size: 14pt, weight: "bold", style: "italic")[Bhavnagar-364001, Gujarat]

  #v(3.5em)
  #text(size: 16pt, weight: "bold")[#underline[DECLARATION]]
]

#v(2.5em)
#set par(leading: 1.1em, justify: true)
#text(size: 14pt)[
  We hereby declare that the Internship / Project report submitted along with the#linebreak(justify: true)
  Internship / Project entitled *PROJECT NAME* submitted in partial#linebreak(justify: true)
  fulfillment for the degree of *Diploma Engineering /Bachelor of Technology*#linebreak(justify: true)
  *in Computer Engineering / Computer Science and Engineering* to#linebreak(justify: true)
  *Gyanmanjari Innovative University* is a bonafide record of original project#linebreak(justify: true)
  work carried out by me at *Gyanmanjari Innovative University* under the#linebreak(justify: true)
  supervision of *Prof. Mayank K. Champaneri* and that no part of this report#linebreak(justify: true)
  has been directly copied from any students’ reports or taken from any other#linebreak(justify: true)
  source, without providing due reference.
]

#v(1fr)
#align(left)[
  #text(size: 14pt, weight: "bold")[Student’s Full Name :]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[Enrollment Number :]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[Student’s Signatre :]
]
#v(1em)

#pagebreak()

// ==========================================
// PAGE 5: BLANK PAGE
// ==========================================
#pagebreak()

// ==========================================
// PAGE 6: TABLE OF CONTENT (PART 1)
// ==========================================
#set par(leading: 0.55em)
#align(center)[#text(size: 16pt, weight: "bold")[Table of Content]]
#v(1em)

#toc-item("Acknowledgement", "1", level: 1, bold: true)
#toc-item("Abstract", "2", level: 1, bold: true)

#toc-ch("Chapter-1: Introduction")
#toc-item("1.1 Project Summary", "3", level: 2, bold: true)
#toc-item("1.2 Project Details", "4", level: 2, bold: true)
#toc-item("1.3 Project Specification", "6", level: 2, bold: true)
#toc-item("1.4 Objectives of the System", "8", level: 2, bold: true)

#toc-item("1.4.1 Write Objective", "8", level: 3, bold: false)
#toc-item("1.4.2 Write Objective", "8", level: 3, bold: false)
#toc-item("1.4.3 Write Objective", "8", level: 3, bold: false)
#toc-item("1.5 Scope of the Project", "9", level: 2, bold: true)

#toc-item("1.5.1 Target Users", "9", level: 3, bold: false)
#toc-item("1.5.2 Core Functionalities", "10", level: 3, bold: false)
#toc-item("1.5.3 Technical Scope", "10", level: 3, bold: false)
#toc-item("1.5.4 Limitations", "10", level: 3, bold: false)
#toc-item("1.5.5 Future Scope", "11", level: 3, bold: false)

#toc-ch("Chapter-2: Literature Review")
#toc-item("2.1 Evolution", "12", level: 2, bold: true)
#toc-item("2.2 Existing Platforms", "13", level: 2, bold: true)
#toc-item("2.3 Summary of Literature Review", "14", level: 2, bold: true)

#toc-ch("Chapter-3: System Requirement Study")
#toc-item("3.1 Study of Current System", "2", level: 2, bold: true)
#toc-item("3.2 Problems and Weaknesses of Current System", "2", level: 2, bold: true)
#toc-item("3.3 User Characteristics", "2", level: 2, bold: true)

#pagebreak()

// ==========================================
// PAGE 7: TABLE OF CONTENT (PART 2)
// ==========================================
#set par(leading: 0.55em)
#toc-item("3.4 Hardware and Software Requirements", "2", level: 2, bold: true)
#toc-item("3.5 Constraints", "18", level: 2, bold: true)
#toc-item("3.5.1 User Interface", "18", level: 3, bold: false)
#toc-item("3.5.2 Communications Interface", "18", level: 3, bold: false)
#toc-item("3.5.3 Hardware Interface", "18", level: 3, bold: false)
#toc-item("3.5.4 Criticality of the Application", "18", level: 3, bold: false)
#toc-item("3.5.5 Safety and Security Considerations", "18", level: 3, bold: false)
#toc-item("3.6 Assumptions and Dependencies", "19", level: 2, bold: true)
#toc-item("3.6.1 Assumptions", "19", level: 3, bold: false)
#toc-item("3.6.2 Dependencies", "20", level: 3, bold: false)

#toc-ch("Chapter-4: System Design")
#toc-item("4.1 Overview of System Workflow", "21", level: 2, bold: true)
#toc-item("4.2 Database Design and ER Diagrams", "21", level: 2, bold: true)
#toc-item("4.2.1. Database Structure", "21", level: 3, bold: false)
#toc-item("4.2.2. Entity-Relationship (ER) Model", "23", level: 3, bold: false)
#toc-item("4.3 User Interface and Experience Design (UI/UX)", "24", level: 2, bold: true)
#toc-item("4.3.1. User Interface Design Principles", "24", level: 3, bold: false)
#toc-item("4.3.2. User Experience Enhancements", "24", level: 3, bold: false)
#toc-item("4.4 Class Diagrams and System Components", "27", level: 2, bold: true)
#toc-item("4.4.1. Major System Components", "27", level: 3, bold: false)
#toc-item("4.4.2. Class Diagram Structure", "28", level: 3, bold: false)

#toc-ch("Chapter-5: Implementation and Development")
#toc-item("5.1 Technology Stack", "31", level: 2, bold: true)
#toc-item("5.2 Frontend Implementation", "31", level: 2, bold: true)
#toc-item("5.3 Backend Implementation", "32", level: 2, bold: true)
#toc-item("5.4 Database Integration", "33", level: 2, bold: true)
#toc-item("5.5 Role-Based Access Control", "33", level: 2, bold: true)

#pagebreak()

// ==========================================
// PAGE 8: TABLE OF CONTENT (PART 3)
// ==========================================
#set par(leading: 0.55em)
#toc-ch("Chapter-6: Testing and Deployment")
#toc-item("6.1 Testing Strategies (Unit, Integration, User Testing)", "34", level: 2, bold: true)
#toc-item("6.1.1. Unit Testing", "34", level: 3, bold: false)
#toc-item("6.1.2. Integration Testing", "34", level: 3, bold: false)
#toc-item("6.1.3. User Acceptance Testing (UAT)", "34", level: 3, bold: false)
#toc-item("6.2 Performance Testing & Load Testing", "35", level: 2, bold: true)
#toc-item("6.2.1 Load Testing", "35", level: 3, bold: false)
#toc-item("6.2.2 Stress Testing", "35", level: 3, bold: false)
#toc-item("6.2.3 Database Performance Testing", "35", level: 3, bold: false)
#toc-item("6.3 Deployment Strategy (CI/CD, Server Setup, AWS S3, etc.)", "36", level: 2, bold: true)
#toc-item("6.3.1 CI/CD Pipeline Setup", "36", level: 3, bold: false)
#toc-item("6.3.2 Server Configuration", "36", level: 3, bold: false)
#toc-item("6.3.3 AWS S3 Integration", "36", level: 3, bold: false)
#toc-item("6.3.4 Deployment Process", "36", level: 3, bold: false)
#toc-item("6.4 Challenges Faced During Deployment", "37", level: 2, bold: true)
#toc-item("6.4.1 Server Downtime During Migration", "37", level: 3, bold: false)
#toc-item("6.4.2 SSL Configuration for Secure Access", "37", level: 3, bold: false)
#toc-item("6.4.3 Load Balancing Configuration", "37", level: 3, bold: false)

#toc-ch("Chapter-7: Results and Discussions")
#toc-item("7.1 Key Achievements", "38", level: 2, bold: true)
#toc-item("7.2 User Adoption and Feedback", "39", level: 2, bold: true)
#toc-item("7.2.1. Student Experience", "39", level: 3, bold: false)
#toc-item("7.2.2. Faculty and Administrative Feedback", "39", level: 3, bold: false)
#toc-item("7.2.3. Key Areas for Improvement", "39", level: 3, bold: false)
#toc-item("7.3 User Feedback and Insights", "40", level: 2, bold: true)
#toc-item("7.4 Performance Analysis", "40", level: 2, bold: true)
#toc-item("7.5 Limitations", "41", level: 2, bold: true)

#pagebreak()

// ==========================================
// PAGE 9: TABLE OF CONTENT (PART 4)
// ==========================================
#set par(leading: 0.55em)
#toc-ch("Chapter-8: Conclusion and Future Scope")
#toc-item("8.1 Conclusion", "42", level: 2, bold: true)
#toc-item("8.2 Future Scope", "43", level: 2, bold: true)

#v(1.2em)
#toc-item("Final Thoughts", "46", level: 1, bold: true)

#v(0.8em)
#toc-item("References", "47", level: 1, bold: true)

#v(0.8em)
#toc-item("Appendix", "48", level: 1, bold: true)

#pagebreak()

// ==========================================
// PAGE 10: TABLE OF FIGURE
// ==========================================
#set par(leading: 0.55em)
#align(center)[#text(size: 16pt, weight: "bold")[Table Of Figure]]
#v(1.5em)

#toc-item("Fig 1.1", "22", level: 1, bold: true)
#toc-item("Fig 1.2", "23", level: 1, bold: true)
#toc-item("Fig 1.3", "25", level: 1, bold: true)
#toc-item("Fig 1.4", "25", level: 1, bold: true)
#toc-item("Fig 1.5", "26", level: 1, bold: true)

#pagebreak()

// ==========================================
// PAGE 11: ACKNOWLEDGEMENT (Page 1)
// ==========================================
#align(center)[#text(size: 16pt, weight: "bold")[Acknowledgement]]
#v(1.8em)

#set par(leading: 0.9em, justify: true)
#text(size: 14pt)[
  We would like to express our sincere gratitude to *Prof. Mayank K.*#linebreak(justify: true)
  *Champaneri*, our Internal Guide, for his valuable guidance, support, and#linebreak(justify: true)
  encouragement throughout the development of this project. His expertise and#linebreak(justify: true)
  insights have played a crucial role in shaping the direction of our work,#linebreak(justify: true)
  helping us overcome challenges, and refining our ideas into a well-structured#linebreak(justify: true)
  project.
]

#v(1.2em)
#text(size: 14pt)[
  We are also deeply thankful to *Prof. Prashant J. Viradiya, Head of the*#linebreak(justify: true)
  *Department*, for providing us with the necessary resources, motivation, and#linebreak(justify: true)
  an environment that fosters learning and innovation. His leadership and#linebreak(justify: true)
  support have been instrumental in ensuring the successful completion of this#linebreak(justify: true)
  project.
]

#v(1.2em)
#text(size: 14pt)[
  Furthermore, we extend our appreciation to our faculty members, colleagues,#linebreak(justify: true)
  and friends who have contributed in various ways, offering valuable feedback#linebreak(justify: true)
  and assistance whenever needed. Their encouragement and constructive#linebreak(justify: true)
  suggestions have greatly enriched our work.
]

#v(1.2em)
#text(size: 14pt)[
  Lastly, we express our gratitude to our families for their continuous support,#linebreak(justify: true)
  patience, and motivation throughout this journey. Their belief in us has been#linebreak(justify: true)
  a constant source of inspiration.
]

#v(1.2em)
#text(size: 14pt)[
  This project, *PROJECT NAME*, is the result of collective efforts, and we are#linebreak(justify: true)
  grateful to everyone who has contributed to its success.
]

#pagebreak()

// ==========================================
// PAGE 12: ABSTRACT (Page 2)
// ==========================================
#align(center)[#text(size: 16pt, weight: "bold")[Abstract]]

#pagebreak()

// ==========================================
// PAGE 13: CHAPTER 1: INTRODUCTION (Page 3)
// ==========================================
#align(left)[
  #text(size: 16pt, weight: "bold")[Chapter 1: Introduction]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[1.1 Project Summary]
]

#pagebreak()

// ==========================================
// PAGE 14: 1.2 PROJECT DETAILS (Page 4)
// ==========================================
#align(left)[
  #text(size: 14pt, weight: "bold")[1.2 Project Details]

  #v(1.8em)
  #text(size: 12pt, weight: "bold")[Objective:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[Key Features:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[Target Audience:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[Technologies Used:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[Expected Outcomes:]
]

#pagebreak()

// ==========================================
// PAGE 15: LIMITATIONS & 1.3 PROJECT SPECIFICATION (Page 5)
// ==========================================
#align(left)[
  #text(size: 12pt, weight: "bold")[Limitations:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[Future Enhancements:]

  #v(2.8em)
  #text(size: 12pt, weight: "bold")[.]

  #v(1.8em)
  #text(size: 12pt, weight: "bold")[Long-Term Vision:]

  #v(2.8em)
  #text(size: 14pt, weight: "bold")[1.3 Project Specification]

  #v(0.8em)
  #text(size: 12pt)[The proposed project, *PROJECT NAME*, is a]

  #v(0.8em)
  #text(size: 12pt)[The following specifications describe the key features and technical scope of the system:]

  #v(0.8em)
  #text(size: 12pt)[1.3.1 General Description]

  #v(0.8em)
  #text(size: 12pt)[1.3.2 Functional Specifications]

  #v(0.8em)
  #text(size: 12pt)[1.3.3 Administrative and Vendor Capabilities]

  #v(0.8em)
  #text(size: 12pt)[1.3.4 Limitations and Future Scope]
]

#pagebreak()

// ==========================================
// PAGE 16: 1.4 OBJECTIVES & 1.5 SCOPE (Page 6)
// ==========================================
#align(left)[
  #text(size: 14pt, weight: "bold")[1.4 Objectives of the System]

  #v(1.2em)
  #text(size: 12pt)[The primary objective of the *PROJECT NAME*]

  #v(1em)
  #text(size: 12pt)[The system aims to fulfill the following objectives:]

  #v(1em)
  #text(size: 12pt, weight: "bold")[1.4.1]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.2]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.3]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.4]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.5]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.6]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[1.4.7]

  #v(2.2em)
  #text(size: 14pt, weight: "bold")[1.5 Scope of the Project]

  #v(1em)
  #text(size: 12pt)[The *PROJECT NAME* project is developed to support the]

  #v(1em)
  #text(size: 12pt)[The scope of this project includes the following aspects:]

  #v(1em)
  #text(size: 12pt, weight: "bold")[1.5.1 Target Users]
]

#pagebreak()

// ==========================================
// PAGE 17: CORE FUNCTIONALITIES & CHAPTER 2 (Page 7)
// ==========================================
#align(left)[
  #text(size: 12pt, weight: "bold")[1.5.2 Core Functionalities]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[1.5.3 Technical Scope]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[1.5.4 Limitations]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[1.5.5 Future Scope]

  #v(2.8em)
  #text(size: 16pt, weight: "bold")[Chapter 2: Literature Review]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[2.1 Evolution]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[2.2 Existing Platforms]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[2.3 Summary of Literature Review]
]

#pagebreak()

// ==========================================
// PAGE 18: CHAPTER 3: SYSTEM REQUIREMENT STUDY (Page 8)
// ==========================================
#align(left)[
  #text(size: 16pt, weight: "bold")[Chapter 3: System Requirement Study]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[3.1 Study of Current System]

  #v(2em)
  #text(size: 14pt, weight: "bold")[3.2 Problems and Weaknesses of Current System]

  #v(2em)
  #text(size: 14pt, weight: "bold")[3.3 User Characteristics]

  #v(2em)
  #text(size: 14pt, weight: "bold")[3.4 Hardware and Software Requirements]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[Hardware Requirements]

  #v(1.2em)
  #text(size: 14pt)[Software Requirements]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5 Constraints]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5.1 User Interface]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5.2 Communications Interface]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5.3 Hardware Interface]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5.4 Criticality of the Application]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[3.5.5 Safety and Security Considerations]
]

#pagebreak()

// ==========================================
// PAGE 19: 3.6 ASSUMPTIONS & CHAPTER 4 (Page 9)
// ==========================================
#align(left)[
  #text(size: 14pt, weight: "bold")[3.6 Assumptions and Dependencies]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[3.6.1 Assumptions]

  #v(2em)
  #text(size: 12pt, weight: "bold")[3.6.2 Dependencies]

  #v(2.5em)
  #text(size: 16pt, weight: "bold")[Chapter 4: System Design]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[4.1 Overview of System Workflow]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[4.2 Database Design and ER Diagrams]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[4.2.1. Database Structure]

  #v(2.5em)
  #text(size: 12pt, weight: "bold")[4.2.2. Entity-Relationship (ER) Model]

  #v(2.8em)
  #text(size: 14pt, weight: "bold")[4.3 User Interface and Experience Design (UI/UX)]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[4.3.1.]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[4.3.2.]

  #v(2.8em)
  #text(size: 14pt, weight: "bold")[4.4 Class Diagrams and System Components]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[4.4.1. Major System Components]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[4.4.2. Class Diagram Structure]
]

#pagebreak()

// ==========================================
// PAGE 20: CHAPTER 5 & CHAPTER 6 (Page 10)
// ==========================================
#align(left)[
  #text(size: 16pt, weight: "bold")[Chapter 5: Implementation and Development]

  #v(0.8em)
  #text(size: 12pt)[Implementation]

  #v(1.2em)
  #text(size: 14pt, weight: "bold")[5.1 Technology Stack]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[5.2 Frontend Implementation]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[5.3 Backend Implementation]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[5.4 Database Integration]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[5.5 Role-Based Access Control]

  #v(2.5em)
  #text(size: 16pt, weight: "bold")[Chapter 6: Testing and Deployment]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[6.1 Testing Strategies (Unit, Integration, User Testing)]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[6.1.1. Unit Testing]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.1.2. Integration Testing]

  #v(1.2em)
  #text(size: 12pt)[6.1.3. User Acceptance Testing (UAT)]

  #v(2.5em)
  #text(size: 14pt, weight: "bold")[6.2 Performance Testing & Load Testing]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[6.2.1 Load Testing]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.2.2 Stress Testing]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.2.3 Database Performance Testing]
]

#pagebreak()

// ==========================================
// PAGE 21: 6.3 DEPLOYMENT & CHAPTER 7 (Page 11)
// ==========================================
#align(left)[
  #text(size: 14pt, weight: "bold")[6.3 Deployment Strategy (CI/CD, Server Setup, AWS S3, etc.)]

  #v(1.2em)
  #text(size: 12pt)[6.3.1 CI/CD Pipeline Setup]

  #v(1.2em)
  #text(size: 12pt)[6.3.2 Server Configuration]

  #v(1.2em)
  #text(size: 12pt)[6.3.3 AWS S3 Integration]

  #v(1.2em)
  #text(size: 12pt)[6.3.4 Deployment Process]

  #v(2.5em)
  #text(size: 14pt, weight: "bold")[6.4 Challenges Faced During Deployment]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.4.1 Server Downtime During Migration]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.4.2 SSL Configuration for Secure Access]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[6.4.3 Load Balancing Configuration]

  #v(2.5em)
  #text(size: 16pt, weight: "bold")[Chapter 7: Results and Discussions]

  #v(2em)
  #text(size: 14pt, weight: "bold")[7.1 Key Achievements]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[7.2 User Adoption and Feedback]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[7.2.1. Student Experience]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[7.2.2. Faculty and Administrative Feedback]

  #v(1.2em)
  #text(size: 12pt, weight: "bold")[7.2.3. Key Areas for Improvement]
]

#pagebreak()

// ==========================================
// PAGE 22: 7.3 USER FEEDBACK & CHAPTER 8 (Page 12)
// ==========================================
#align(left)[
  #text(size: 14pt, weight: "bold")[7.3 User Feedback and Insights]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[7.4 Performance Analysis]

  #v(1.5em)
  #text(size: 12pt, weight: "bold")[7.5 Limitations]

  #v(2.5em)
  #text(size: 16pt, weight: "bold")[Chapter 8: Conclusion and Future Scope]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[8.1 Conclusion]

  #v(1.5em)
  #text(size: 14pt, weight: "bold")[8.2 Future Scope]
]

#pagebreak()

// ==========================================
// PAGE 23: 10, 11, 12 FUTURE ENHANCEMENTS (Page 13)
// ==========================================
#align(left)[
  #text(size: 12pt, weight: "bold")[10. Integration with Social Media and Influencer Marketing]

  #v(1.2em)
  #set par(justify: true, leading: 0.8em)
  #text(size: 12pt)[
    In the age of visual commerce, integrating the platform with Instagram, Facebook Marketplace, and influencer marketing campaigns can help artisans showcase their collections and gain traction quickly.
  ]

  #v(2.5em)
  #text(size: 12pt, weight: "bold")[11. Enhanced Accessibility Features]

  #v(1.2em)
  #text(size: 12pt)[
    To promote inclusivity, future enhancements could include voice navigation, high-contrast UI modes, and multilingual interfaces catering to a broader demographic, including differently-abled users.
  ]

  #v(2.5em)
  #text(size: 12pt, weight: "bold")[12. Blockchain for Authenticity Verification]

  #v(1.2em)
  #text(size: 12pt)[
    For high-value and custom-made jewelry, blockchain technology can be used to verify product authenticity and origin, adding an extra layer of transparency and trust for buyers.
  ]
]

#pagebreak()

// ==========================================
// PAGE 24: FINAL THOUGHTS (Page 14)
// ==========================================
#align(center)[#text(size: 16pt, weight: "bold")[Final Thoughts]]

#pagebreak()

// ==========================================
// PAGE 25: REFERENCES (Page 15)
// ==========================================
#align(center)[#text(size: 16pt, weight: "bold")[References]]
#v(2.5em)

#set par(justify: true, leading: 0.8em)
#set enum(indent: 0pt, body-indent: 0.6em, spacing: 1.35em)
#show link: set text(fill: rgb("#0563C1"))
#show link: underline

+ Sommerville, I. (2011). _Software Engineering_ (9th ed.). Pearson Education.
+ Pressman, R. S., & Maxim, B. R. (2014). _Software Engineering: A Practitioner’s#linebreak(justify: true)Approach_ (8th ed.). McGraw-Hill Education.
+ Welling, L., & Thomson, L. (2009). _PHP and MySQL Web Development_ (4th ed.).#linebreak(justify: true)Addison-Wesley.
+ Duckett, J. (2011). _HTML and CSS: Design and Build Websites_. Wiley.
+ MDN Web Docs. (2025). _HTML, CSS, and JavaScript Reference_. Retrieved from\ #link("https://developer.mozilla.org/")
+ Bootstrap. (2025). _Bootstrap Documentation_. Retrieved from\ #link("https://getbootstrap.com/docs/")
+ GitHub Docs. (2025). _Understanding the Git Workflow_. Retrieved from\ #link("https://docs.github.com/")
+ W3Schools. (2025). _JavaScript, PHP, and MySQL Tutorials_. Retrieved from\ #link("https://www.w3schools.com/")
+ Amazon Web Services (AWS). (2025). _AWS S3 Documentation_. Retrieved from\ #link("https://aws.amazon.com/s3/")
+ OpenAI. (2025). _ChatGPT Technical Help_. Retrieved from #link("https://openai.com/")


#pagebreak()

// ==========================================
// PAGE 26: APPENDIX (Page 16)
// ==========================================
#align(center)[#text(size: 16pt, weight: "bold")[Appendix]]
#v(3em)

#align(left)[
  #text(size: 14pt, weight: "bold")[Appendix A: Screenshots of the System (Admin Side)]

  #v(2.5em)
  #text(size: 14pt, weight: "bold")[Appendix B: Screenshots of the System (Customer Side)]
]
