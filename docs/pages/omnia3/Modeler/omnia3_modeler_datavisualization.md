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
* _Name_: The name of the query (needs to be unique);
* _Description_: The textual explanation of the query's purpose (can be used as development documentation);
* _Type_: The type of the entity this query targets;

### How to add properties to a query?
Selecting the option _Add new_ when editing a query, you need to fill the following information:
* _Alias_: The Alias of the property, i.e. the name you want to see it show up with;
* _Path_: The Path to that property. If the attribute belongs to the entity, it can be selected. Else:
    - If you want to get properties from a collection inside the entity, use '>', i.e. ```OrderLines>_amount```;
    - If you want to get properties from a reference inside the entity, use '.', i.e. ```VATSummary._amount```;

### How to add joins to a query?
Joins, like in SQL, allow us to obtain information from more than one entity. 

To add a join, edit a query, go to the **Joins** separator, and press _Add new_. You will need to fill the following information:
* _Join with_: The modeled type of the entity to perform the Join with;
* _Will not join with initial definition?_: Whether or not set A of the join is the entity targeted by the query;
* _Type_: only visible if not joining with initial definition. The modeled type to target;
* _Join type_: Uses the same concept as SQL's joins:
    - _Inner_: All records that meet the join condition;
    - _Left (Left Outer)_: All records from set A, along with the records from set B that meet the join condition;
    - _Right (Right Outer)_: All records from the set B, along with the records from set A that meet the join condition;
    - _Full (Full Outer)_: All records from both sets;
    - _Cross_: multiplies the entries of set A by set B;
* _Expression_:
    - _Inner path_: Condition of the join for the inner path;
    - _Outer path_: Condition of the join for the outer path;

### How to create an advanced query?
The platform allows you to write your own query using SQL.

To do that, edit a query and, in **More options**, select **Show advanced editor** and you will see a textbox to write in your SQL statement.

_**Naming conventions**_

Each entity you add to the model have a SQL view to allow you to easily access the data. Also, each attribute whose *Maximum number of records* is more than 1, will have a different SQL view.

So, the name of the SQL views respects the following rules:
* SQL views of entities: **vw_MyEntityName**
* SQL views of attributes with *Maximum number of records* > 1: **vw_MyEntityName_MyAttributeName**

Each SQL view will be composed with as many columns as attributes of the entity. The column name is the same as the attribute name.

_**Examples**_

*Get the records from an entity*
```SQL
    SELECT document._code, document._date, document.Customer FROM vw_MyDocument document
```

*Get the records from a collection attribute*
```SQL
    SELECT document._code, lines._resource, lines._amount 
    FROM vw_MyDocument document
    JOIN vw_MyDocument_Lines lines on lines.identifier = document.identifier
```

*Get a sum of the value of an attribute*
```SQL
    SELECT document._code, lines._resource, SUM(lines._amount) as total 
    FROM vw_MyDocument document
    JOIN vw_MyDocument_Lines lines on lines.identifier = document.identifier
    GROUP BY document._code, lines._resource
```

## 3. Lists
__*Data Analytics / Lists*__

In order to use the queries, we will need a place to show them. **Lists** are one of those places.

A list is little more than a way to see a query displayed in the web app: you select a query, (part or all of) its columns, and how to display those columns.

A list is automatically generated when a new entity is created. It is based on the automatically generated query.

### How to create a list?

A list can be created automatically, based on a query, or manually.

To automatically create a new list based on a query, you must edit the query, and on top right *More Options* button, click on *Generate List*. A list will be automatically generated and can be edited later.

To create a list manually, select the option _Add new_ when in the list of Lists, and fill in the following information:
* _Name_: the name of the list (needs to be unique);
* _Description_: the textual explanation of the list's purpose (can be used as development documentation);
* _Query_: select a previously created query to use;
* _Label_: what label should be displayed for the list;
* _Help Text_: Auxiliary texts that explain the list's purpose to the users.

### How to edit the columns in a list?

When the list is created manually, after its creation it will be empty, and you must select which columns from the query you want to show.

By editing a list in the menu, and selecting the option _Add new_, you can add the following information:
* _Query property_: The property of the query this column will represent;
* _Label_: What the label of the column will say;
* _Help Text_: Auxiliary text that explains this column to users;
* _Format as_: Which formatting strategy should this column have. Similar to spreadsheet applications, i.e. a result of "5" can be shown normally, or formatted as a decimal.

## 4. Dashboards
__*Data Analytics / Dashboards*__

A dashboard is a collection of lists organized in a particular order.

When a new entity is created, a dashboard is automatically generated. This dashboard is shown when user lists the entities, and contains only one element, the automatically generated list.

### How to create a dashboard?

Select the option _Add new_ when in the list of Dashboards, and fill in the following information:
* _Name_: the name of the dashboard (needs to be unique);
* _Description_: the textual explanation of the dashboard's purpose (can be used as development documentation);
* _Label_: what label should be displayed for the dashboard;
* _Help Text_: Auxiliary texts that explain the dashboard's purpose to the users.

**Special case:** A dashboard with a code of **Home** will be automatically displayed in the homepage of the application.

### How to edit elements in a dashboard?

Select the option _Add new_ when editing a dashboard, and fill in the following information:
* _Name_: the name of the element (needs to be unique);
* _Description_: the textual explanation of the element's purpose (can be used as development documentation);
* _List_: which list should be displayed in this dashboard element;
* _Label_: what label should be displayed for the element;
* _Help Text_: Auxiliary texts that explain the element's purpose to the users.
* _Row_: the layout row in which the element will be placed;
* _Column_: the layout column in which the element will be placed;
* _Size_: the size of the element on a scale of 1 (the smaller size) to 12 (the bigger size);

