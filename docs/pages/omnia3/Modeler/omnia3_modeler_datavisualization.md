---
title: Data Visualization
keywords: omnia3
summary: "Data Visualization"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_datavisualization.html
folder: omnia3
---


## 1. Introduction

The platform provides a series of options to help perform analysis on the information produced by the users.

These tools allow for modelers to determine how users are going to be able to see and interact with their data.

There are three different modelable entities that will be used for this purpose, **Queries**, **Lists**, and **Dashboards**.

## 2. Queries
__*Data Analytics / Queries*__
A **query**, in OMNIA, represents a way to define a series of properties whose values you want to obtain, from an entity or a series of entities. If you have ever worked with a query-based languages such as SQL, you will be familiar with this concept - in fact, the queries we model in OMNIA are later turned into SQL, in the [build](omnia3_modeler_lifecycle) process.

A query is automatically created when an entity is created. This automatic query will obtain a series of system attributes, by default. 

### How to create a new query?
Selecting the option _Add new_ in the list of queries, you need to fill the following information:
* _Code_: the code of the query (needs to be unique);
* _Description_: the textual explanation of the query's purpose (can be used as development documentation);
* _Type_: the type of the entity this query targets;

### How to add properties to a query?
Selecting the option _Add new_ when editing a query, you need to fill the following information:
* _Alias_: The Alias of the property, i.e. the name you want to see it show up with;
* _Path_: The Path to that property. This has its own syntax:
    - If you want to get properties from a collection inside the entity, use '>', i.e. ```OrderLines>_amount```;
    - If you want to get properties from a reference inside the entity, use '.', i.e. ```VATSummary._amount```;

### How to add joins to a query?
Joins, like in SQL, allow us to obtain information from more than one entity. 

To add a join, edit a query, go to the **Joins** separator, and press _Add new_. You will need to fill the following information:
* _Join with_: The type of the entity to perform the Join with (i.e. ;
* _Will not join with initial definition?_: Whether or not set A of the join is the entity targeted by the query;
* _Join type_: Uses the same concept as SQL's joins:
    - _Inner_: All records that meet the join condition;
    - _Left (Left Outer)_: All records from set A, along with the records from set B that meet the join condition;
    - _Right (Right Outer)_: All records from the set B, along with the records from set A that meet the join condition;
    - _Full (Full Outer)_: All records from both sets;
    - _Cross_: multiplies the entries of set A by set B;
* _Expression_:
    - _Inner path_: Condition of the join for the inner path;
    - _Outer path_: Condition of the join for the outer path;

