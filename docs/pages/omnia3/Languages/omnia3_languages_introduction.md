---
title: OMNIA 3.0 Languages Introduction and MEF
keywords: omnia3
summary: "OMNIA 3.0 Languages Introduction and MEF"
sidebar: omnia3_sidebar
permalink: omnia3_languages_introduction.html
folder: omnia3
---


## 1. Introduction

The OMNIA platform was designed based on the theoretical principles of language design and model-driven engineering, following similar principles to the Object Management Group's standard of [Meta-Object Facility (MOF)](http://www.omg.org/mof/) and its related languages such as the [Eclipse Modeling Framework (EMF)](http://www.eclipse.org/modeling/emf/) and the [Unified Modeling Language (UML)](http://www.uml.org/).

Here we explain what the different languages that exist in the platform are, as well as introducing our analogue to MOF, the **Meta-Entity Framework (MEF)**.

## 2. Meta-Entity Framework
MEF is the type system that all the languages on the platform use. If we were to identify the different layers of an OMNIA application, we could say that the **application** itself is layer 0 (M0), the **model** of that application is layer 1 (M1), and the languages of the platform (the meta-meta model) are layer 2 (M2). MEF is a layer above those languages, M3.

![Meta-modeling structure with examples](images/metamodeling.png)

An alternative way to describe MEF would be saying that it is a **Domain-Specific Language** used to define **metamodels** in OMNIA.

## 2.1. MEF Objects

This section describes extensively all of the objects of MEF.

### 2.1.1. Classifier

A **Classifier** is the base object type for all M3-level classes.

Property | Type | Cardinality | Description
---------|----------|---------|---------
 Name | Text | 1..1 | The name of the entity represented by this classifier.

### 2.1.2. Type

 A **Type** is a classifier that defines an object type. There are three different kinds of Type: Class, Enumeration and Primitive.

Property | Type | Cardinality |  Description
---------|----------|---------|---------
 Kind | Enumeration | 1..1 | The kind of this type: Class, Enumeration or Primitive.

### 2.1.3 Class
 
 The **Class** is the object type that is most frequent in the below layers. It defines a series of Properties and Operations, which can be understood as similar to Attributes and Methods in Object-Oriented Programming classes.

Property | Type | Cardinality |  Description
---------|----------|---------|---------
 InstanceOf | Text | 1..1 | The kind of this type: Class, Enumeration or Primitive.
 Properties | Property | 1..* | The list of all the properties of this class.
 Operations | Operation | 1..* | The list of all the operations of this class.

### 2.1.4. Enumeration

 The **Enumeration** is the object type that represents a fixed list of possible values.

Property | Type | Cardinality |  Description
---------|----------|---------|---------
 Values | Text | 1..N | List of all the possible values for the enumeration.
 


