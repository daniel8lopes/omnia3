---
title: Model Lifecycle
keywords: omnia3
summary: "Model Lifecycle"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_lifecycle.html
folder: omnia3
---

## 1. Introduction
The _OMNIA Platform_ was designed around a development lifecycle with the following steps:
* Model: create the model definitions;
* Build: compile the model; 
* Test: create records using the previously created model;

Each operation is recorded, creating this way a full log of everything was made in the platform.

On top of this lifecycle, there is also a multi-environment logic, where you can promote changes between different environments of the same tenant.
![Modeler Lifecycle](images\modeler\EnvironmentLifecycle.png)

## 2. History tracking
__*Versioning / History*__

Accessing to the platform's log it's possible to see all the operations made in the model.

Each record contains the description, the date and who realized the operation.

This way it's possible to all modelers to know who made what and track all the model's changes.

## 3. Build the model
__*Versioning / Builds*__

After every change in the model it is necessary to create a new build, in order to the apply the changes and, that way, the end-users can use the application in its last state.

When you create a new build, all the _C#_ code added in the behaviours will be compiled. If any error occurs during the code compilation the build will fail and all the model changes will be maintained as pending.


### How to create a new build?
In the _Builds_ page, selecting the option _Create new_ and confirm your intent in the confirmation window.

## 4. Download the behaviours code
__*Versioning / Builds*__

If you want to download the behaviours code the way it will be executed in the _OMNIA Platform_ (either to test it or to correct some problem), you can do it in the _Builds_ list choosing the option _Download build_ to the build version you want to get.