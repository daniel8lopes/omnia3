---
title: Behaviours
keywords: omnia3
summary: "Behaviours"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_behaviours.html
folder: omnia3
---


## 1. Introduction

In the **OMNIA Platform**, the primary way to customize the way the application works is by using Behaviours. 

Behaviours are code, written in C#, that allow you to **extend** the way the application processes user input. A behaviour is defined by (see [BML](omnia3_languages_bml.html) for detailed definition):
- its **type**, or the moment in which it will execute;
- (optionally) its **attribute**, or which attribute of the model it is dependent on;
- its **expression**, the aforementioned C# code.

Behaviours are executed by the API of the platform - creating, updating or saving an entity will execute the appropriate behaviours.

![The behaviours' execution path](images\modeler\BehavioursCommunication.png)

During the behaviour lifecycle, the platform stores the current state of the document in a cache, allowing for fast response times.

## 2. Types of Behaviours

There are currently five different execution moments for behaviours, which follow a logical flow:
- **Initialize**: Executes when an entity is created;
- **Before Change**: Executes immediately before an update is received for that entity;
- **Formula**: Executes during updates, requires an attribute, and **calculates** the value of that attribute;
- **Action**: Executes during updates, requires an attribute, and, given the new and old values of that attribute, performs an operation;
- **After Change**: Executes immediately after the update with the user's changes is done;
- **Before Save**: Executes when an entity is saved.

![The behaviour execution lifecycle](images\modeler\BehaviourLifecycle.png)

## 3. Usage

There are many possible usage scenarios for these behaviours, as C# coding will allow you to execute whatever you want. This section gives some guiding examples.

### 3.1. Usage of the behaviours in the platform languages

Internally, in the development of the platform, these behaviours are used with the same structure. For example, when you create an Agent, you will see that, even though you didn't specify any attributes, a set of default attributes are present. This creation is handled by an **Initialize** behaviour. They also can't be deleted; this is ensured by having a **Before Save** behaviour that ensures that an exception is thrown if the user attempts to remove any _system_ attribute.

A similar **Initialize** logic is used to ensure default values in documents: for example, the initial date is set to today's date instead of 01/01/0001, the C# default for that date.

### 3.2. Usage Scenarios

Following from the scenarios described in 3.1., you may have realized some possible scenarios that behaviours can help in. Our [tutorials](omnia3_beginnertutorial.html) also have a series of different examples. 

Here are some usage suggestions for each type of behaviour - though, of course, the only limit is your imagination!

- **Initialize**: 
    - Default values for fields;
- **Before Change**: 
    - Performing operations that depend on the previous state of the document; 
- **Formula**: 
    - Summary/total fields;
    - Auxiliary fields (i.e. displaying an amount of days based on two dates);
- **Action**: 
    - Looking up data from an external API;
    - Changing information in the lines of a grid based on a change in the header;
    - Performing validations on an attribute;
- **After Change**: 
    - Performing calculations that require information from commitments/events in the header;
    - Performing document-wide validations;
    - Calculating summary lines;
- **Before Save**:
    - Performing final document-wide validations;
    - Integrating with external APIs;
