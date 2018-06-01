---
title: OMNIA API Client Tutorial
keywords: omnia3
summary: "OMNIA Platform 3.0 api clients management"
sidebar: omnia3_sidebar
permalink: omnia3_apiclienttutorial.html
folder: omnia3
---

## 1. Introduction

Based on a simple Order Management sample application, this tutorial shows how easily Omnia Platform models can be used through API, by external applications.

On the first tutorial area (Define an API Client), we are going to evaluate how an API client is defined on Omnia Platform, and how it is configured on Omnia's security system. On the second area (Consume Omnia API), we are going to see a simple example of how Omnia API can be consumed.

As a tool to consume Omnia API, we are going to use [Postman](https://www.getpostman.com/), a tool that simplifies interaction with APIs. It is worth noting that the API could be consumed as easily with other tools or your own developments.




## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and have completed the beginner tutorial. You must also have access to a user with privileges to Modeling and Management areas

If you do not have a tenant yet, please follow the steps of the [Tenant Creation tutorial](http://docs.numbersbelieve.com/omnia3_tenantcreation.html). If you have a tenant, but have not completed the beginner tutorial, follow the steps on [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html)


## 3. Define an API Client

1. Start by logging in with a user that has access to the manage area, and on left side menu, select option  "Go to > Management". You will be redirected to the Management area

    ![Management_Homepage](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Manage-Homepage.PNG)

2. Through the left side menu, create a new API Client by accessing the option ***API Clients / Create new*** on the top right side. Set its Name as "Tutorial API Client"

    ![Management_Create_APIClient](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Manage-Create-APIClient.PNG)
    
3. After creating, select the new API Client on the list, and check that you have now access to a Client Id and Secret to consume Omnia API. Copy the Client Email to the clipboard

    ![Management_Edit_ApiClient](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Manage-Edit-APIClient.PNG)

4. Now its time to define the access privileges for the API Client. Through the left side menu, access option "Security > Roles". Locate the tenant Administration role (its name is a concatenation of "Administration" and the tenant code).

5. Edit the role, and on tab "Users", click on button "Add new". Paste the Client Email copied on step 3 and click on Save

## 4. Consume Omnia API 

1. To consume Omnia API, open previously installed Postman application

3. We are going to start with a POST request, to create a new Company. Set the request type as "POST" and the request url as the base url used to access Omnia, adding "api/v1/[TenantCode]/prd/Application/Company/default" at the end (replace [TenantCode] with your actual tenant code).

2. Before creating a request to Omnia API, configure OAuth 2.0 as the authentication type to be used on requests, and fill the required parameters, as in the following image

    ![Postman_Configure_AccessToken](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Postman-Configure-AccessToken.PNG)

    * Grant Type: Set as "Client Credentials"
    * Access token URL: The base url used to access Omnia, adding "/identity/connect/token" at the end
    * Client ID: client ID generated previously
    * Client Secret: secret generated previously
    * Scope: set as "api"
    * Client Authentication: set as "Send as Basic Auth header"

4. Check that the request is configured as in the following image

    ![Postman_Post_Configuration](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Postman-Post-Config.PNG)

4. Copy the following Json as the request body

    ````
    {
        "_code":"AnalogSound",
        "_name":"Analog Sound Inc."
    }

    ````

5. Click on send and check the Omnia API response. If request was made successfully, a 201 status code is expected

6. Now change the request type to GET, and retrieve the Company record saved on last step by setting the url as the base url with "/api/v1/DT008/prd/Application/Company/default/AnalogSound" at the end

7. Check that the response body has the data inserted on the POST request
