---
title: OMNIA 3.0 Connector Configuration
keywords: omnia3
summary: "OMNIA 3.0 Connector Configuration"
sidebar: omnia3_sidebar
permalink: omnia3_connector_configuration.html
folder: omnia3
---

## 1. Configuring the connector on the platform
In Management area it's possible to manage the available Connectors to the subscription.

In order to use the connector, you will first need to register it on the platform. [See here how to do it](omnia3_management_introduction.html#5-connectors).

## 2. Configuring the connector in your application

To communicate with a connector it's neccessary to work with a custom **Data Source** ([see here how to do it](omnia3_modeler_datasources.html)).

### 2.1. How to configure the model
If the Data Source is created with *Data Access runtime* or *Behaviour runtime* properties setted as *External*, will be possible to execute operations in a connector.

To allow that, an attribute with name **_connector** is automatically added to the Data Source.

### 2.2. How to configure the application data
Before execute operations in the connector is required to configure to which connector the requests will be made.

Accessing the application, in the menu, select the Data Source you previously created and **Add new** record.

Fill the form with the required information and in the **Connector** field write in the code of the Connector you want to commicate to.

From now on, the communication of the entities configurated to use this Data Source will send the requests to the configured Connector.