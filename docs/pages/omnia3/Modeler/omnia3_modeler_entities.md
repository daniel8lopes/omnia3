---
title: Modeling Entities
keywords: omnia3
summary: "Modeling Entities"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_entities.html
folder: omnia3
---


## 1. Introduction

In _OMNIA Platform_ you can add your own entities, each one represeting one of the following concepts: __Agents, Resources, Commitments, Events, Documents or Generic entities__.

In each entity, it's possible to define the attributes, the behaviours and the user interface,

## 2. Attributes
__*Entity / Attributes*__

The attributes allow you to define the structure of your entity. Each one will represent a property in the data you can read or write.

### How to add a new attribute?


### How to edit an attribute?

### How to remove an attribute?
Picking the attribute you want to remove, select the option _Delete_ and confirm your option in the confirmation window.

## 3. Behaviours
__*Entity / Behaviours*__

In order to extend your application you can add new behaviours to your entities.

Click [here](omnia3_modeler_behaviours.html), to know more about behaviours.

### How to add a new behaviour?
Selecting the option _Add new_ you need to choose the behaviour's type you want to add. After that, you need to fill the following information:

* Code: the code of the behaviour (needs to be unique inside the entity);
* Description: the textual explanation of the behaviour (can be used as development documentation);
* Attribute: in a formula behaviour represents the calculated attribute and in an action behaviour the attribute which triggers the behaviour (the remaining behaviour types doesn't have this property);
* Code: the _C#_ code to execute;

### How to edit a behaviour?
Picking the element you want to edit you can change only the description and the C# execution code.

### How to remove a behaviour?
Picking the behaviour you want to remove, select the option _Delete_ and confirm your option in the confirmation window.

## 4. User Interface
__*Entity / User Interface*__

In _OMNIA Platform_ you can customize how the fields are shown in the form to create or edit of your entity.

Automatically, the platform adds and removes user interface elements when a new attribute is added or an existing one is deleted from an entity.

The form layout is organized with _Rows_ and _Columns_. Each row is divided horizontally in 12 columns.

### How to add a new element?
Selecting the option _Add new element_ you will be able to add new elements to the layout, after filling the following information:

* Attribute: the entity attribute this element will represent in the layout (will allow you to read and write in this attribute);
* Label: the caption of the element;
* Help text: the detailed description of the element;
* Row: the layout row in which the element will be placed;
* Column: the layout column in which the element will be placed;
* Size: the size of the element on a scale of 1 (the smaller size) to 12 (the bigger size);

### How to edit an element?
Picking the element you want to edit you can change all the configuration of the element, with  the exception of changing the corresponding attribute.

### How to remove an element?
Picking the element you want to remove, select the option _Delete_ and confirm your option in the confirmation window.