# GraphQL Example with PostgreSQL, Apollo Server, and Docker


## Using GraphQL vs REST API

## Introduction to GraphQL
GraphQL is a query language for your API, and a server-side runtime for executing queries by using a type system you define for your data. Unlike REST, which uses multiple endpoints to fetch data, GraphQL uses a single endpoint and provides the flexibility to query exactly the data you need. This project demonstrates how GraphQL can be used to integrate with a PostgreSQL database and allows complex querying capabilities with less overhead and greater performance than traditional REST APIs.

## Benefits of GraphQL
Single Request for Multiple Resources: In traditional REST APIs, fetching related resources often requires multiple calls to various endpoints. GraphQL allows clients to request exactly the data they need in a single query. This is especially useful for complex systems with interconnected data, like the example provided where company data along with nested employee, resource, and assignment details can be fetched in a single request.
Fetch Exactly What You Need: Clients have the control to specify exactly what data they need, down to specific fields on objects. This minimizes the amount of data transferred over the network and can lead to performance improvements in applications.

Strongly Typed: The GraphQL schema acts as a contract between the server and client, specifying exactly what queries are valid. This type enforcement ensures that only feasible queries are executed, reducing errors and improving the development workflow.

Easier to Aggregate Data from Multiple Sources: GraphQL can be used to aggregate data from multiple sources (like different databases or APIs) into a single API that clients can interact with.

Real-Time Data with Subscriptions: Unlike REST, GraphQL can handle real-time data out-of-the-box with subscriptions. This allows clients to listen to real-time changes to data that they care about.

## Example Query
This project includes an example where a single GraphQL query can fetch detailed company information along with related data from employees, resources, and assignments. Here's an example query you might run using Apollo Server's built-in tool, Apollo Playground:

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
## Setup and Running the Project
To run this project, follow these steps:

Clone the repository.

Navigate to the root directory of the project.

Run docker-compose up to build and start the PostgreSQL database, pgAdmin, and the GraphQL server containers.

Once the containers are running, open Apollo Playground at http://localhost:4001 to start executing queries.

Optionally, open the index.html file in a web browser to see a graphical representation of querying a GraphQL API from a webpage.

## Conclusion
Using GraphQL, this project simplifies the process of querying complex, related data through a flexible, efficient, and powerful single-endpoint API. This makes it an ideal choice for modern web applications that require fine-grained control over their data requirements.