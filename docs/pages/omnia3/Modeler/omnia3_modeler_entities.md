---
title: Modeling Entities
keywords: omnia3
summary: "Modeling Entities"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_entities.html
folder: omnia3
---


## 1. Introduction

In _OMNIA Platform_ you can add your own entities, each one represeting one of the following concepts: __Agents, Commitments, Documents, Events, Generic entities, Resources or Series__.

In each entity, it's possible to define the attributes, the behaviours and the user interface,

## 2. Attributes
__*Entity / Attributes*__

The attributes allow you to define the structure of your entity. Each one will represent a property in the data you can read or write.

### How to add a new attribute?
Selecting the option _Add new_ you need to fill the following information:
* _Code_: the code of the attribute (needs to be unique inside the entity);
* _Description_: the textual explanation of the attribute's purpose (can be used as development documentation);
* _Type_: the attribute's data type (can be a _Primitive_ value or a _Reference_ to another entity);
* _Is required?_: indicates if the attribute is required or not (not applicable to _Commitments_ or _Events_);
* _Is read only?_: indicates if the attribute's value can be changed by the user's input (not applicable to _Commitments_ or _Events_);
* _Minimum number of records_: the minumum number of records to the collection (only applicable to _Commitments_ or _Events_);
* _Maximum number of records_: the maximum number of records to the collection (only applicable to _Commitments_ or _Events_);

### How to set an attribute as required?
In the attributes list, select the attribute you want to change and check the _Is required?_ property.

### How to set an attribute as read only?
In the attributes list, select the attribute you want to change and check the _Is read only?_ property.

### How to remove an attribute?
Picking the attribute you want to remove, select the option _Delete_ and confirm your option in the confirmation window.

## 3. Behaviours
__*Entity / Behaviours*__

In order to extend your application you can add new behaviours to your entities.

Click [here](omnia3_modeler_behaviours.html), to know more about behaviours.

### How to add a new behaviour?
Selecting the option _Add new_ you need to choose the behaviour's type you want to add. After that, you need to fill the following information:

* _Code_: the code of the behaviour (needs to be unique inside the entity);
* _Description_: the textual explanation of the behaviour (can be used as development documentation);
* _Attribute_: in a formula behaviour represents the calculated attribute and in an action behaviour the attribute which triggers the behaviour (the remaining behaviour types doesn't have this property);
* _Code_: the _C#_ code to execute;

### How to edit the execution code of a behaviour?
In the behaviours list, select the behaviour you want to change and, in the code editor, write the new code you want to execute.

### How to remove a behaviour?
Picking the behaviour you want to remove, select the option _Delete_ and confirm your option in the confirmation window.

## 4. User Interface
__*Entity / User Interface*__

In _OMNIA Platform_ you can customize how the fields are shown in the form to create or edit of your entity.

Automatically, the platform adds and removes user interface elements when a new attribute is added or an existing one is deleted from an entity.

The form layout is organized with _Rows_ and _Columns_. Each row is divided horizontally in 12 columns.

### How to add a new element?
Selecting the option _Add new element_ you will be able to add new elements to the layout, after filling the following information:

* _Attribute_: the entity attribute this element will represent in the layout (will allow you to read and write in this attribute);
* _Label_: the caption of the element;
* _Help text_: the detailed description of the element;
* _Row_: the layout row in which the element will be placed;
* _Column_: the layout column in which the element will be placed;
* _Size_: the size of the element on a scale of 1 (the smaller size) to 12 (the bigger size);

### How to change the positioning of an element?
In the User Interface tab, select the element you want to change and, in the _Row_ and/or _Column_ fields, set the new positioning values.

### How to change the size of an element?
In the User Interface tab, select the element you want to change and, in the _Size_ field, select the new size.

### How to remove an element?
Picking the element you want to remove, select the option _Delete_ and confirm your option in the confirmation window.

## 5. User Interface Behaviours
__*Entity / User Interface Behaviours*__

In order to extend your application user interface you can add new behaviours to your entities' user interface.

Click [here](omnia3_modeler_behaviours.html), to know more about user interface behaviours.

### How to hide an element?

In this sample, base element *_code* is set as hidden:

    ```JavaScript
    this._metadata.elements._code.isHidden = true;
    ```

### How to change the size of an element?

### How make an element read-only?

### How to set an element value?

