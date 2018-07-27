---
title: Developing and Testing Behaviours
keywords: omnia3
summary: "How to develop and test Behaviours with the help of Visual Studio"
sidebar: omnia3_sidebar
permalink: omnia3_modeler_developingbehaviours.html
folder: omnia3
---


## 1. Introduction
When developing behaviours in the OMNIA platform, writing C# with no context directly into the modeling area is not going to be enough for any other than the simplest scenarios. However, it is possible to download the exact C# classes that the platform will use for its execution of the behaviours, and both develop code and test it in Visual Studio.

## 2. Downloading the auxiliary solution

In order to simplify the debugging explained in this section, we have created a [Visual Studio 2017 solution](https://github.com/numbersbelieve/omnia3-behaviours) that contains a pre-baked example of how to test a sample Purchase Order model such as the one described in the [Beginners Tutorial](omnia3_beginnertutorial.html).

If you want to develop your own VS Solution, you will need to manually add a series of NuGet package references.

## 3. Obtaining the model

- Access the modeling area for the tenant and environment you want to develop in.
- Access ***Versioning > Builds***, and, next to the latest build of the model, you will see a download button. Press it.
- That zip file contains the current state of the model. You can extract it to the sample solution from point 2. or develop your own Visual Studio solution for testing.

## 4. Structure of the downloaded behaviours

Upon extracting the zip file, you will see a series of folders. 

- **_common** contains the system classes that are always necessary for other behaviours (Context, ApiClient), as well as the _[EntityName]Dto.cs_ Data Transfer Objects (DTOs) that are used to pass data between the platform and the place where behaviours are executed (whether inside the platform or in the connector).

- **System** contains the structural code for any entities that do not have a custom Data Source.
    - The **Entity** folder contains all the _[EntityName].Operations.cs_ classes that are where your custom behaviours will be. **This will be the only place you need to edit when testing entity behaviours**.
    - The **Entity/Domain** folder contains the Domain representations of the entities, _[EntityName].cs_. 
    - The **Application** folder, if it exists, contains all the **Application** behaviours, one per file.

If there are any custom data sources, you will also see other folders:

- **[DataSourceCode]** folders contain, for each data source other than System, the classes for every entity that is associated with that Data Source.
    - The Entity folder is the same as above, so is the Application folder.
    - If there are any Data behaviours (i.e. the **Data Access** runtime of this entity is External), there will also be a **Data** folder, which contains the Data Access Object (DAO) classes _[EntityName]Dao.cs_, where all the Data Behaviours exist. **This will be the only place you need to edit when testing data behaviours**.

This folder division is what allows for the connector to only compile what it needs to run the external data sources, as well as for the platform to only compile what it needs to run its internal data sources.