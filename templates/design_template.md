# System Design: {{TASK_ID}}

## 1. Architecture Overview

[High-level diagram and description]

```
[ASCII diagram or description of components and data flow]
```

## 2. Component Breakdown

### 2.1 Backend Service
- Framework: [Express, FastAPI, etc.]
- Port: [default 3000]
- Responsibilities: [...]
- Endpoints: see API section

### 2.2 Frontend
- Type: [SPA, static HTML]
- Build: [none, webpack, etc.]
- Responsibilities: [...]

### 2.3 Database
- Type: [SQLite, PostgreSQL, etc.]
- Schema: [list tables and relationships]

## 3. API Design

| Method | Endpoint | Description | Request | Response |
|--------|----------|-------------|---------|----------|
| GET | /api/resource | List items | - | `[{...}]` |
| POST | /api/resource | Create | `{...}` | `{...}` |
| ... | ... | ... | ... | ... |

## 4. Security Considerations
- Input validation
- SQL injection prevention (parameterized queries)
- XSS protection (escaping)
- CORS policy
- Authentication/Authorization (if any)

## 5. Data Model

```sql
-- Include full schema statements
CREATE TABLE ...
```

## 6. Deployment Topology
- Local development: `npm start`
- Production: [Docker compose / systemd / other]
- Tunnel / reverse proxy: [Cloudflare Tunnel instructions]

## 7. Testing Strategy
- Unit tests: [...]
- Integration tests: [...]
- E2E tests: [...]

## 8. Future Extensibility
- Where to add new features
- Potential scalability improvements

## 9. Error Handling & Logging
- HTTP status codes used
- Error payload format
- Logging location and rotation

## 10. Environment Variables
| Name | Default | Description |
|------|---------|-------------|
| PORT | 3000 | Server port |
| DATABASE_PATH | ./data/db.sqlite | Database file location |
| ... | ... | ... |
