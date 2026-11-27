
# UniTrack — Software Requirements Specification

## Document Information

| Field | Value |
|---|---|
| Project | UniTrack |
| Document | Software Requirements Specification |
| Version | 1.0 |
| Status | Initial Specification |
| Project Phase | Phase 0 - Planning and Design |

## 1. Introduction

### 1.1. Purpose

This document defines the functional and non-functional
requirements of UniTrack.

Its purpose is to establish a clear, consistent, and verifiable
specification that guides system design, implementation,
integration, and testing.

### 1.2. Scope

This specification applies to the Minimum Viable Product
defined in the [Project Overview](project-overview.md).

Features explicitly excluded from the MVP are not considered
active requirements in this document.

### 1.3. Intended Audience

This document is intended for developers, testers, contributors,
and reviewers involved in the development of UniTrack.

## 2. System Overview

UniTrack is a web-based academic management and performance
tracking platform designed for university students.

The application allows users to manage academic periods,
courses, assessments, grades, and academic events while
providing automated academic performance calculations.

The system consists of six functional modules:

1. User Management.
2. Academic Management.
3. Assessment Management.
4. Performance Analysis.
5. Academic Calendar.
6. Academic Dashboard.

The functional modules represent logical responsibilities
within a modular monolithic architecture.

## 3. Requirement Conventions

### 3.1. Identification

| Prefix | Meaning |
|---|---|
| FR | Functional Requirement |
| NFR | Non-Functional Requirement |
| BR | Business Rule |
| AC | Acceptance Criterion |
| UC | Use Case |

Requirement identifiers should remain stable throughout the
development lifecycle.

Acceptance criteria may be referenced using the corresponding
requirement identifier and their sequential position.

For example, AC-001-01 identifies the first acceptance
criterion of FR-001.

### 3.2. Priority Classification

| Priority | Meaning |
|---|---|
| Must | Mandatory for MVP completion. |
| Should | Important but deferrable if necessary. |
| Could | Optional, depending on available resources. |
| Won't | Excluded from the current release. |

The term "shall" describes expected system behavior.

Requirements classified as Should or Could must satisfy their
acceptance criteria if implemented.

## 4. Functional Requirements

### 4.1. User Management

#### FR-001 — User Registration

**Priority:** Must

The system shall allow visitors to create an account by
providing a name, email address, and password.

**Acceptance Criteria:**

1. Valid registration information creates a new account.
2. An already registered normalized email address is rejected.
3. Missing or invalid required fields are rejected.
4. Passwords are stored using secure password hashing.
5. Password hashes are not included in API responses.

#### FR-002 — User Authentication

**Priority:** Must

The system shall allow registered users to authenticate using
their email address and password.

**Acceptance Criteria:**

1. Valid credentials grant access to protected functionality.
2. Invalid credentials do not grant access.
3. Authentication failures do not reveal whether a particular
   email address is registered.
4. Expired or invalid authentication credentials are rejected.

#### FR-003 — User Logout

**Priority:** Must

The system shall allow authenticated users to terminate
their current session.

**Acceptance Criteria:**

1. Logging out clears client-side authentication state.
2. The terminated session cannot be used for continued
   authenticated access.
3. Protected functionality requires authentication again
   after logout.

#### FR-004 — Profile Consultation

**Priority:** Should

The system shall allow authenticated users to consult their
personal profile information.

**Acceptance Criteria:**

1. Users can retrieve their own profile information.
2. Sensitive authentication data is not returned.

#### FR-005 — Profile Modification

**Priority:** Should

The system shall allow users to modify their display name.

**Acceptance Criteria:**

1. Valid profile changes are persisted.
2. Empty or invalid display names are rejected.
3. Users cannot modify another user's profile.
4. Email address changes are not required by the MVP.

#### FR-006 — Protected Functionality

**Priority:** Must

The system shall restrict private academic functionality
to authenticated users.

**Acceptance Criteria:**

1. Unauthenticated requests to protected endpoints are rejected.
2. Public authentication endpoints remain accessible.
3. Client-side navigation restrictions are supported by
   server-side authentication enforcement.

#### FR-007 — Resource Ownership Enforcement

**Priority:** Must

The system shall restrict academic resources to their owners.

**Acceptance Criteria:**

1. Users can access their own academic resources.
2. Users cannot retrieve another user's private resources.
3. Users cannot modify or delete resources owned by others.
4. Resource ownership is verified by the backend for every
   relevant operation.

### 4.2. Academic Management

#### FR-008 — Academic Period Creation

**Priority:** Must

The system shall allow users to create academic periods by
providing a name, start date, and end date.

**Acceptance Criteria:**

1. Valid period information creates a new academic period.
2. The period is associated with the authenticated user.
3. Invalid date ranges are rejected.
4. Missing required fields are rejected.

#### FR-009 — Academic Period Consultation

**Priority:** Must

The system shall allow users to retrieve their registered
academic periods.

**Acceptance Criteria:**

1. Only periods owned by the authenticated user are returned.
2. Period details include their name, dates, and active status.
3. Users without registered periods receive an empty result.

#### FR-010 — Academic Period Modification

**Priority:** Must

The system shall allow users to modify their academic periods.

**Acceptance Criteria:**

1. Valid modifications are persisted.
2. Invalid date ranges are rejected.
3. Resource ownership is enforced.

#### FR-011 — Academic Period Deletion

**Priority:** Must

The system shall allow users to delete academic periods.

**Acceptance Criteria:**

1. The user is informed about dependent data before deletion.
2. Explicit confirmation is required through the interface.
3. Associated courses and assessments are deleted consistently.
4. Unrelated academic data remains unaffected.
5. Deleting an active period leaves no active period selected.

#### FR-012 — Active Academic Period Selection

**Priority:** Must

The system shall allow users to select an active academic period.

**Acceptance Criteria:**

1. A user can activate an owned academic period.
2. Activating a period deactivates the previously active period.
3. No user can have more than one active period.
4. The dashboard reflects the selected academic period.

#### FR-013 — Historical Academic Period Access

**Priority:** Should

The system shall allow users to consult and manage information
from previous academic periods.

**Acceptance Criteria:**

1. Previous periods remain available until explicitly deleted.
2. Their courses and assessments can be consulted.
3. Historical information can be modified without activating
   the corresponding academic period.

#### FR-014 — Course Creation

**Priority:** Must

The system shall allow users to register courses within
their academic periods.

**Acceptance Criteria:**

1. A valid course name and owned academic period are required.
2. The course is created within the specified period.
3. A course code may be provided optionally.
4. Default grading parameters are assigned when custom
   parameters are not provided.

#### FR-015 — Course Consultation

**Priority:** Must

The system shall allow users to retrieve their courses and
individual course details.

**Acceptance Criteria:**

1. Courses can be listed by academic period.
2. Course details can be retrieved individually.
3. Only authorized course information is returned.
4. Available academic performance indicators can be consulted.

#### FR-016 — Course Modification

**Priority:** Must

The system shall allow users to modify registered course
information.

**Acceptance Criteria:**

1. Valid course modifications are persisted.
2. Empty course names are rejected.
3. Existing relationships remain consistent.
4. Resource ownership is enforced.

#### FR-017 — Course Deletion

**Priority:** Must

The system shall allow users to delete registered courses.

**Acceptance Criteria:**

1. The interface informs the user about dependent assessments.
2. Explicit confirmation is required.
3. Associated assessments are deleted consistently.
4. Unrelated courses and academic periods remain unaffected.

#### FR-018 — Grading Parameter Configuration

**Priority:** Should

The system shall allow users to configure the minimum grade,
maximum grade, and passing grade of a course.

**Acceptance Criteria:**

1. The default grading scale ranges from 1.0 to 7.0.
2. The default passing grade is 4.0.
3. The minimum grade must be lower than the maximum grade.
4. The passing grade must belong to the configured scale.
5. Scale changes cannot invalidate existing grades.
6. Academic indicators reflect valid configuration changes.

#### FR-019 — Academic Credit Registration

**Priority:** Could

The system shall allow users to associate academic credits
with a course.

**Acceptance Criteria:**

1. Academic credits are optional.
2. Negative and non-integer credit values are rejected.
3. Valid credit information is persisted.
4. Credits do not affect assessment-weighted calculations.

#### FR-020 — Course Color Customization

**Priority:** Could

The system shall allow users to assign a display color to
individual courses.

**Acceptance Criteria:**

1. Users can select a supported color.
2. Invalid color values are rejected.
3. The selected color is displayed consistently.
4. Course identification does not depend exclusively on color.

### 4.3. Assessment Management

#### FR-021 — Assessment Creation

**Priority:** Must

The system shall allow users to register assessments
associated with their courses.

**Acceptance Criteria:**

1. An assessment requires a name, weight, and owned course.
2. Descriptions, grades, and dates may be optional.
3. Valid assessment information is persisted.
4. Assessment creation respects applicable weight restrictions.

#### FR-022 — Assessment Consultation

**Priority:** Must

The system shall allow users to retrieve assessments
associated with their courses.

**Acceptance Criteria:**

1. Assessment lists include registered academic information.
2. Assessments without grades are distinguishable from
   graded assessments.
3. Only assessments belonging to authorized courses are returned.

#### FR-023 — Assessment Modification

**Priority:** Must

The system shall allow users to modify assessment information.

**Acceptance Criteria:**

1. Valid modifications are persisted.
2. Modified assessment weights satisfy all weight restrictions.
3. Academic indicators reflect updated assessment information.
4. Scheduled assessment changes are reflected in the calendar.

#### FR-024 — Assessment Deletion

**Priority:** Must

The system shall allow users to delete registered assessments.

**Acceptance Criteria:**

1. Explicit confirmation is required through the interface.
2. The assessment is removed from the corresponding course.
3. Academic performance indicators are recalculated.
4. Calendar entries derived from the assessment disappear.

#### FR-025 — Assessment Weight Validation

**Priority:** Must

The system shall validate individual and accumulated
assessment weights.

**Acceptance Criteria:**

1. Individual weights must be greater than 0%.
2. Individual weights cannot exceed 100%.
3. The total registered weight of a course cannot exceed 100%.
4. Total registered weights below 100% are permitted.
5. Rejected operations do not modify existing data.
6. Concurrent changes cannot violate total weight restrictions.

#### FR-026 — Grade Management

**Priority:** Must

The system shall allow users to register, modify, and remove
assessment grades.

**Acceptance Criteria:**

1. Grades within the configured course scale are accepted.
2. Grades outside the configured scale are rejected.
3. An assessment may exist without a grade.
4. Removing a grade restores its ungraded status.
5. Academic indicators reflect all valid grade changes.

#### FR-027 — Assessment Scheduling

**Priority:** Must

The system shall allow users to register assessment dates
or submission deadlines.

**Acceptance Criteria:**

1. Valid dates and times can be registered.
2. Dates and times may be modified or removed.
3. Assessments without scheduled dates remain valid.
4. Scheduled assessments appear automatically in the calendar.

### 4.4. Performance Analysis

#### FR-028 — Current Weighted Average

**Priority:** Must

The system shall calculate the current weighted average of
each course using only graded assessments.

**Acceptance Criteria:**

1. The result considers the relative weights of graded
   assessments.
2. Ungraded assessments are excluded from the calculation.
3. The result is unavailable when no assessments are graded.
4. Grade or weight changes update the calculated result.

#### FR-029 — Final Weighted Average

**Priority:** Must

The system shall calculate the final weighted average of
a fully graded course.

**Acceptance Criteria:**

1. The final average is available only when the graded
   weight equals 100%.
2. Incomplete courses do not receive a final average.
3. The calculation follows the defined academic business rules.

#### FR-030 — Academic Progress Calculation

**Priority:** Must

The system shall calculate academic progress according to
assessment weights.

**Acceptance Criteria:**

1. The total registered weight is calculated.
2. The total graded weight is calculated.
3. Registered but ungraded weight is calculated.
4. Unallocated assessment weight is calculated.
5. The resulting values are consistent and remain within
   their permitted ranges.

#### FR-031 — Required Grade Estimation

**Priority:** Must

The system shall estimate the weighted average grade
required across the remaining course weight to achieve
the configured passing grade.

**Acceptance Criteria:**

1. Existing graded assessments contribute to the estimation.
2. All remaining course weight is considered.
3. Incomplete assessment planning is explicitly identified.
4. Guaranteed and unreachable passing scenarios are recognized.
5. Division by zero is prevented when a course is fully graded.
6. The result is presented as an estimation rather than an
   official academic outcome.

#### FR-032 — Academic Status Determination

**Priority:** Must

The system shall determine the academic status of a course
from its grades, weights, and grading parameters.

**Acceptance Criteria:**

1. Courses without graded assessments are identified.
2. Courses in progress receive the applicable calculated status.
3. Guaranteed and unreachable passing scenarios are identified.
4. Fully graded courses are classified as passed or failed.
5. Academic status is not determined by display rounding.
6. Status changes automatically when source data changes.

### 4.5. Academic Calendar

#### FR-033 — Academic Calendar Visualization

**Priority:** Must

The system shall provide a monthly academic calendar.

**Acceptance Criteria:**

1. Users can navigate between months.
2. Calendar items are displayed on their corresponding dates.
3. Only events associated with the authenticated user appear.
4. An empty calendar remains usable.

#### FR-034 — Assessment Calendar Integration

**Priority:** Must

The system shall automatically display scheduled assessments
within the academic calendar.

**Acceptance Criteria:**

1. Assessments with scheduled dates appear in the calendar.
2. Date changes update the corresponding calendar entries.
3. Deleted or unscheduled assessments disappear.
4. Assessment information is not duplicated as independent
   calendar event records.

#### FR-035 — Upcoming Assessment Consultation

**Priority:** Must

The system shall allow users to consult upcoming scheduled
assessments and deadlines.

**Acceptance Criteria:**

1. Upcoming assessments are ordered chronologically.
2. Past and unscheduled assessments are excluded.
3. Assessment names, dates, and related courses are available.
4. Only authorized assessments are returned.

#### FR-036 — Custom Academic Event Creation and Consultation

**Priority:** Should

The system shall allow users to create and retrieve custom
academic events.

**Acceptance Criteria:**

1. Events require a title and start date or time.
2. Descriptions and end times are optional.
3. End times cannot precede start times.
4. Events appear in the user's academic calendar.

#### FR-037 — Custom Academic Event Modification and Deletion

**Priority:** Should

The system shall allow users to modify and delete their
custom academic events.

**Acceptance Criteria:**

1. Valid event changes are persisted.
2. Event date restrictions remain enforced.
3. Deleted events disappear from the calendar.
4. Explicit deletion confirmation is required.
5. Event ownership is enforced.

### 4.6. Academic Dashboard

#### FR-038 — Active Academic Period Overview

**Priority:** Must

The system shall provide a consolidated overview of the
active academic period.

**Acceptance Criteria:**

1. The selected academic period is identified.
2. The number of registered courses is displayed.
3. The overview changes when another period becomes active.
4. Users without an active period receive an informative
   empty state and a way to select or create a period.

#### FR-039 — Academic Performance Indicators

**Priority:** Must

The system shall display academic performance and progress
indicators for courses in the active period.

**Acceptance Criteria:**

1. Current averages are displayed when available.
2. Graded assessment progress is displayed.
3. Relevant calculated academic statuses are displayed.
4. Indicators reflect changes to their source data.
5. Period-wide average indicators, if implemented, include
   only comparable course grades and clearly state their
   aggregation method.

#### FR-040 — Assessment Overview

**Priority:** Must

The system shall display upcoming and ungraded assessments
from the active academic period.

**Acceptance Criteria:**

1. Upcoming scheduled assessments are ordered chronologically.
2. Assessments without grades can be identified.
3. An ungraded assessment is not automatically classified
   as an incomplete submission.
4. Empty assessment lists are handled correctly.
5. Users can navigate to the corresponding course or assessment.

## 5. Non-Functional Requirements

### 5.1. Security and Privacy

#### NFR-001 — Secure Password Storage

**Priority:** Must

Passwords shall be stored using Argon2id password hashing.

Plaintext passwords shall never be persisted, logged, or
returned through the API.

**Verification:** Authentication tests, database inspection,
and code review.

#### NFR-002 — Secure Authentication

**Priority:** Must

Authentication credentials or sessions shall have a defined
expiration policy.

Invalid, expired, or terminated sessions shall be rejected.

Authentication endpoints shall implement appropriate
protection against repeated authentication attempts.

**Verification:** Authentication lifecycle and negative tests.

#### NFR-003 — Authorization and Data Isolation

**Priority:** Must

The backend shall enforce resource ownership independently
of frontend restrictions.

**Verification:** Automated cross-user access tests covering
read, create, update, and delete operations.

#### NFR-004 — Input and Query Security

**Priority:** Must

The application shall validate untrusted inputs and use
parameterized database queries.

User-provided content shall be rendered safely.

**Verification:** Input validation tests and security review.

#### NFR-005 — Secret Management

**Priority:** Must

Sensitive configuration values shall be provided through
environment variables or equivalent secure configuration.

Real secrets shall not be included in the public repository.

**Verification:** Repository and configuration review.

#### NFR-006 — Secure Communication

**Priority:** Must for public deployment

Public deployments shall use HTTPS for application
communication.

Authentication credentials shall not be transmitted through
insecure public connections.

**Verification:** Deployment configuration inspection.

### 5.2. Data Integrity and Reliability

#### NFR-007 — Referential Integrity

**Priority:** Must

The database shall enforce appropriate primary keys,
foreign keys, uniqueness constraints, and validation
constraints.

**Verification:** Database schema and integrity tests.

#### NFR-008 — Transactional Consistency

**Priority:** Must

Operations involving dependent data or shared business
constraints shall execute atomically.

Concurrent modifications shall not violate business rules.

**Verification:** Transaction rollback and concurrency tests.

#### NFR-009 — Academic Calculation Precision

**Priority:** Must

Academic calculations shall use decimal arithmetic with
explicit precision and rounding policies.

Display rounding shall not determine academic outcomes.

**Verification:** Automated calculation and boundary tests.

#### NFR-010 — Data Persistence

**Priority:** Must

Registered information shall remain available across user
sessions and normal application or container restarts.

Database storage shall use persistent storage.

**Verification:** Application and container restart tests.

### 5.3. Performance

#### NFR-011 — API Response Time

**Priority:** Should

Common academic API operations should achieve a 95th
percentile response time below 500 milliseconds.

The initial reference workload will include:

- 100 synthetic user accounts.
- Up to 10 academic periods per account.
- Up to 10 courses per academic period.
- Up to 20 assessments per course.
- Five concurrent simulated users.
- At least 100 measured requests per tested operation.

Measurements shall use a warmed-up application and database.

Authentication password hashing and initial startup operations
are excluded from this target.

The hardware, software configuration, test duration, and
workload shall be documented alongside the results.

**Verification:** Controlled performance testing.

#### NFR-012 — Dashboard Loading Performance

**Priority:** Should

The dashboard should display its initial academic data
within two seconds under controlled test conditions.

The browser, device, dataset, network conditions, and
measurement method shall be documented.

**Verification:** Browser performance measurement.

### 5.4. Usability and Accessibility

#### NFR-013 — Interface Consistency

**Priority:** Must

The application shall maintain consistent navigation,
terminology, form behavior, and feedback patterns.

The initial user interface shall be provided in Spanish.

**Verification:** Interface review and workflow testing.

#### NFR-014 — Responsive Interface

**Priority:** Must

Core application interfaces shall adapt to desktop, tablet,
and mobile browser dimensions.

Reference viewport widths:

- 360 pixels.
- 768 pixels.
- 1440 pixels.

Core controls shall remain accessible without unintended
page-level horizontal overflow.

**Verification:** Responsive interface testing.

#### NFR-015 — Basic Accessibility

**Priority:** Must

Core workflows shall support keyboard navigation, visible
focus indicators, accessible form labels, and readable
contrast.

Information shall not rely exclusively on color.

Normal text should meet a contrast ratio of at least 4.5:1,
with 3:1 permitted for large text.

**Verification:** Manual and automated accessibility checks.

Full accessibility certification is outside the MVP scope.

#### NFR-016 — Error Handling

**Priority:** Must

The system shall provide understandable validation and
operation error messages.

Internal stack traces, credentials, and sensitive database
details shall not be exposed to users.

**Verification:** Invalid input and failure scenario tests.

### 5.5. Maintainability

#### NFR-017 — Modular Architecture

**Priority:** Must

The application shall separate presentation, API,
business logic, and data access responsibilities.

Academic calculations shall be independently testable.

**Verification:** Architecture and code review.

#### NFR-018 — Code Quality and Consistency

**Priority:** Should

The codebase should follow consistent naming, formatting,
and static analysis conventions.

Project identifiers, source code, and technical
documentation should use English.

**Verification:** Automated linting, formatting checks,
and code review.

### 5.6. Portability and Compatibility

#### NFR-019 — Reproducible Execution

**Priority:** Must

The application shall support reproducible local execution
using Docker and Docker Compose.

Required configuration shall be documented and example
environment variables shall be provided.

**Verification:** Installation and execution from a clean
project environment.

#### NFR-020 — Browser Compatibility

**Priority:** Should

Core application workflows should function in supported
stable desktop versions of:

- Google Chrome.
- Microsoft Edge.
- Mozilla Firefox.

Tested browser versions shall be recorded during verification.

**Verification:** Cross-browser workflow testing.

### 5.7. Testability

#### NFR-021 — Automated Testing

**Priority:** Must

Core academic calculations, validation rules, authentication,
and authorization shall be covered by automated tests.

Academic calculation service modules shall achieve at least
80% line coverage.

Relevant boundary conditions and failure scenarios shall
be tested regardless of the measured coverage percentage.

Automated tests shall be executable through continuous
integration.

**Verification:** Test execution and coverage reports.

### 5.8. Documentation

#### NFR-022 — Technical Documentation

**Priority:** Must

The project shall maintain documentation covering:

- Project requirements and business rules.
- Software architecture.
- Database design.
- API endpoints.
- Installation and configuration.
- Test execution.
- Known limitations.

The API shall expose appropriate OpenAPI documentation
in the development environment.

**Verification:** Documentation review and execution of
documented procedures.

## 6. Requirements Traceability

| Module | Requirements | Related Business Rules |
|---|---|---|
| User Management | FR-001 to FR-007 | BR-001 to BR-005 |
| Academic Management | FR-008 to FR-020 | BR-006 to BR-020 |
| Assessment Management | FR-021 to FR-027 | BR-021 to BR-030 |
| Performance Analysis | FR-028 to FR-032 | BR-031 to BR-037 |
| Academic Calendar | FR-033 to FR-037 | BR-038, BR-039 |
| Academic Dashboard | FR-038 to FR-040 | BR-031 to BR-040 |

Ownership, security, data integrity, and validation rules
apply across all relevant modules.

Detailed traceability between individual requirements,
use cases, implementation tasks, and automated tests will
be established during subsequent development phases.

## 7. Requirements Summary

### 7.1. Functional Requirements

| Module | Must | Should | Could | Total |
|---|---:|---:|---:|---:|
| User Management | 5 | 2 | 0 | 7 |
| Academic Management | 9 | 2 | 2 | 13 |
| Assessment Management | 7 | 0 | 0 | 7 |
| Performance Analysis | 5 | 0 | 0 | 5 |
| Academic Calendar | 3 | 2 | 0 | 5 |
| Academic Dashboard | 3 | 0 | 0 | 3 |
| **Total** | **32** | **6** | **2** | **40** |

### 7.2. Non-Functional Requirements

| Category | Total |
|---|---:|
| Security and Privacy | 6 |
| Data Integrity and Reliability | 4 |
| Performance | 2 |
| Usability and Accessibility | 4 |
| Maintainability | 2 |
| Portability and Compatibility | 2 |
| Testability | 1 |
| Documentation | 1 |
| **Total** | **22** |

## 8. Requirements Management

New requirements and changes to existing requirements shall
be evaluated against the approved MVP scope.

Mandatory requirements should not be removed or downgraded
without documenting the reason and updating the project scope.

Deferred Should and Could requirements shall remain tracked
in the project backlog.

Changes affecting business rules, database design, architecture,
API contracts, or test cases shall be reflected in their
corresponding documentation.

## 9. Related Documentation

- [Project Overview](project-overview.md)
- [Business Rules](business-rules.md)
- [Development Roadmap](roadmap.md)
- [Use Cases](../design/use-cases.md)
- [Database Design](../design/database-design.md)
- [Software Architecture](../design/architecture.md)
- [REST API Design](../design/api-design.md)

## 10. Document Status

This document establishes the initial software requirements
specification of UniTrack.

The requirements may be refined as system design,
implementation, and verification progress.

Changes shall preserve traceability and remain consistent
with the project objectives and approved MVP scope.
