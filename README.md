
# UniTrack

UniTrack is a web-based academic management and performance
tracking platform designed for university students.

The platform aims to centralize academic information, simplify
the organization of courses and assessments, and provide tools
for monitoring academic performance throughout a student's
university journey.

## Project Overview

University students often need to manage multiple courses,
assessments, deadlines, and grades across different platforms
and tools.

UniTrack aims to address this problem by providing a centralized
environment where students can organize their academic
responsibilities, track their progress, and make informed
decisions about their academic performance.

## Objectives

- Centralize academic information in a single platform.
- Simplify the management of courses and assessments.
- Automate weighted grade calculations.
- Estimate the grades required to achieve academic goals.
- Support academic planning through a calendar.
- Provide meaningful academic performance indicators.
- Develop a modular, maintainable, and secure application.

## Planned Features

The initial version of UniTrack will include:

- User registration and authentication.
- Academic period management.
- Course management.
- Assessment and grade tracking.
- Weighted average calculation.
- Required grade estimation.
- Academic performance dashboard.
- Academic calendar.
- User profile management.

## Technology Stack

### Frontend

- React
- TypeScript
- Vite
- React Router

### Backend

- Python
- FastAPI
- Pydantic
- SQLAlchemy
- Alembic

### Database

- PostgreSQL

### Infrastructure and Development Tools

- Docker
- Docker Compose
- Git
- GitHub
- GitHub Actions

### Testing

- Pytest

## Architecture

UniTrack will follow a client-server architecture consisting of
three main components:

- **Frontend:** A React-based web interface responsible for user
  interaction and data visualization.
- **Backend:** A modular FastAPI application responsible for
  business logic, authentication, validation, and API services.
- **Database:** A PostgreSQL relational database responsible for
  persistent data storage and integrity.

Communication between the frontend and backend will be handled
through a REST API.

Docker Compose will be used to provide a consistent and
reproducible development environment.

## Project Status

**Current phase: Planning and Design**

UniTrack is currently in its initial planning stage.
Implementation has not started yet.

## Development Roadmap

- [ ] Phase 0 - Planning and design
- [ ] Phase 1 - Development environment setup
- [ ] Phase 2 - Database implementation
- [ ] Phase 3 - Backend foundation and authentication
- [ ] Phase 4 - Academic management API
- [ ] Phase 5 - Frontend development
- [ ] Phase 6 - Integration and testing
- [ ] Phase 7 - Documentation and deployment

## Documentation

Project planning and technical design documentation will be
maintained in the `docs/` directory.

The documentation will cover:

- Project scope and objectives.
- Functional and non-functional requirements.
- Business rules.
- Use cases.
- Database design.
- Software architecture.
- REST API design.
- User interface wireframes.
- Development roadmap.

## Project Purpose

UniTrack is a personal software engineering project developed
to apply and strengthen knowledge in:

- Full-stack web development.
- Software engineering.
- Relational database design.
- REST API development.
- Software architecture.
- Automated testing.
- Version control.
- Containerization and deployment.


## License

This project is licensed under the MIT License.

See the [LICENSE](LICENSE) file for more information.
