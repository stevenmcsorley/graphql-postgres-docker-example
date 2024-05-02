# GraphQL Example with PostgreSQL, Apollo Server, and Docker

This is a simple example project demonstrating how to set up a GraphQL server using Apollo Server, PostgreSQL as the database, and Docker for containerization.

## Prerequisites

- Docker installed on your machine ([Get Docker](https://www.docker.com/get-started))

## Getting Started

Clone this repository to your local machine:

```bash
git clone <repository_url>
```

Start the Docker containers using Docker Compose:

docker-compose up


Once the containers are up and running, you can access the GraphQL Playground at http://localhost:4001 to run GraphQL queries.
Example Query

```bash
query {
  companies {
    CompanyId
    Name
    Address
    ContactPerson
    employees {
      EmployeeId
      FirstName
      LastName
      Role
    }
    resources {
      ResourceId
      Identifier
      Type
      Capacity
      assignments {
        AssignmentId
        StartTime
        EndTime
        Status
      }
    }
  }
}
```

Viewing Data in index.html as an example of fetchingthe data
You can view queried data in an HTML page by opening index.html in a web browser.