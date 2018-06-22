---
title: OMNIA 3.0 Connector Introduction
keywords: omnia3
summary: "OMNIA 3.0 Connector Introduction"
sidebar: omnia3_sidebar
permalink: omnia3_connector_introduction.html
folder: omnia3
---


## 1. Introduction

The **OMNIA Connector** is the software that the OMNIA Platform uses to communicate with the customer's servers in order to execute external behaviours. 

## 2. How it works
TODO

## 3. Requirements

* Internet access
* .NET Framework 4.7.2
* Windows

## 4. Connectivity
Once the connector is running, the connection between it and the server will be kept active without the user having to do anything special. 

However, there are scenarios where it is necessary to perform manual maintenance on the installation, namely, when disconnections occur.

### 4.1. Start policy
If the connector cannot establish a connection when launching, it will retry that connection for up to one minute before crashing. 

### 4.2. Disconnection retry policy
If the connector is running and a disconnection is detected, it will begin a process of **exponential backoff**. 

This means that the connector will keep attempting to re-establish the connection, with more and more space between attempts. 

If after **22 attempts** (approximately 2 hours and 20 minutes total), we assume there is a _permanent_ issue with the connection and will stop trying to reconnect. 

This will lead to manual intervention being necessary.