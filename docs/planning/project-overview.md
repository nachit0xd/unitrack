
# UniTrack — Project Overview

## Document Information

| Field | Value |
|---|---|
| Project | UniTrack |
| Document | Project Overview |
| Version | 1.0 |
| Status | Initial Specification |
| Project Phase | Phase 0 - Planning and Design |

## 1. Project Identification

| Attribute | Description |
|---|---|
| Project Name | UniTrack |
| Project Type | Full-stack web application |
| Domain | Academic management and performance tracking |
| Development Area | Software engineering |
| Target Audience | University students |
| Initial Context | Chilean higher education |
| Platform | Web application |
| Usage Model | Individual and self-managed |
| Target Version | MVP 1.0 |
| Initial Interface Language | Spanish |
| Documentation Language | English |

## 2. Background and Context

University students are responsible for managing a significant
amount of academic information throughout their studies.

This information includes academic periods, enrolled courses,
assessments, deadlines, grades, assessment weights, and
course approval requirements.

Academic information may be distributed across institutional
platforms, course syllabi, emails, documents, calendars, and
personal notes.

Although educational institutions provide academic management
systems, these systems may not offer all the personal
organization, performance estimation, and planning tools
required by individual students.

As a result, students may rely on complementary tools such as
spreadsheets, digital calendars, note-taking applications,
and grade calculators.

## 3. Problem Statement

University students may experience difficulties centralizing,
organizing, and monitoring their personal academic information
due to fragmented data, manual calculation processes, and
the limitations of tools that do not integrate academic
planning with performance tracking.

### 3.1. Identified Problems

- **Fragmented academic information:** Academic data may be
  distributed across multiple platforms and documents.

- **Manual performance calculations:** Students may need to
  manually calculate weighted averages and required grades.

- **Academic scheduling difficulties:** Managing multiple
  assessments and deadlines can make academic planning
  challenging.

- **Limited performance visibility:** Individual grades do not
  always provide a clear understanding of overall academic
  progress.

- **Differences between grading systems:** Grading scales,
  assessment weights, and passing criteria may vary between
  institutions and courses.

- **Decentralized historical information:** Information from
  previous academic periods may be difficult to retrieve and
  compare.

### 3.2. Potential Consequences

The identified problems may contribute to:

- Errors in academic performance calculations.
- Inefficient organization of academic responsibilities.
- Difficulties prioritizing assessments and deadlines.
- Uncertainty regarding course approval requirements.
- Limited awareness of academic progress.
- Additional time spent managing academic information.

### 3.3. Problem Validation

The problem definition is based on an initial understanding
of the university student context.

The identified problems represent working assumptions and
have not yet been formally validated through surveys,
interviews, or other user research methods.

## 4. Proposed Solution

UniTrack is a web-based academic management and performance
tracking platform designed to help university students
centralize, organize, and monitor their personal academic
information.

The application will provide an individual environment where
users can manage academic periods, courses, assessments,
grades, assessment weights, and academic events.

Based on the registered information, the system will perform
automated academic calculations and provide indicators that
support academic planning and performance monitoring.

UniTrack will operate independently of institutional academic
management systems and will allow users to configure selected
grading parameters according to their academic context.

### 4.1. Value Proposition

UniTrack aims to combine academic organization and performance
analysis within a single platform.

Rather than functioning exclusively as an academic information
repository, UniTrack will process registered data to generate
meaningful information that supports academic decision-making.

The platform will provide:

- Centralized academic information management.
- Automated weighted grade calculations.
- Required grade estimation.
- Academic progress monitoring.
- Integrated academic scheduling.
- Configurable grading parameters.
- Access to previous academic periods.

### 4.2. Functional Modules

The application will initially consist of six functional
modules.

| Module | Responsibility |
|---|---|
| User Management | Account management, authentication, and user profiles. |
| Academic Management | Management of academic periods and courses. |
| Assessment Management | Management of assessments, grades, and weights. |
| Performance Analysis | Academic calculations and performance indicators. |
| Academic Calendar | Organization of academic deadlines and events. |
| Dashboard | Consolidated presentation of academic information. |

These modules represent logical functional boundaries within
the application rather than independently deployed services.

### 4.3. Problem-Solution Traceability

| Identified Problem | Proposed Solution |
|---|---|
| Fragmented information | Centralized academic management. |
| Manual calculations | Automated weighted grade calculations. |
| Uncertainty regarding passing requirements | Required grade estimation. |
| Scheduling difficulties | Integrated academic calendar. |
| Limited performance visibility | Performance indicators and dashboard. |
| Differences between grading systems | Configurable grading parameters. |
| Decentralized historical information | Academic period history. |

## 5. Target Audience

### 5.1. Primary Users

The primary target audience consists of undergraduate
university students who require tools to organize their
academic information and monitor their academic performance.

### 5.2. Initial User Context

The initial version of UniTrack will focus on Chilean
university students who manage courses within academic
periods and use numerical weighted grading systems.

### 5.3. Potential Future Users

Future versions may extend support to:

- University students from other countries.
- Postgraduate students.
- Students from other higher education institutions.
- Students using alternative grading systems.

The initial version will not target instructors, institutional
administrators, or educational organizations.

## 6. Project Objectives

### 6.1. General Objective

Design, develop, and implement a web-based academic management
and performance tracking platform that enables university
students to centralize their academic information, organize
their responsibilities, and monitor their academic performance
through management, calculation, and data visualization tools,
using a modular, secure, and maintainable software architecture.

### 6.2. Functional Objectives

| ID | Objective |
|---|---|
| OF-01 | Provide a centralized and individual academic management environment. |
| OF-02 | Facilitate the organization of academic periods and courses. |
| OF-03 | Enable the registration and tracking of assessments, grades, and weights. |
| OF-04 | Automate weighted grade calculations and academic progress measurements. |
| OF-05 | Estimate the grades required to achieve academic goals. |
| OF-06 | Support academic planning through an integrated calendar. |
| OF-07 | Provide meaningful academic performance indicators. |
| OF-08 | Preserve academic information from previous periods. |
| OF-09 | Support configurable grading parameters. |

### 6.3. Technical Objectives

| ID | Objective |
|---|---|
| OT-01 | Implement a client-server architecture with separated frontend, backend, and database responsibilities. |
| OT-02 | Develop a responsive web interface using React and TypeScript. |
| OT-03 | Implement a REST API using Python and FastAPI. |
| OT-04 | Design a normalized relational database using PostgreSQL. |
| OT-05 | Implement authentication, authorization, and personal data protection mechanisms. |
| OT-06 | Ensure data integrity through validation and database constraints. |
| OT-07 | Establish a reproducible development environment using Docker and Docker Compose. |
| OT-08 | Implement automated tests for core functionality and business logic. |
| OT-09 | Maintain technical documentation throughout the development lifecycle. |
| OT-10 | Use Git, GitHub, and continuous integration practices to manage project development. |

### 6.4. Learning and Professional Development Objectives

UniTrack is also intended to strengthen practical knowledge
and professional competencies in:

- Software engineering and requirements analysis.
- Full-stack web development.
- Relational database modeling.
- REST API design and implementation.
- Software architecture.
- Authentication and authorization.
- Automated software testing.
- Containerization and deployment.
- Version control and continuous integration.
- Technical documentation.

The project will serve as a professional portfolio demonstrating
the development lifecycle of a software application.

## 7. Minimum Viable Product (MVP)

### 7.1. MVP Definition

The Minimum Viable Product represents the first functional
version of UniTrack capable of providing an end-to-end academic
organization and performance tracking experience.

The MVP will prioritize essential functionality, reliability,
data integrity, and maintainability over advanced features
and extensive customization.

### 7.2. Core User Workflow

The MVP must allow a student to:

1. Create a user account.
2. Authenticate within the application.
3. Create an academic period.
4. Register courses.
5. Register assessments and their corresponding weights.
6. Record assessment grades.
7. Consult academic performance calculations.
8. Organize responsibilities through the academic calendar.
9. Review consolidated information through the dashboard.
10. Access previously registered information in future sessions.

### 7.3. In-Scope Features

#### 7.3.1. User Management

- User registration.
- User authentication and logout.
- Basic user profile management.
- Individual access to personal academic information.
- Secure password storage.

#### 7.3.2. Academic Management

- Creation, consultation, modification, and deletion of
  academic periods.
- Selection of an active academic period.
- Access to previous academic periods.
- Creation, consultation, modification, and deletion of courses.
- Course identification through names and optional codes.
- Optional academic credit registration.
- Basic course color customization.
- Configurable grading scales and passing grades.

#### 7.3.3. Assessment Management

- Creation, consultation, modification, and deletion of
  assessments.
- Assessment names and descriptions.
- Percentage-based assessment weights.
- Grade registration and modification.
- Assessment dates and deadlines.
- Support for assessments without registered grades.
- Grade and weight validation.

#### 7.3.4. Performance Analysis

- Current weighted average calculation.
- Final weighted average calculation when applicable.
- Calculation of graded assessment weight.
- Required grade estimation for course approval.
- Identification of achievable, guaranteed, and unachievable
  passing scenarios.
- Configurable minimum passing grades.

#### 7.3.5. Academic Calendar

- Monthly calendar visualization.
- Automatic display of scheduled assessments.
- Academic deadline visualization.
- Creation, consultation, modification, and deletion of
  custom academic events.
- Upcoming assessment overview.

#### 7.3.6. Dashboard

- Active academic period overview.
- Registered course indicators.
- Course performance summaries.
- Graded assessment progress indicators.
- Upcoming assessment overview.
- Identification of assessments without registered grades.
- Academic period performance indicators when the underlying
  grades are comparable.

### 7.4. Feature Prioritization

The project will use an adapted MoSCoW prioritization approach.

#### Must Have

Features essential to the core academic management workflow:

- User authentication.
- Academic period management.
- Course management.
- Assessment management.
- Grade and weight registration.
- Academic performance calculations.
- Basic academic calendar.
- Basic academic dashboard.
- Data protection and persistence.

#### Should Have

Important features planned for the initial version:

- Basic user profile management.
- Access to previous academic periods.
- Custom academic events.
- Configurable grading scales and passing grades.

#### Could Have

Desirable features that may be included depending on available
development time:

- Course color customization.
- Academic credit registration.
- Additional visual performance indicators.

#### Won't Have

Features that will not be implemented in the initial version:

- External service integrations.
- Advanced notifications.
- Artificial intelligence.
- Native mobile applications.
- Advanced academic analytics.
- Institutional management functionality.

### 7.5. Out-of-Scope Features

The following features are excluded from the MVP:

| Feature | Reason |
|---|---|
| Weekly class schedule management | Requires recurring schedule management. |
| Automated notifications | Requires scheduling and delivery mechanisms. |
| Advanced grade simulation | Depends on reliable foundational calculations. |
| Advanced historical analytics | Requires additional analytical models. |
| External calendar synchronization | Introduces third-party integration complexity. |
| Institutional platform integration | Depends on external APIs and permissions. |
| Report export | Not essential to the core academic workflow. |
| Curriculum management | Requires additional academic data modeling. |
| Email-based password recovery | Requires email delivery and secure token infrastructure. |
| Social authentication | Introduces external identity provider dependencies. |
| Multi-factor authentication | Reserved for future security enhancements. |
| Native mobile applications | Requires additional platform development. |
| Internationalization | Requires translation and regional adaptation. |
| Artificial intelligence | Not necessary for the initial problem definition. |
| Collaborative functionality | Increases authorization complexity. |
| Institutional management | Falls outside the initial target audience. |
| Complex grading mechanisms | Requires additional academic calculation models. |
| File attachments | Introduces additional storage requirements. |

Excluded features may be reconsidered in future versions.

Email-based password recovery and other operational security
requirements should be evaluated before sustained public use.

## 8. Assumptions

| ID | Assumption |
|---|---|
| AS-01 | Users are responsible for registering and updating their academic information. |
| AS-02 | Users manage their own individual academic data. |
| AS-03 | Courses are organized within academic periods. |
| AS-04 | Assessments use percentage-based weights. |
| AS-05 | Grades are represented using numerical values. |
| AS-06 | The default grading scale ranges from 1.0 to 7.0. |
| AS-07 | The default passing grade is 4.0 and can be configured. |
| AS-08 | Users have access to a supported web browser and connectivity to the application. |
| AS-09 | The application operates independently of institutional systems. |
| AS-10 | Public demonstration data will be fictional. |

## 9. Constraints

| ID | Constraint |
|---|---|
| CT-01 | The project will initially be developed by a single developer. |
| CT-02 | Development will use the selected technology stack. |
| CT-03 | The MVP will be delivered as a web application. |
| CT-04 | Core functionality will not depend on external service integrations. |
| CT-05 | Academic calculations will initially use simple weighted averages. |
| CT-06 | UniTrack will not replace official institutional academic records. |
| CT-07 | The project must support reproducible local execution. |
| CT-08 | Open-source and freely available development tools will be prioritized. |

### 9.1. Academic Calculation Limitations

The initial version will support simple weighted grading
systems.

Advanced academic evaluation mechanisms will not be supported,
including:

- Mandatory minimum examination grades.
- Examination exemption rules.
- Nested assessment weights.
- Grade replacement mechanisms.
- Attendance-based approval requirements.
- Institution-specific rounding policies.

Academic results and required grade estimations will be based
on user-provided information and supported calculation models.

The application will not guarantee that calculated results
match official institutional academic records.

The initial numeric grading domain supports values ranging
from 0.00 to 100.00, with up to two decimal places.

Each course will use its own configured grading scale
within this supported numeric domain.

Academic passing decisions will be based on calculated
results before display rounding.

Detailed calculation formulas, academic status definitions,
validation rules, and rounding policies are specified in
the [Business Rules](business-rules.md) document.

## 10. Technology Overview

The project will use the following technology stack.

| Layer | Technologies |
|---|---|
| Frontend | React, TypeScript, Vite, React Router |
| Backend | Python, FastAPI, Pydantic |
| Data Access | SQLAlchemy |
| Database Migrations | Alembic |
| Database | PostgreSQL |
| Infrastructure | Docker, Docker Compose |
| Testing | Pytest |
| Version Control | Git, GitHub |
| Continuous Integration | GitHub Actions |

The application will follow a client-server architecture with
a modular monolithic backend.

Detailed architectural decisions will be documented separately
in the software architecture document.

## 11. MVP Acceptance Criteria

The initial version will be considered functionally complete
when the following mandatory criteria are satisfied.

### 11.1. Functional Criteria

- [ ] Users can register, authenticate, and log out.
- [ ] Users can only access and modify their own academic data.
- [ ] Users can create and manage academic periods.
- [ ] Users can register and manage courses.
- [ ] Users can register assessments, grades, and weights.
- [ ] Weighted grade calculations produce correct results.
- [ ] Required grade estimations produce correct results.
- [ ] Invalid grades and assessment weights are rejected.
- [ ] Scheduled assessments appear in the academic calendar.
- [ ] The dashboard displays academic performance indicators.
- [ ] Registered academic information persists across sessions.

### 11.2. Technical Criteria

- [ ] The frontend communicates correctly with the REST API.
- [ ] The backend enforces validation and access control.
- [ ] The database ensures referential integrity.
- [ ] Core academic calculations are covered by automated tests.
- [ ] User data isolation is verified through automated tests.
- [ ] The application supports reproducible local execution.
- [ ] Technical documentation is available and updated.
- [ ] No credentials or sensitive information are exposed
      within the public repository.

Additional feature-specific acceptance criteria will be defined
during requirements specification.

## 12. Initial Project Risks

The following risks represent qualitative planning estimates.

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Uncontrolled scope expansion | High | High | Maintain MVP boundaries and feature priorities. |
| Technology learning curve | High | Medium | Implement functionality incrementally. |
| Complex grading system incompatibility | Medium | Medium | Limit the initial calculation model. |
| Incorrect academic calculations | Medium | High | Implement automated tests and boundary cases. |
| Authentication or authorization vulnerabilities | Medium | High | Use established security mechanisms and verify access control. |
| Component integration difficulties | Medium | Medium | Integrate application components progressively. |
| Development discontinuity | Medium | High | Establish achievable milestones and track progress. |
| Accidental credential exposure | Medium | High | Use environment variables and review repository changes. |

## 13. Related Documentation

- [Software Requirements](requirements.md)
- [Business Rules](business-rules.md)
- [Development Roadmap](roadmap.md)
- [Use Cases](../design/use-cases.md)
- [Database Design](../design/database-design.md)
- [Software Architecture](../design/architecture.md)
- [REST API Design](../design/api-design.md)

## 14. Document Status

This document establishes the initial problem definition,
proposed solution, project objectives, target audience, and
MVP scope of UniTrack.

The specification may be refined during requirements analysis,
technical design, implementation, and user validation.

Changes affecting the MVP scope should be evaluated,
documented, and reflected in the corresponding project
documentation.
