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

When creating a **Data Source**, if it has the configuration for having a connector associated, it will have a **_connector** attribute, where you can input the Code we defined here, so that we know to use that connector when accessing entities of that Data Source.

## 2. Using the connector

Once the connector is running, the connection between it and the server will be kept active without the user having to do anything special. However, there are scenarios where it is necessary to perform manual maintenance on the installation, namely, when disconnections occur.

If the connector cannot establish a connection when launching, it will retry that connection for up to one minute before crashing. 

If it is already running, the process is more complex: when a disconnection is detected, we begin a process of **exponential backoff**; i.e. we keep attempting to re-establish the connection, with more and more space between attempts. This process will eventually end, however - after **22 attempts** (approximately 2 hours and 20 minutes total), we assume there is a _permanent_ issue with the connection and will stop trying to reconnect. This will lead to manual intervention being necessary.