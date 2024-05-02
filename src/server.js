const { ApolloServer, gql } = require('apollo-server');
const { Pool } = require('pg');
require('dotenv').config();

// PostgreSQL pool
const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

// GraphQL schema definitions
const typeDefs = gql`
  type Query {
    companies: [Company]
    employees: [Employee]
    resources: [Resource]
    assignments: [Assignment]
    reservations: [Reservation]
  }

  type Company {
    CompanyId: ID!
    Name: String!
    Address: String
    ContactPerson: String
    employees: [Employee]
    resources: [Resource]
    assignments: [Assignment]
  }

  type Employee {
    EmployeeId: ID!
    CompanyId: Int!
    FirstName: String
    LastName: String
    Email: String
    Phone: String
    Role: String
    assignments: [Assignment]
    reservations: [Reservation]
  }

  type Resource {
    ResourceId: ID!
    CompanyId: Int!
    Identifier: String
    Type: String
    Capacity: Int
    assignments: [Assignment]
    reservations: [Reservation]
  }

  type Assignment {
    AssignmentId: ID!
    ResourceId: Int!
    EmployeeId: Int
    StartTime: String
    EndTime: String
    Status: String
    CompanyId: Int!
  }

  type Reservation {
    ReservationId: ID!
    ResourceId: Int!
    EmployeeId: Int
    CustomerId: Int
    StartTime: String
    EndTime: String
    Status: String
  }
`;


// Resolvers define how to fetch the types defined in the schema
const resolvers = {
    Query: {
        companies: async () => {
            const { rows } = await pool.query('SELECT * FROM Companies');
            return rows.map(company => ({
                CompanyId: company.companyid,
                Name: company.name,
                Address: company.address,
                ContactPerson: company.contactperson
            }));
        },
        employees: async () => {
            const { rows } = await pool.query('SELECT * FROM Employees');
            return rows.map(employee => ({
                EmployeeId: employee.employeeid,
                CompanyId: employee.companyid,
                FirstName: employee.firstname,
                LastName: employee.lastname,
                Email: employee.email,
                Phone: employee.phone,
                Role: employee.role
            }));
        },
        resources: async () => {
            const { rows } = await pool.query('SELECT * FROM Resources');
            return rows.map(resource => ({
                ResourceId: resource.resourceid,
                CompanyId: resource.companyid,
                Identifier: resource.identifier,
                Type: resource.type,
                Capacity: resource.capacity
            }));
        },
        assignments: async () => {
            const { rows } = await pool.query('SELECT * FROM Assignments');
            return rows.map(assignment => ({
                AssignmentId: assignment.assignmentid,
                ResourceId: assignment.resourceid,
                EmployeeId: assignment.employeeid,
                StartTime: assignment.starttime,
                EndTime: assignment.endtime,
                Status: assignment.status,
                CompanyId: assignment.companyid
            }));
        },
        reservations: async () => {
            const { rows } = await pool.query('SELECT * FROM Reservations');
            return rows.map(reservation => ({
                ReservationId: reservation.reservationid,
                ResourceId: reservation.resourceid,
                EmployeeId: reservation.employeeid,
                CustomerId: reservation.customerid,
                StartTime: reservation.starttime,
                EndTime: reservation.endtime,
                Status: reservation.status
            }));
        },
    },
    Company: {
        employees: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Employees WHERE CompanyId = $1', [parent.CompanyId]);
            return rows.map(employee => ({
                EmployeeId: employee.employeeid,
                CompanyId: employee.companyid,
                FirstName: employee.firstname,
                LastName: employee.lastname,
                Email: employee.email,
                Phone: employee.phone,
                Role: employee.role
            }));
        },
        resources: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Resources WHERE CompanyId = $1', [parent.CompanyId]);
            return rows.map(resource => ({
                ResourceId: resource.resourceid,
                CompanyId: resource.companyid,
                Identifier: resource.identifier,
                Type: resource.type,
                Capacity: resource.capacity
            }));
        },
        assignments: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Assignments WHERE CompanyId = $1', [parent.CompanyId]);
            return rows.map(assignment => ({
                AssignmentId: assignment.assignmentid,
                ResourceId: assignment.resourceid,
                EmployeeId: assignment.employeeid,
                StartTime: assignment.starttime,
                EndTime: assignment.endtime,
                Status: assignment.status,
                CompanyId: assignment.companyid
            }));
        },
    },
    Employee: {
        assignments: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Assignments WHERE EmployeeId = $1', [parent.EmployeeId]);
            return rows.map(assignment => ({
                AssignmentId: assignment.assignmentid,
                ResourceId: assignment.resourceid,
                EmployeeId: assignment.employeeid,
                StartTime: assignment.starttime,
                EndTime: assignment.endtime,
                Status: assignment.status,
                CompanyId: assignment.companyid
            }));
        },
        reservations: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Reservations WHERE EmployeeId = $1', [parent.EmployeeId]);
            return rows.map(reservation => ({
                ReservationId: reservation.reservationid,
                ResourceId: reservation.resourceid,
                EmployeeId: reservation.employeeid,
                CustomerId: reservation.customerid,
                StartTime: reservation.starttime,
                EndTime: reservation.endtime,
                Status: reservation.status
            }));
        },
    },
    Resource: {
        assignments: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Assignments WHERE ResourceId = $1', [parent.ResourceId]);
            return rows.map(assignment => ({
                AssignmentId: assignment.assignmentid,
                ResourceId: assignment.resourceid,
                EmployeeId: assignment.employeeid,
                StartTime: assignment.starttime,
                EndTime: assignment.endtime,
                Status: assignment.status,
                CompanyId: assignment.companyid
            }));
        },
        reservations: async (parent) => {
            const { rows } = await pool.query('SELECT * FROM Reservations WHERE ResourceId = $1', [parent.ResourceId]);
            return rows.map(reservation => ({
                ReservationId: reservation.reservationid,
                ResourceId: reservation.resourceid,
                EmployeeId: reservation.employeeid,
                CustomerId: reservation.customerid,
                StartTime: reservation.starttime,
                EndTime: reservation.endtime,
                Status: reservation.status
            }));
        },
    }
};

// Create and start the Apollo Server
const server = new ApolloServer({ typeDefs, resolvers });

// Start the server on a different port, e.g., 4001
server.listen({ port: 4001 }).then(({ url }) => {
    console.log(`🚀 Server ready at ${url}`);
});
