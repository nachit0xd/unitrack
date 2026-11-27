
# UniTrack — Business Rules

## Document Information

| Field | Value |
|---|---|
| Project | UniTrack |
| Document | Business Rules |
| Version | 1.0 |
| Status | Initial Specification |
| Project Phase | Phase 0 - Planning and Design |

## 1. Introduction

### 1.1. Purpose

This document defines the business rules, academic constraints,
data integrity conditions, and calculation policies that govern
the behavior of UniTrack.

These rules establish the expected behavior of the academic
domain independently of its technical implementation.

### 1.2. Scope

The business rules apply to the Minimum Viable Product
of UniTrack.

The initial academic calculation model supports numerical
grading scales and simple percentage-based weighted assessments.

Advanced institutional grading mechanisms are excluded from
the initial version.

### 1.3. Rule Identification

Each business rule is identified using the following convention:

BR-XXX

Business rule identifiers shall remain stable throughout
the development lifecycle.

## 2. Domain Terminology

| Term | Definition |
|---|---|
| User | A registered individual who manages personal academic information. |
| Academic Period | A user-defined academic interval, such as a semester or trimester. |
| Active Academic Period | The selected period used as the default academic context. |
| Course | An academic subject registered within an academic period. |
| Assessment | An evaluation component contributing to a course grade. |
| Grade | A numerical result assigned to an assessment. |
| Weight | The percentage contribution of an assessment to a course's final grade. |
| Grading Scale | The permitted numerical grade range of a course. |
| Passing Grade | The minimum final grade required for course approval. |
| Registered Weight | The sum of all registered assessment weights. |
| Graded Weight | The sum of weights associated with graded assessments. |
| Ungraded Weight | Registered assessment weight without grades. |
| Unallocated Weight | Course weight not yet assigned to registered assessments. |
| Current Average | Weighted average normalized over graded assessments. |
| Final Average | Weighted average of a fully graded course. |
| Custom Academic Event | A user-created calendar item independent of assessments. |

## 3. User and Ownership Rules

### BR-001 — Unique User Identity

Every registered user shall have a unique system identifier.

The identifier shall remain associated with the user throughout
the lifetime of the account.

### BR-002 — Unique Email Address

Every registered user shall have a unique normalized email
address.

Email normalization shall include the removal of surrounding
whitespace and conversion to lowercase according to the
application's account identity policy.

Duplicate normalized email addresses shall not be accepted.

### BR-003 — Academic Data Ownership

Users shall only be permitted to access, create, modify,
or delete academic information within their own ownership scope.

Academic information includes:

- Academic periods.
- Courses.
- Assessments.
- Grades.
- Custom academic events.
- Derived academic performance information.

### BR-004 — Authentication Requirement

Users shall be authenticated before accessing private
academic functionality.

Unauthenticated visitors may access public pages and
authentication functionality.

### BR-005 — Ownership Resolution

Resource ownership shall be determined using the
authenticated user identity and persisted resource relationships.

The system shall not trust client-provided ownership identifiers
without server-side verification.

Ownership shall propagate through the academic hierarchy:

User -> Academic Period -> Course -> Assessment

Custom academic events belong directly to their respective users.

## 4. Academic Period Rules

### BR-006 — Academic Period Ownership

Every academic period shall belong to exactly one user.

An academic period cannot exist without an associated user.

### BR-007 — Multiple Academic Periods

A user may register multiple academic periods.

Users are not restricted to a predefined number of semesters
or academic years.

Overlapping academic period dates are permitted.

### BR-008 — Academic Period Required Information

An academic period shall contain:

- A non-empty name.
- A start date.
- An end date.
- An associated user.

### BR-009 — Academic Period Date Range

The end date of an academic period shall not precede
its start date.

Periods with identical start and end dates are permitted.

Academic period dates describe the intended academic interval.
They do not automatically restrict the scheduling of assessments.

### BR-010 — Single Active Academic Period

A user may have zero or one active academic period.

Multiple active academic periods belonging to the same
user are not permitted.

The active period represents the default academic context
rather than an access restriction.

### BR-011 — Active Period Replacement

Activating an academic period shall automatically deactivate
the previously active period belonging to the same user.

The activation and deactivation operations shall be atomic.

A newly registered user may initially have no active period.

### BR-012 — Academic Period Deletion

Deleting an academic period shall permanently remove:

- The academic period.
- Its associated courses.
- Assessments belonging to those courses.

The user shall receive an explicit confirmation request
before the deletion operation.

The operation shall be transactional.

Custom academic events shall not be deleted solely because
an academic period is removed.

If the deleted period was active, the user shall remain
without an active period until another period is selected.

### BR-013 — Historical Academic Period Access

Inactive and previous academic periods shall remain
accessible to their owners.

Users may consult and modify historical academic information
without activating the corresponding period.

The application shall not automatically delete information
when an academic period ends.

## 5. Course Rules

### BR-014 — Course Ownership and Association

Every course shall belong to exactly one academic period.

A course cannot exist independently of an academic period.

Course ownership is inherited from its parent academic period.

### BR-015 — Course Identification

Every course shall have a non-empty name.

A course code may be registered optionally.

Course names are not required to be globally unique.

The same course may be registered in different academic periods.

### BR-016 — Course Grading Configuration

Every course shall have:

- A minimum grade.
- A maximum grade.
- A passing grade.

Default configuration:

| Parameter | Default Value |
|---|---:|
| Minimum grade | 1.00 |
| Maximum grade | 7.00 |
| Passing grade | 4.00 |

The default configuration represents the initial
Chilean academic context.

If custom grading configuration is implemented, users may
modify these parameters within the supported numeric domain.

### BR-017 — Grading Scale Validity

The minimum grade shall be strictly lower than the
maximum grade.

A grading scale with identical minimum and maximum values
is invalid.

### BR-018 — Passing Grade Validity

The passing grade shall be greater than or equal to the
minimum grade and less than or equal to the maximum grade.

The passing grade shall not exist outside the configured
grading scale.

### BR-019 — Grading Configuration Modification

Changes to a grading scale shall not invalidate previously
registered assessment grades.

If an existing grade would fall outside the proposed
grading scale, the configuration change shall be rejected.

Grades shall not be automatically rescaled or clamped.

Valid changes to grading parameters shall update the
corresponding calculated academic indicators.

### BR-020 — Course Deletion

Deleting a course shall permanently remove its associated
assessments.

The user shall explicitly confirm the deletion.

The operation shall be transactional and shall not affect
unrelated courses or academic periods.

## 6. Assessment and Grade Rules

### BR-021 — Assessment Association

Every assessment shall belong to exactly one course.

An assessment cannot exist independently of a course.

Assessment ownership is inherited through its associated
course and academic period.

### BR-022 — Assessment Required Information

Every assessment shall contain:

- A non-empty name.
- A valid percentage-based weight.
- An associated course.

The following information is optional:

- Description.
- Grade.
- Scheduled date and time.

### BR-023 — Individual Assessment Weight

Every assessment weight shall be greater than 0% and
less than or equal to 100%.

Zero and negative weights are invalid.

Weights above 100% are invalid.

### BR-024 — Total Assessment Weight

The sum of registered assessment weights associated with
a course shall not exceed 100%.

This rule applies to assessment creation and modification.

An operation violating this rule shall be rejected without
modifying existing information.

Concurrent operations shall not cause the total registered
weight to exceed 100%.

### BR-025 — Incomplete Assessment Planning

The total registered weight of a course may be below 100%.

Incomplete assessment planning is a valid intermediate state.

The application shall distinguish between:

- Registered weight.
- Graded weight.
- Registered but ungraded weight.
- Unallocated weight.

A course shall not be considered fully graded while any
course weight remains ungraded or unallocated.

### BR-026 — Ungraded Assessments

An assessment may exist without a registered grade.

Ungraded assessments shall remain available for consultation,
scheduling, and future grade registration.

An ungraded assessment shall not be interpreted as a
failed assessment or incomplete submission.

### BR-027 — Grade Validity

Every registered assessment grade shall belong to the
grading scale configured for its course.

The minimum and maximum grade values are inclusive.

Grades outside the permitted range shall be rejected.

### BR-028 — Missing Grade Representation

A missing grade shall be represented by a null value.

The system shall not substitute zero or another numerical
grade for missing academic information.

A numerical zero is a valid grade only when the configured
grading scale permits it.

### BR-029 — Academic Indicator Updates

Assessment creation, modification, deletion, and grade
changes shall be reflected in the corresponding calculated
academic performance indicators.

Derived indicators shall not become inconsistent with
their underlying assessment information.

### BR-030 — Grade Removal

Users shall be allowed to remove an assessment grade.

Removing a grade shall restore the assessment to its
ungraded state without deleting the assessment.

Academic performance calculations shall reflect this change.

## 7. Academic Calculation Rules

### BR-031 — Current Weighted Average

The current weighted average shall consider only
assessments with registered grades.

The result shall be normalized according to the total
graded assessment weight.

Ungraded assessments shall not be treated as zero-grade
assessments.

### BR-032 — Unavailable Current Average

When a course has no graded assessments, its current
weighted average shall be unavailable.

The application shall represent this condition using a
null value rather than a numerical zero.

Division by zero shall not occur.

### BR-033 — Final Weighted Average

A final weighted average shall only be available when the
graded assessment weight equals 100%.

A course with incomplete assessment planning or ungraded
assessment weight shall not have a final average.

### BR-034 — Derived Academic Information

Academic performance indicators shall be derived from
authoritative academic data.

The source data includes:

- Assessment grades.
- Assessment weights.
- Course grading parameters.

Calculated averages, progress values, and academic statuses
shall not be treated as independently editable source data.

### BR-035 — Required Grade Estimation

The estimated required grade shall represent the weighted
average necessary across all remaining course weight to
achieve the configured passing grade.

Remaining weight includes:

- Registered assessments without grades.
- Assessment weight not yet allocated to registered assessments.

An estimate based on incomplete assessment planning
shall be identified accordingly.

The required grade shall be unavailable when no course
weight remains.

### BR-036 — Passing Feasibility

Passing feasibility shall be determined using the minimum
and maximum grades allowed by the course grading scale.

Passing is guaranteed when the minimum possible final
average reaches the passing grade.

Passing is unreachable when the maximum possible final
average is lower than the passing grade.

Final passed or failed status shall only be assigned
when the course is fully graded.

These conclusions apply exclusively to the supported
simple weighted grading model.

### BR-037 — Calculation Precision and Rounding

Academic calculations shall use decimal arithmetic.

Assessment grades and weights shall support up to two
decimal places.

The initial supported numeric grading domain is:

- Minimum supported value: 0.00.
- Maximum supported value: 100.00.

The specific permitted range of each course is defined
by its own grading configuration.

Intermediate calculations shall avoid unnecessary rounding.

Display averages shall normally use two decimal places
with ROUND_HALF_UP rounding.

Passing decisions shall use the mathematical result before
display rounding.

Required grades shall be rounded upward to two decimal
places when presented as actionable targets.

When the mathematical result and its rounded representation
could imply different academic outcomes, the interface
shall provide additional precision or explanatory feedback.

The application shall not apply institution-specific
rounding policies in the initial version.

## 8. Calendar and Dashboard Rules

### BR-038 — Assessment Calendar Integration

Every assessment with a registered scheduled date shall
appear automatically in the academic calendar.

Calendar information derived from assessments shall not
be duplicated as independent event records.

Assessment date changes and deletions shall be reflected
in the calendar.

The calendar may display authorized academic information
from multiple academic periods.

### BR-039 — Custom Academic Events

Every custom academic event shall belong to exactly one user.

A custom academic event shall contain:

- A non-empty title.
- A start date or timestamp.
- An associated user.

A description and end date or timestamp are optional.

When provided, the end value shall not precede the
start value.

Custom events are independent of assessments and academic
periods in the initial data model.

### BR-040 — Dashboard Academic Context

The dashboard shall use the active academic period as
the primary context for academic indicators.

Only information belonging to the authenticated user
shall be displayed.

When no active period exists, the dashboard shall present
an informative empty state.

Upcoming assessments and ungraded assessments displayed
on the dashboard shall belong to the active period.

If an overall period average is implemented, it shall
use comparable grading scales and identify its aggregation
method.

## 9. Academic Calculation Specification

### 9.1. Notation

| Symbol | Meaning |
|---|---|
| g_i | Grade of assessment i |
| w_i | Percentage weight of assessment i |
| W_registered | Total registered weight |
| W_graded | Total graded weight |
| W_ungraded | Registered but ungraded weight |
| W_unallocated | Unallocated assessment weight |
| W_remaining | Total remaining course weight |
| A | Accumulated weighted contribution |
| G_current | Current weighted average |
| G_final | Final weighted average |
| G_pass | Passing grade |
| G_required | Required weighted average grade |
| G_min | Minimum grade of the scale |
| G_max | Maximum grade of the scale |
| G_lowest_final | Lowest possible final average |
| G_highest_final | Highest possible final average |

Let S represent all registered assessments.

Let C represent the subset of registered assessments
that have a non-null grade.

### 9.2. Registered Weight

$$
W_{registered} = \sum_{i \in S} w_i
$$

Valid range:

$$
0 \leq W_{registered} \leq 100
$$

### 9.3. Graded Weight

$$
W_{graded} = \sum_{i \in C} w_i
$$

Valid range:

$$
0 \leq W_{graded} \leq W_{registered}
$$

### 9.4. Ungraded and Unallocated Weight

$$
W_{ungraded} = W_{registered} - W_{graded}
$$

$$
W_{unallocated} = 100 - W_{registered}
$$

### 9.5. Remaining Weight

$$
W_{remaining} = 100 - W_{graded}
$$

Equivalently:

$$
W_{remaining} = W_{ungraded} + W_{unallocated}
$$

### 9.6. Accumulated Weighted Contribution

$$
A = \sum_{i \in C} g_i \frac{w_i}{100}
$$

The accumulated contribution represents the portion of
the final course average already determined by graded
assessments.

### 9.7. Current Weighted Average

When graded weight is greater than zero:

$$
G_{current} = \frac{A}{W_{graded}/100}
$$

Equivalent expression:

$$
G_{current} =
\frac{\sum_{i \in C} g_i w_i}
{\sum_{i \in C} w_i}
$$

When graded weight equals zero, the current weighted
average is null.

### 9.8. Final Weighted Average

The final weighted average is available only when:

$$
W_{graded} = 100
$$

In this case:

$$
G_{final} = A
$$

Otherwise, the final weighted average is null.

### 9.9. Required Grade Estimation

When remaining weight is greater than zero:

$$
G_{required} =
\frac{G_{pass} - A}{W_{remaining}/100}
$$

The result represents the weighted average necessary
across all remaining course weight.

Interpretation:

- If the required grade is less than or equal to the
  minimum grade, passing is guaranteed.
- If the required grade is greater than the maximum
  grade, passing is unreachable.
- Otherwise, the required grade is within the supported
  grading scale.

The displayed actionable target shall not be lower than
the minimum permitted grade.

Feasibility shall be determined before display rounding.

When remaining weight equals zero, the required grade
is null.

### 9.10. Minimum Possible Final Average

$$
G_{lowest\_final} =
A + G_{min}\frac{W_{remaining}}{100}
$$

### 9.11. Maximum Possible Final Average

$$
G_{highest\_final} =
A + G_{max}\frac{W_{remaining}}{100}
$$

These values represent the theoretical lower and upper
bounds of the final course average.

### 9.12. Academic Status

Academic status shall be evaluated in the following order:

1. Determine whether the course is fully graded.
2. If fully graded, classify the course as passed or failed.
3. If no assessments are graded, classify it as not started.
4. Determine whether passing is guaranteed.
5. Determine whether passing is unreachable.
6. Otherwise, classify the course as in progress.

| Status | Condition |
|---|---|
| NOT_STARTED | Graded weight equals zero. |
| IN_PROGRESS | Course is partially graded and neither guaranteed nor unreachable. |
| PASS_GUARANTEED | Course is partially graded and its minimum possible final average reaches the passing grade. |
| PASS_UNREACHABLE | Course is partially graded and its maximum possible final average is below the passing grade. |
| PASSED | Course is fully graded and its final average reaches the passing grade. |
| FAILED | Course is fully graded and its final average is below the passing grade. |

These statuses are derived from current academic information.

They do not represent official institutional course results.

### 9.13. Planning Completeness

Assessment planning shall be considered complete when:

$$
W_{registered} = 100
$$

A course shall be considered fully graded when:

$$
W_{graded} = 100
$$

Planning completeness and grading completeness are
independent academic concepts.

### 9.14. Precision Policy

| Data | Policy |
|---|---|
| Assessment grades | Up to two decimal places |
| Assessment weights | Up to two decimal places |
| Stored grading parameters | Up to two decimal places |
| Internal calculations | Decimal arithmetic |
| Display averages | ROUND_HALF_UP to two decimal places |
| Required grade display | Round upward to two decimal places |
| Passing comparisons | Mathematical result before display rounding |

Input values exceeding supported decimal precision shall
be rejected rather than silently rounded.

The implementation shall use sufficient decimal precision
for intermediate calculations.

Comparisons involving a final weighted contribution shall
avoid unnecessary division and rounding.

### 9.15. Period-Wide Performance Indicators

An optional period-wide average may be calculated using
the arithmetic mean of available current course averages.

Only courses using comparable grading scales shall
participate in the calculation.

Courses without available current averages shall be excluded.

Academic credits shall not affect the initial aggregation.

The resulting indicator shall be identified as an informal
period-wide performance summary rather than an official
institutional GPA.

If no comparable averages are available, the indicator
shall be unavailable.

## 10. Calculation Reference Example

Consider a course with the following grading configuration:

- Minimum grade: 1.00.
- Maximum grade: 7.00.
- Passing grade: 4.00.

| Assessment | Grade | Weight |
|---|---:|---:|
| Assessment 1 | 5.50 | 30% |
| Assessment 2 | 4.80 | 25% |
| Project | Not graded | 25% |

### 10.1. Expected Weight Values

| Indicator | Value |
|---|---:|
| Registered weight | 80% |
| Graded weight | 55% |
| Ungraded weight | 25% |
| Unallocated weight | 20% |
| Remaining weight | 45% |

### 10.2. Accumulated Weighted Contribution

$$
A = 5.50(0.30) + 4.80(0.25) = 2.85
$$

### 10.3. Current Average

$$
G_{current} = \frac{2.85}{0.55}
$$

Displayed current average: 5.18.

### 10.4. Required Grade

$$
G_{required} = \frac{4.00 - 2.85}{0.45}
$$

Displayed required weighted average: 2.56.

The required grade includes unallocated assessment weight.

Assessment planning is incomplete.

### 10.5. Possible Final Average Range

$$
G_{lowest\_final} = 2.85 + 1.00(0.45) = 3.30
$$

$$
G_{highest\_final} = 2.85 + 7.00(0.45) = 6.00
$$

Expected academic status: IN_PROGRESS.

Expected final average: null.

## 11. Additional Validation Policies

### 11.1. Text Validation

Required names and titles shall not be empty or contain
only whitespace.

Text fields shall have explicit maximum lengths defined
during database and API design.

### 11.2. Temporal Information

Academic period boundaries shall use calendar dates.

Scheduled assessments and custom academic events shall
support date and time information.

Timestamp-based values shall be stored using a
timezone-aware representation.

The initial presentation timezone shall default to
America/Santiago.

Date-only input may be supported and must preserve its
calendar-day meaning through an appropriate representation.

### 11.3. Optional Academic Credits

If implemented, academic credits shall be non-negative
integer values.

Missing credit information shall be represented as null.

Credits shall not modify individual course assessment weights.

### 11.4. Optional Course Colors

If implemented, course colors shall use supported hexadecimal
RGB color values in the format #RRGGBB.

The color field may be optional.

### 11.5. Invalid Operations

Operations violating required business rules shall be rejected.

A failed operation shall not partially modify persisted
academic information.

Validation errors shall identify the relevant problem
without exposing internal implementation details.

## 12. Preliminary Verification Scenarios

Unless otherwise specified, the following scenarios use:

- Minimum grade: 1.00.
- Maximum grade: 7.00.
- Passing grade: 4.00.

| ID | Scenario | Expected Result |
|---|---|---|
| TC-BR-001 | Course without assessments | Current and final averages are null. |
| TC-BR-002 | Grade 5.00 with weight 40% | Current average 5.00; required grade display 3.34. |
| TC-BR-003 | Grades 5.00 and 3.00, each weighted 50% | Final average 4.00; PASSED. |
| TC-BR-004 | Grades 3.00 and 4.00, each weighted 50% | Final average 3.50; FAILED. |
| TC-BR-005 | Grade 6.00 with weight 80% | Lowest possible final average 5.00; PASS_GUARANTEED. |
| TC-BR-006 | Grade 2.00 with weight 80% | Highest possible final average 3.00; PASS_UNREACHABLE. |
| TC-BR-007 | Assessment weights of 60% and 50% | Operation rejected. |
| TC-BR-008 | Grade 7.50 | Grade rejected. |
| TC-BR-009 | Assessment weight of 0% | Weight rejected. |
| TC-BR-010 | Ungraded assessment weighted 100% | Current average null; required grade 4.00. |
| TC-BR-011 | Grades 3.99 and 4.00, each weighted 50% | Exact final average 3.995; FAILED. |
| TC-BR-012 | Removal of the only registered grade | Current average null; graded weight 0%. |
| TC-BR-013 | Activate a second academic period | Previous period becomes inactive. |
| TC-BR-014 | Access a resource owned by another user | Access denied. |
| TC-BR-015 | Modify a scale so an existing grade becomes invalid | Modification rejected. |
| TC-BR-016 | Delete an assessment with a scheduled date | Assessment and derived calendar item removed. |
| TC-BR-017 | Create a period with end date before start date | Creation rejected. |
| TC-BR-018 | Concurrent assessment changes exceeding 100% | Invalid combined state prevented. |
| TC-BR-019 | Assessment with no registered grade | Assessment remains valid and ungraded. |
| TC-BR-020 | Delete an active academic period | Dependent data removed; no active period remains. |
| TC-BR-021 | Fully graded course requests required grade | Required grade is null. |
| TC-BR-022 | Two accounts use the same normalized email | Duplicate account registration rejected. |

These scenarios provide an initial verification reference.

Detailed automated test cases will be created during
implementation.

## 13. Rule Enforcement Strategy

Business rules shall be enforced through an appropriate
combination of application validation, business services,
authorization controls, and database integrity mechanisms.

| Layer | Responsibility |
|---|---|
| Frontend | Immediate form feedback, confirmations, and presentation. |
| API | Request validation, authentication, and response contracts. |
| Business Services | Academic calculations, cross-record validation, and domain operations. |
| Database | Referential integrity, uniqueness, row-level constraints, and transaction support. |

Frontend validation shall not replace backend enforcement.

Rules involving multiple records, such as total assessment
weights, shall be protected against concurrent modifications.

The detailed enforcement mechanism of each rule will be
defined during database and architecture design.

## 14. Business Rule Traceability

| Rule Range | Domain | Related Requirements |
|---|---|---|
| BR-001 to BR-005 | Users and ownership | FR-001 to FR-007 |
| BR-006 to BR-013 | Academic periods | FR-008 to FR-013 |
| BR-014 to BR-020 | Courses | FR-014 to FR-020 |
| BR-021 to BR-030 | Assessments and grades | FR-021 to FR-027 |
| BR-031 to BR-037 | Academic calculations | FR-028 to FR-032 |
| BR-038, BR-039 | Academic calendar | FR-033 to FR-037 |
| BR-040 | Academic dashboard | FR-038 to FR-040 |

Cross-cutting ownership, security, integrity, and calculation
rules may apply to multiple functional requirements.

## 15. Academic Model Limitations

The initial version does not support:

- Nested assessment weighting structures.
- Mandatory minimum examination grades.
- Examination exemption mechanisms.
- Grade replacement policies.
- Attendance-based passing conditions.
- Institution-specific rounding rules.
- Official academic record synchronization.
- Complex institutional GPA calculation.

All academic indicators depend on user-provided information.

UniTrack shall not be considered a replacement for official
institutional academic systems.

## 16. Related Documentation

- [Project Overview](project-overview.md)
- [Software Requirements](requirements.md)
- [Development Roadmap](roadmap.md)
- [Use Cases](../design/use-cases.md)
- [Database Design](../design/database-design.md)
- [Software Architecture](../design/architecture.md)
- [REST API Design](../design/api-design.md)

## 17. Document Status

This document establishes the initial business rules and
academic calculation model of UniTrack.

The rules shall guide subsequent functional modeling,
database design, architecture, implementation, and testing.

Changes to business rules shall be documented and evaluated
against their effects on system requirements, persisted data,
academic calculations, and existing test cases.
