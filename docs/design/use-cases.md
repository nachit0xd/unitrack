
# UniTrack — Use Case Model

## Document Information

| Field | Value |
|---|---|
| Project | UniTrack |
| Document | Use Case Model |
| Version | 0.1 |
| Status | Actor and Use Case Identification |
| Project Phase | Phase 0 - Planning and Design |

## 1. Introduction

### 1.1. Purpose

This document defines the functional interaction model of
UniTrack from the perspective of its external actors.

Its purpose is to identify the actors that interact with
the application, establish their responsibilities and
access boundaries, and describe the use cases through
which they achieve their academic management objectives.

The use case model provides a connection between software
requirements, business rules, system design, implementation,
and functional verification.

### 1.2. Scope

This document applies to the Minimum Viable Product
defined in the [Project Overview](../planning/project-overview.md).

The functional model is based on the requirements and
business rules established in the following documents:

- [Software Requirements Specification](../planning/requirements.md)
- [Business Rules](../planning/business-rules.md)

Features excluded from the MVP are not represented as
active use cases.

### 1.3. Intended Audience

This document is intended for developers, testers,
contributors, and reviewers involved in the development
and verification of UniTrack.

## 2. Functional Modeling Conventions

### 2.1. Modeling Terminology

| Element | Definition |
|---|---|
| Actor | An external role that interacts with the system. |
| Use Case | A system interaction through which an actor achieves an identifiable objective. |
| Primary Actor | An actor that initiates or pursues a goal through a use case. |
| Supporting Actor | An external actor that provides assistance or services to the system during a use case. |
| System Boundary | The conceptual boundary separating the system from its external environment. |
| Functional Requirement | A capability or behavior that the system shall provide. |
| Business Rule | A condition or restriction governing domain behavior. |
| Preconditions | Conditions that must hold before a use case can begin successfully. |
| Postconditions | Conditions that hold after a use case has completed. |

### 2.2. Identification Convention

| Prefix | Meaning | Example |
|---|---|---|
| ACT | Actor | ACT-001 |
| UC | Use Case | UC-001 |
| FR | Functional Requirement | FR-001 |
| NFR | Non-Functional Requirement | NFR-001 |
| BR | Business Rule | BR-001 |

Actor and use case identifiers should remain stable
throughout the development lifecycle.

Use case identifiers are independent of functional
requirement identifiers.

A use case may satisfy multiple functional requirements,
and a functional requirement may participate in multiple
use cases.

### 2.3. Use Case Naming

Use case names shall:

- Be written in English.
- Begin with an action verb.
- Represent an identifiable actor objective.
- Avoid unnecessary implementation details.
- Remain consistent with project terminology.

### 2.4. Priority Classification

Use cases inherit their priorities from the associated
functional requirements.

| Priority | Description |
|---|---|
| Must | Mandatory functionality required for MVP completion. |
| Should | Important functionality that may be deferred. |
| Could | Optional functionality depending on available resources. |
| Won't | Functionality excluded from the current release. |

Excluded functionality is not included in the active
use case catalog.

## 3. System Boundary

UniTrack is modeled as a single software system.

The system boundary includes:

- The web-based user interface.
- Authentication and authorization mechanisms.
- Application services.
- Academic management functionality.
- Academic calculation services.
- Calendar and dashboard functionality.
- Data persistence and database management.

Internal technical components, including React, FastAPI,
PostgreSQL, and application services, are not considered
external actors.

The functional model describes the observable behavior
of the application rather than its internal technical
architecture.

## 4. Actor Identification

### 4.1. Actor Catalog

| ID | Actor | Type | Authentication State |
|---|---|---|---|
| ACT-001 | Visitor | Primary | Unauthenticated |
| ACT-002 | Student | Primary | Authenticated |

The initial version of UniTrack does not require
supporting external actors.

### 4.2. ACT-001 — Visitor

| Attribute | Description |
|---|---|
| Identifier | ACT-001 |
| Name | Visitor |
| Type | Primary Actor |
| Authentication State | Unauthenticated |
| Primary Objective | Create an account or obtain authenticated access. |
| Access Scope | Public application functionality. |
| Related Requirements | FR-001, FR-002, FR-006 |
| Related Business Rules | BR-001, BR-002, BR-004 |

#### Description

The Visitor represents an individual interacting with
UniTrack without an active authenticated session.

A visitor may be a new individual who intends to create
an account or an existing registered user who has not
yet authenticated.

#### Responsibilities

- Provide valid registration information.
- Provide authentication credentials.
- Interact with publicly available functionality.
- Authenticate before accessing private functionality.

#### Permissions

The Visitor may:

- Access public application pages.
- Register a new account.
- Authenticate using existing account credentials.

#### Restrictions

The Visitor shall not:

- Access private academic resources.
- Create or modify protected academic information.
- Consult personal academic performance indicators.
- Access another user's private information.

### 4.3. ACT-002 — Student

| Attribute | Description |
|---|---|
| Identifier | ACT-002 |
| Name | Student |
| Type | Primary Actor |
| Authentication State | Authenticated |
| Primary Objective | Organize academic information and monitor academic performance. |
| Access Scope | Personal academic resources and protected application functionality. |
| Related Requirements | FR-003 to FR-040, as applicable. |
| Related Business Rules | BR-003 to BR-040, as applicable. |

#### Description

The Student represents a registered and authenticated
user who manages personal academic information within
UniTrack.

The Student is the primary consumer of the academic
management, assessment, performance analysis, calendar,
and dashboard functionality.

#### Responsibilities

- Maintain personal account information.
- Register and manage academic periods.
- Register and manage courses.
- Register assessments, grades, and weights.
- Maintain accurate academic information.
- Configure supported grading parameters.
- Consult academic performance indicators.
- Organize academic responsibilities.
- Confirm operations involving permanent data deletion.

#### Permissions

The Student may:

- Consult and modify supported personal profile information.
- Manage owned academic periods.
- Manage courses associated with owned academic periods.
- Manage assessments associated with owned courses.
- Consult calculated academic performance information.
- Access the personal academic calendar.
- Manage custom academic events when supported.
- Consult the academic dashboard.
- Terminate the current authenticated session.

#### Restrictions

The Student shall not:

- Access academic resources belonging to other users.
- Modify or delete resources belonging to other users.
- Bypass academic validation rules.
- Access administrative or institutional functionality.
- Modify calculated academic indicators independently
  of their underlying source information.

### 4.4. Actor Relationships

The Visitor and Student represent different interaction
roles rather than necessarily different individuals.

An individual may interact with the system as a Visitor
before authentication and subsequently as a Student
after successful authentication.

Logging out or expiration of the authenticated session
returns the individual to the unauthenticated interaction
context.

The actor model does not define a UML generalization
relationship between Visitor and Student.

Their available interactions depend on their respective
authentication states and responsibilities.

### 4.5. Excluded Actors

| Potential Actor or Component | Reason for Exclusion |
|---|---|
| Administrator | No administrative product functionality is included in the MVP. |
| Instructor | Teaching and institutional grading functionality is excluded. |
| University Staff | Institutional management functionality is excluded. |
| External Calendar Service | External calendar synchronization is outside the MVP. |
| Email Service | Email notifications and password recovery are excluded. |
| External Identity Provider | Third-party authentication is excluded. |
| Artificial Intelligence Service | Artificial intelligence functionality is excluded. |
| Database | Represents an internal system component. |
| Frontend | Represents an internal system component. |
| Backend | Represents an internal system component. |
| System Clock | Date and time retrieval does not represent an independent external interaction goal. |

Excluded actors may be reconsidered if future versions
introduce functionality requiring their participation.

## 5. Use Case Identification

### 5.1. Identification Approach

Use cases are derived from the approved project scope,
functional requirements, and academic business rules.

A use case shall represent an identifiable objective
pursued by an external actor.

Internal operations, including data validation, access
control, academic calculations, and persistence, are not
automatically represented as independent use cases.

The model uses separate use cases for operations with
distinct actor objectives or materially different
business conditions.

Closely related operations may be grouped when they
represent a common actor objective.

The identified use cases are organized into six functional
modules:

1. User Management.
2. Academic Management.
3. Assessment Management.
4. Performance Analysis.
5. Academic Calendar.
6. Academic Dashboard.

Functional modules represent logical groupings and do not
necessarily correspond to independently deployed services
or individual user interface pages.

## 6. Use Case Catalog

### 6.1. User Management

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-001 | Register Account | Visitor | Must | FR-001 |
| UC-002 | Log In | Visitor | Must | FR-002 |
| UC-003 | Log Out | Student | Must | FR-003 |
| UC-004 | View Profile | Student | Should | FR-004 |
| UC-005 | Update Profile | Student | Should | FR-005 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-001 | Create a personal UniTrack account. |
| UC-002 | Obtain authenticated access to private functionality. |
| UC-003 | Terminate the current authenticated session. |
| UC-004 | Consult personal profile information. |
| UC-005 | Modify the supported personal profile information. |

Authentication enforcement and resource ownership
verification are cross-cutting requirements rather than
independent actor objectives.

### 6.2. Academic Management

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-006 | Create Academic Period | Student | Must | FR-008 |
| UC-007 | View Academic Periods | Student | Must | FR-009 |
| UC-008 | Update Academic Period | Student | Must | FR-010 |
| UC-009 | Delete Academic Period | Student | Must | FR-011 |
| UC-010 | Set Active Academic Period | Student | Must | FR-012 |
| UC-011 | View Historical Academic Information | Student | Should | FR-013 |
| UC-012 | Create Course | Student | Must | FR-014 |
| UC-013 | View Courses | Student | Must | FR-015 |
| UC-014 | View Course Details | Student | Must | FR-015 |
| UC-015 | Update Course | Student | Must | FR-016 |
| UC-016 | Delete Course | Student | Must | FR-017 |
| UC-017 | Configure Grading Parameters | Student | Should | FR-018 |
| UC-018 | Customize Course Information | Student | Could | FR-019, FR-020 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-006 | Register a new academic period. |
| UC-007 | Consult registered academic periods. |
| UC-008 | Modify existing academic period information. |
| UC-009 | Delete an academic period and its dependent academic resources. |
| UC-010 | Select an academic period as the active academic context. |
| UC-011 | Consult academic information from previous periods. |
| UC-012 | Register a course within an academic period. |
| UC-013 | Consult courses associated with an academic period. |
| UC-014 | Consult detailed information about a specific course. |
| UC-015 | Modify basic course information. |
| UC-016 | Delete a course and its associated assessments. |
| UC-017 | Configure the grading scale and passing grade of a course. |
| UC-018 | Manage optional academic credits and course display colors. |

Course list consultation and individual course detail
consultation are represented as distinct actor objectives.

Grading parameter configuration is separated from general
course modification because it is subject to specific
academic validation rules.

Optional course credits and display colors are grouped
into a single customization use case.

Historical academic information may be modified through
the existing academic resource management use cases.

### 6.3. Assessment Management

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-019 | Create Assessment | Student | Must | FR-021, FR-025 |
| UC-020 | View Assessments | Student | Must | FR-022 |
| UC-021 | Update Assessment | Student | Must | FR-023, FR-025 |
| UC-022 | Delete Assessment | Student | Must | FR-024 |
| UC-023 | Manage Assessment Grade | Student | Must | FR-026 |
| UC-024 | Schedule Assessment | Student | Must | FR-027 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-019 | Register an assessment and its corresponding weight. |
| UC-020 | Consult assessments associated with a course. |
| UC-021 | Modify assessment information and weights. |
| UC-022 | Delete a registered assessment. |
| UC-023 | Register, modify, or remove an assessment grade. |
| UC-024 | Assign, modify, or remove an assessment's scheduled date. |

Grade management and assessment scheduling are identified
as separate use cases because they represent recurring
academic activities performed after assessment creation.

Grades and scheduled dates may also be provided during
assessment creation when supported.

Weight validation is a mandatory behavior of assessment
creation and modification rather than an independent
actor objective.

### 6.4. Performance Analysis

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-025 | View Course Performance | Student | Must | FR-028, FR-029, FR-030, FR-032 |
| UC-026 | View Required Passing Grade | Student | Must | FR-031, FR-032 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-025 | Consult current and final averages, assessment weight progress, and calculated academic status. |
| UC-026 | Consult the estimated weighted average required to pass a course and its passing feasibility. |

Academic performance indicators are calculated automatically
from the underlying academic information.

Individual calculation algorithms are not represented
as independent actor objectives.

Academic calculation behavior shall follow the policies
defined in the Business Rules document.

### 6.5. Academic Calendar

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-027 | View Academic Calendar | Student | Must | FR-033, FR-034 |
| UC-028 | View Upcoming Assessments | Student | Must | FR-035 |
| UC-029 | Create Custom Academic Event | Student | Should | FR-036 |
| UC-030 | View Custom Academic Events | Student | Should | FR-036 |
| UC-031 | Update Custom Academic Event | Student | Should | FR-037 |
| UC-032 | Delete Custom Academic Event | Student | Should | FR-037 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-027 | Consult the monthly academic calendar and navigate between months. |
| UC-028 | Consult upcoming assessments and submission deadlines. |
| UC-029 | Register a custom academic event. |
| UC-030 | Consult registered custom events and their details. |
| UC-031 | Modify an existing custom academic event. |
| UC-032 | Delete a registered custom academic event. |

Assessment calendar integration represents automatic
system behavior associated with calendar consultation.

The academic calendar may include authorized assessments
from multiple academic periods.

Custom academic events remain independent of registered
assessments and academic periods.

### 6.6. Academic Dashboard

| ID | Use Case | Primary Actor | Priority | Related Requirements |
|---|---|---|---|---|
| UC-033 | View Academic Dashboard | Student | Must | FR-038, FR-039 |
| UC-034 | View Active Period Assessment Overview | Student | Must | FR-040 |

#### Use Case Objectives

| ID | Objective |
|---|---|
| UC-033 | Consult a consolidated overview of the active academic period and its performance indicators. |
| UC-034 | Consult upcoming and ungraded assessments belonging to the active academic period. |

The dashboard uses the active academic period as its
primary academic context.

Unlike the general academic calendar, dashboard assessment
information is restricted to the selected active period.

Dashboard and calendar use cases may reuse underlying
application services without duplicating business logic.

## 7. Cross-Cutting Functional Requirements

The following functional requirements apply across
protected application functionality.

| Requirement | Description | Applicability |
|---|---|---|
| FR-006 | Protected functionality | All use cases requiring an authenticated actor. |
| FR-007 | Resource ownership enforcement | All use cases that access or modify protected user resources. |

These requirements shall be considered during detailed
use case specification.

They do not represent independent actor objectives.

Other functional requirements may describe mandatory
internal behavior within one or more use cases.

Examples include:

- Assessment weight validation.
- Grade range validation.
- Academic performance calculations.
- Automatic calendar integration.
- Academic status determination.

These behaviors shall remain traceable to their
associated functional requirements and business rules.

## 8. Use Case Summary

### 8.1. Distribution by Functional Module

| Module | Must | Should | Could | Total |
|---|---:|---:|---:|---:|
| User Management | 3 | 2 | 0 | 5 |
| Academic Management | 10 | 2 | 1 | 13 |
| Assessment Management | 6 | 0 | 0 | 6 |
| Performance Analysis | 2 | 0 | 0 | 2 |
| Academic Calendar | 2 | 4 | 0 | 6 |
| Academic Dashboard | 2 | 0 | 0 | 2 |
| **Total** | **25** | **8** | **1** | **34** |

### 8.2. Distribution by Actor

| Actor | Total Use Cases |
|---|---:|
| Visitor | 2 |
| Student | 32 |
| **Total** | **34** |

### 8.3. Functional Requirement Coverage

| Module | Defined Requirements | Covered Requirements |
|---|---:|---:|
| User Management | 7 | 7 |
| Academic Management | 13 | 13 |
| Assessment Management | 7 | 7 |
| Performance Analysis | 5 | 5 |
| Academic Calendar | 5 | 5 |
| Academic Dashboard | 3 | 3 |
| **Total** | **40** | **40** |

All functional requirements are associated with one or
more use cases or identified as cross-cutting requirements.

This coverage represents specification traceability
rather than implementation or test completion.

## 9. Use Case Relationships and Diagrams

**Status:** Pending specification.

This section will define:

- Actor and use case associations.
- Applicable UML include relationships.
- Applicable UML extend relationships.
- Functional module diagrams.
- System-wide use case representation.

Relationships shall be introduced only when justified
by the intended interaction behavior.

## 10. Detailed Use Case Specifications

**Status:** Pending specification.

Detailed use case specifications will describe:

- Use case identifier and name.
- Primary actor.
- Objective and description.
- Priority.
- Trigger.
- Preconditions.
- Successful postconditions.
- Failure postconditions.
- Main success scenario.
- Alternative flows.
- Exception flows.
- Related functional requirements.
- Related non-functional requirements.
- Applicable business rules.

## 11. Detailed Requirements Traceability

**Status:** Pending consolidation.

This section will establish detailed relationships
between use cases, functional requirements, applicable
non-functional requirements, and business rules.

The use case catalog currently provides initial
functional requirement traceability.

Detailed traceability will be completed alongside
the interaction specifications.

## 12. Related Documentation

- [Project Overview](../planning/project-overview.md)
- [Software Requirements](../planning/requirements.md)
- [Business Rules](../planning/business-rules.md)
- [Development Roadmap](../planning/roadmap.md)
- [Database Design](database-design.md)
- [Software Architecture](architecture.md)
- [REST API Design](api-design.md)

## 13. Document Status

This document establishes the initial actor identification
and use case catalog of UniTrack.

The current version defines two primary actors and
34 use cases distributed across six functional modules.

Use case relationships, UML diagrams, detailed interaction
specifications, and extended traceability remain pending.

The document will be updated during the remaining
functional modeling activities of Phase 0.
