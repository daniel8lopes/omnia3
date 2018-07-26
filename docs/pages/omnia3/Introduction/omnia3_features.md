---
title: Features
keywords: omnia3
summary: "OMNIA 3 Features"
sidebar: omnia3_sidebar
permalink: omnia3_features.html
folder: omnia3
---

List of features available on OMNIA Platform 3.0:

## Modeler

### Entities

- Model entities of the following types:

    - Agents
    - Resources
    - Generic Entities
    - Commitments
    - Events
    - Documents
    - Series
    - Data Sources

- Define entity datasource
- Manage Attributes
- Manage Behaviours
- Review User Interface

### Attributes

- Supported attribute types:
    
    - Reference to other entities
    - Boolean
    - Date
    - Decimal
    - Integer
    - Text
    - Uuid (Universally unique identifier)
    
### Behaviours

It is possible to manage the following types of behaviours:

- (C#) Application
    Behaviours that can be used multiple times through the model
- (C#) Entity
    Behaviours associated to the entity that can manipulate its data
- (C#) Entity Data
    Behaviours that assure entity CRUD when it it based on a non-System Datasource
- (JavaScript) User Interface Behaviours
    Behaviours that allow the user to extend the user interface, by:
        - Conditionally hiding elements
        - Conditionally disabling elements (read-only)
        - Change the size and position
        - Set element values
        - Show custom messages to the end user

### Data Analytics

- Manage Queries
- Generate Lists from Queries
- Manage Lists
- Manage Dashboards

## Management

- Manage tenants
- Manage Api Clients
- Manage Connectors
- Manage Security: Roles, Policies and users

## Application

- Work on multiple tenants
- Manage tenant security: Roles, Policies and Users
- Create, Read, Update and Delete instances of the model entities

## Connector

- Installed and managed as a Windows service
- Execute modeled behaviours




