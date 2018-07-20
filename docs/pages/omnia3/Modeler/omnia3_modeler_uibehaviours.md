---
title: User Interface Behaviours
keywords: omnia3
summary: "User Interface Behaviours"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_uibehaviours.html
folder: omnia3
---

## 1. Introduction

In the **OMNIA Platform**, the primary way to customize the way the application works is by using Behaviours. 

Behaviours are code that allow you to **extend** the way the application processes user input.

User interface-specific behaviours, written in JavaScript, allow you to customize the way the web application of the platform works. This means extending the way a modeled Form behaves - hiding fields, making them read-only, increasing their size, etc.

The API-side behaviours are described on [this page](omnia3_modeler_behaviours.html).

 A behaviour is defined by (see [UIML](omnia3_languages_uiml.html) for detailed definition):
- its **type**, or the moment in which it will execute;
- (optionally) its **element**, or which element of the form it is dependent on;
- its **expression**, the aforementioned JavaScript code.

UI Behaviours are executed by the web app - when creating or editing an entity, it will execute the appropriate behaviours at the times defined.

## 2. Types of Behaviours

There are currently three different execution moments for UI behaviours, which follow a logical flow:
- **Initialize**: Executes when entering the form;
- **On Change**: Executes during updates, requires an attribute, and, given the new value of that attribute, performs an operation. Similar role to **Action** in the other behaviours;
- **Before Save**: Executes when an entity is saved.

![The behaviour execution lifecycle](images\modeler\UIBehaviourLifecycle.png)

## 3. Usage

There are many possible usage scenarios for these behaviours, as JavaScript coding will allow you to execute whatever you want. Usage examples are described in our [FAQ](omnia3_modeler_uibehaviours_faq.html).

## 4. Structure of the class

TODO

## 5. Developing and testing UI behaviours

In terms of development, all behaviours defined for a given form will execute based on a JavaScript class. 

To download these classes, access ***Versioning > Builds***, and, next to the latest build of the model, you will see a download button. Press it. This ZIP will contain a series of folders - for what we are interested here, the **uiClasses** folder will contain the JavaScript class for each of the forms that exist in the model.

These classes come with all the execution moments' methods already created so it's easier to see what they will look like. In the browser, the final class will look slightly different, as it is **transpiled** for compatibility.

In order to debug the behaviours in the platform, you can use your browser's debugger - for example, using Chrome and opening the Developer Console, you will see the class for entity employee as **EmployeeForm!transpiled** in the _(no domain)_ area. An example is shown in the image below.

![Debugging behaviours for an entity in chrome](images\modeler\UIBehaviourDebugging.png)

Inside this transpiled source code, you can use breakpoints and console logs in order to debug the code you need to write.