---
title: OMNIA API Client Tutorial
keywords: omnia3
summary: "OMNIA Platform 3.0 api clients management"
sidebar: omnia3_sidebar
permalink: omnia3_apiclienttutorial.html
folder: omnia3
---

## 1. Introduction

Based on a simple Order Management sample application, this tutorial shows how easily Omnia models can be used through API, by external applications.


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and have completed the beginner tutorial. You must also have access to a user with privileges to Modeling and Management areas

If you do not have a tenant yet, please follow the steps of the [Tenant Creation tutorial](http://docs.numbersbelieve.com/omnia3_tenantcreation.html). If you have a tenant, but have not completed the beginner tutorial, follow the steps on [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html)


## 3. Define an API Client

1. Start by logging in with a user that has access to the manage area, and on left side menu, select option  "Go to > Management". You will be redirected to the Management area

    ![Homepage_Dashboard](http://funkyimg.com/i/2DVGv.png)

2. Through the left side menu, create a new API Client by accessing the option ***API Clients / Create new*** on the top right side. Set its Name as "Tutorial API Client"

    ![Modeler_Create_DataSource](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Create-DataSource.PNG)
    
3. After creating, select the new API Client on the list, and check that you have now access to a Client Id and Secret to consume Omnia API. Copy the Client Email to the clipboard

    ![Modeler_Create_DataSource](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Agent-Employee.PNG)

4. Now its time to define the access privileges for the API Client. Through the left side menu, access option "Security > Roles". Locate the tenant Administration role (its name is a concatenation of "Administration" and the tenant code).

5. Edit the role, and on tab "Users", click on button "Add new". Paste the Client Email copied on step 3 and click on Save

## 3. Consume Omnia API 
