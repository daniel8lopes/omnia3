---
title: References in Behaviours
keywords: omnia3
summary: "How to reference .NET assemblies"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_references.html
folder: omnia3
---


## 1. Introduction

The platform's behaviours allow you to use write C# code to handle a series of scenarios (see [data](omnia3_modeler_datasources.html) and [entity](omnia3_modeler_behaviours.html) behaviours explained).

One of the most important things about working in C# is the ability to use references, whether via NuGet or just by referencing the DLLs. In OMNIA, if you want to utilize those references, you can, by adding **references** to your entities.

## 2. Adding references

There are two different kinds of references you can add to your model:
- **Entity references**: Associated with Entity behaviours. 
- **Data references**: Associated with Data behaviours. 

Whatever the type, the place they execute on depends on the associated data source's settings.

In order to add them, you can access the modeler, edit an entity, and go to ***Entity references > Add new*** or ***Data references > Add new***. Here, you identify the reference you want:
- **Name:** A platform-side identifier for the reference;
- **Description:** A human-readable description for the reference;
- **Path:** The path to that reference. If it's a System.* reference, you can leave it without a full path; any other references will require a valid absolute path for the system they will execute on.
- **Namespace:** The namespace used by the reference you are importing. Will be automatically added to all code for your convenience; i.e. importing ```ExampleCompany.SqlQuerier``` will allow you to use ```new ExampleQueryBuilder()``` instead of ```new ExampleCompany.SqlQuerier.ExampleQueryBuilder```, i.e, without having to fully qualify the name.

## 3. Supported references

As the platform uses .NET Core, all references that run on an Internal data source will have to be compiled against one of the following:
- **.NET Core 1.0 - 2.1**
- **.NET Standard 1.0 - 2.0**

This is the only way we can guarantee compatibility. The most recent version of either is recommended, if you're developing a library yourself.