# Planzo API

## Overview
Planzo is a robust API-based system built with Ruby on Rails, designed to manage projects, tasks, and users efficiently. This API allows seamless project and task management while maintaining user authentication and role-based access control.

## Features
- **User Authentication & Authorization**: Secure user authentication with role-based access.
- **Project Management**: Create, update, and manage projects with defined durations and start times.
- **Task Management**: Associate tasks with projects, define durations, and track completion.

## ERD (Entity Relationship Diagram)
The database schema consists of the following core models:

- **User**: Manages user authentication and roles.
- **Project**: Defines project details and duration.
- **Task**: Tracks task-specific details linked to a project.
- **ProjectUser**: Manages user assignments to projects.

## Technologies Used
- **Ruby on Rails** (API Mode)
- **PostgreSQL** (Database)
- **RSpec** (Testing)
- **GrapeSwagger** (Api Documentation)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ahtishamhafeez/planzo.git
   cd planzo
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Start the server:
   ```bash
   rails s
   ```

## API Endpoints
### Authentication
- **POST /api/v1/users/auth** – Authenticate users and receive a JWT token.

### Users
- **GET /api/v1/users/users** – List all users.
- **GET /api/v1/users/users/:id** – Retrieve a specific user.

### Projects
- **GET /api/v1/projects** – List all projects.
- **POST /api/v1/projects** – Create a new project.
- **GET /api/v1/projects/:id** – Retrieve project details.
- **GET /api/v1/projects/:user_id/assign** – Assign project to user.

### Tasks
- **GET /api/v1/tasks/** – List all tasks for a project.
- **POST /api/v1/tasks/** – Create a task.

## Testing
Run the test suite with:
```bash
rspec
```

## Contributing
1. Fork the repository.
2. Create a new branch (`feature-branch`).
3. Commit your changes.
4. Push to your fork and submit a pull request.


## Contact
For any inquiries, contact [ahtsham232@gmail.com](mailto:your-email@example.com).

