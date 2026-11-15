# ShopSphere Technologies
## MIT 8103 — Advanced Database Systems

### Case Study
A simulated Nigerian multi-vendor e-commerce platform.

### Technologies
- PostgreSQL 16
- MongoDB 7
- Redis 7
- Docker Compose

### Project Portfolios

| Portfolio | Description |
|---|---|
| P1 | Relational database design and normalisation |
| P2 | SQL queries and query optimisation |
| P3 | Transactions and concurrency control |
| P4 | MongoDB and Redis implementation |
| P5 | Distributed databases and cloud architecture |

### Database Architecture

PostgreSQL is the primary transactional database.

MongoDB stores flexible product catalogue documents.

Redis provides temporary shopping cart and caching
functionality.

Docker Compose runs the database services locally.

### How to Run

Start the database containers:

```bash
docker compose up -d