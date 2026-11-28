

-- UniTrack - PostgreSQL Reference Database Schema

-- Version: 1.0
-- Phase: Phase 0 - Planning and Design
--
-- This file documents the proposed physical database model.
-- It is not the authoritative migration mechanism.
--
-- Cross-record academic rules and resource authorization
-- require the application transaction protocols described
-- in database-design.md.
--
-- Intended for initial creation in an empty database schema.

BEGIN;

-- 1. USERS

CREATE TABLE users (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    display_name VARCHAR(100) NOT NULL,
    email VARCHAR(254) NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_users
        PRIMARY KEY (id),

    CONSTRAINT uq_users_email
        UNIQUE (email),

    CONSTRAINT ck_users_display_name
        CHECK (display_name ~ '[^[:space:]]'),

    CONSTRAINT ck_users_email_normalized
        CHECK (
            email <> ''
            AND email = LOWER(BTRIM(email))
            AND email !~ '[[:space:]]'
        ),

    CONSTRAINT ck_users_password_hash
        CHECK (password_hash ~ '[^[:space:]]')
);

-- 2. ACADEMIC PERIODS

CREATE TABLE academic_periods (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_academic_periods
        PRIMARY KEY (id),

    CONSTRAINT fk_academic_periods_users
        FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT ck_academic_periods_name
        CHECK (name ~ '[^[:space:]]'),

    CONSTRAINT ck_academic_periods_date_range
        CHECK (end_date >= start_date)
);

-- 3. COURSES

CREATE TABLE courses (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    academic_period_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    code VARCHAR(30),
    credits INTEGER,
    min_grade NUMERIC(5, 2) NOT NULL DEFAULT 1.00,
    max_grade NUMERIC(5, 2) NOT NULL DEFAULT 7.00,
    passing_grade NUMERIC(5, 2) NOT NULL DEFAULT 4.00,
    color VARCHAR(7),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_courses
        PRIMARY KEY (id),

    CONSTRAINT fk_courses_academic_periods
        FOREIGN KEY (academic_period_id)
        REFERENCES academic_periods (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,

    CONSTRAINT ck_courses_name
        CHECK (name ~ '[^[:space:]]'),

    CONSTRAINT ck_courses_code
        CHECK (
            code IS NULL
            OR code ~ '[^[:space:]]'
        ),

    CONSTRAINT ck_courses_credits
        CHECK (
            credits IS NULL
            OR credits >= 0
        ),

    CONSTRAINT ck_courses_grading_scale
        CHECK (
            min_grade >= 0
            AND max_grade <= 100
            AND min_grade < max_grade
            AND passing_grade >= min_grade
            AND passing_grade <= max_grade
        ),

    CONSTRAINT ck_courses_color
        CHECK (
            color IS NULL
            OR color ~ '^#[0-9A-Fa-f]{6}$'
        )
);

-- 4. ASSESSMENTS

CREATE TABLE assessments (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    weight NUMERIC(5, 2) NOT NULL,
    grade NUMERIC(5, 2),
    scheduled_date DATE,
    scheduled_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_assessments
        PRIMARY KEY (id),

    CONSTRAINT fk_assessments_courses
        FOREIGN KEY (course_id)
        REFERENCES courses (id)
        ON DELETE CASCADE
        ON UPDATE RESTRICT,

    CONSTRAINT ck_assessments_name
        CHECK (name ~ '[^[:space:]]'),

    CONSTRAINT ck_assessments_description_length
        CHECK (
            description IS NULL
            OR CHAR_LENGTH(description) <= 2000
        ),

    CONSTRAINT ck_assessments_weight
        CHECK (
            weight > 0
            AND weight <= 100
        ),

    CONSTRAINT ck_assessments_grade_domain
        CHECK (
            grade IS NULL
            OR (grade >= 0 AND grade <= 100)
        ),

    CONSTRAINT ck_assessments_schedule
        CHECK (
            scheduled_date IS NULL
            OR scheduled_at IS NULL
        )
);

-- 5. CUSTOM ACADEMIC EVENTS

CREATE TABLE calendar_events (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    start_at TIMESTAMPTZ,
    end_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_calendar_events
        PRIMARY KEY (id),

    CONSTRAINT fk_calendar_events_users
        FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT ck_calendar_events_title
        CHECK (title ~ '[^[:space:]]'),

    CONSTRAINT ck_calendar_events_description_length
        CHECK (
            description IS NULL
            OR CHAR_LENGTH(description) <= 2000
        ),

    CONSTRAINT ck_calendar_events_temporal_mode
        CHECK (
            (
                start_date IS NOT NULL
                AND start_at IS NULL
                AND end_at IS NULL
                AND (
                    end_date IS NULL
                    OR end_date >= start_date
                )
            )
            OR
            (
                start_at IS NOT NULL
                AND start_date IS NULL
                AND end_date IS NULL
                AND (
                    end_at IS NULL
                    OR end_at >= start_at
                )
            )
        )
);

-- 6. INDEXES

-- Academic period ownership queries.

CREATE INDEX ix_academic_periods_user_id
ON academic_periods (user_id);

-- At most one active period per user.

CREATE UNIQUE INDEX ux_academic_periods_active_user
ON academic_periods (user_id)
WHERE is_active = TRUE;

-- Course retrieval and dependent deletion.

CREATE INDEX ix_courses_academic_period_id
ON courses (academic_period_id);

-- Assessment retrieval and academic calculations.

CREATE INDEX ix_assessments_course_id
ON assessments (course_id);

-- Date-only assessment scheduling.

CREATE INDEX ix_assessments_scheduled_date
ON assessments (scheduled_date)
WHERE scheduled_date IS NOT NULL;

-- Timestamp-based assessment scheduling.

CREATE INDEX ix_assessments_scheduled_at
ON assessments (scheduled_at)
WHERE scheduled_at IS NOT NULL;

-- Personal calendar event retrieval.

CREATE INDEX ix_calendar_events_user_id
ON calendar_events (user_id);

-- 7. RECORD LIFECYCLE FUNCTION

CREATE FUNCTION set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.created_at := OLD.created_at;
    NEW.updated_at := clock_timestamp();

    RETURN NEW;
END;
$$;

-- 8. UPDATE TIMESTAMP TRIGGERS

CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_academic_periods_updated_at
BEFORE UPDATE ON academic_periods
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_courses_updated_at
BEFORE UPDATE ON courses
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_assessments_updated_at
BEFORE UPDATE ON assessments
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_calendar_events_updated_at
BEFORE UPDATE ON calendar_events
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- 9. APPLICATION-ENFORCED BUSINESS RULES

-- The following conditions are not fully enforced by
-- declarative constraints in this reference schema:
--
-- 1. Authenticated resource ownership.
-- 2. Immutable resource identifiers and parent relationships.
-- 3. Total assessment weight <= 100% per course.
-- 4. Assessment grades within course-specific grading scales.
-- 5. Grading configuration changes preserving existing grades.
-- 6. Rejection of numeric input beyond two decimal places
--    before NUMERIC column coercion.
-- 7. Explicit confirmation of permanent deletion.
-- 8. Valid email format and password security policies.
-- 9. Finite calendar dates and timezone-aware input.
-- 10. Academic calculations and derived calendar information.
--
-- These conditions shall be enforced by the application
-- services using the validation and transaction protocols
-- specified in database-design.md.
--
-- Authentication session persistence, database roles,
-- permissions, and deployment configuration will be defined
-- during subsequent architecture and implementation phases.

COMMIT;
