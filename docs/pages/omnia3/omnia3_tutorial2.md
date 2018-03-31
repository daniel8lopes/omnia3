---
title: OMNIA Modeling Environment 2
keywords: omnia3
summary: "OMNIA Advanced Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_tutorial2.html
folder: omnia3
---

## 1. Introduction

After you complete the first tutorial, whose result is a functional order management application, this tutorial focus on advanced behaviour modeling and data analysis.

In the area of advanced behaviours, we will explore how to comunicate with OMNIA's native API to improve the user experience, and an external API.
In data analysis, we will explore how to model new lists and how to create dashboards on OMNIA.

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Modeling tutorial](http://docs.numbersbelieve.com/omnia3_tutorial1.html), as this tutorial builds upon it.

## 3. Advanced Behaviours

### Native API
 
1. Go to the **Modeler** and edit the previously modeled document PurchaseOrder. Create a new  **Attribute**  by clicking the button  **Add new**  on the top right side, and setting its  **Code** and **Type**  to  **SupplierName** and **Primitive > Text**, respectively. Set the attribute as **Read Only**.

2. Create a new **Action Behaviour**  to fill the new attribute (on the PurchaseOrder document, go to tab **Behaviours** and click on **Add new > Action**). Set **GetSupplierName** as **Code**, **Supplier** as the attribute that triggers the behaviour, and paste the following code:

````
var authValue = new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", this._context.Authentication.AccessToken);

var client = new System.Net.Http.HttpClient() { DefaultRequestHeaders = { Authorization = authValue } };

string apiEndpoint = $"{this.Context.Tenant.ApiEndpoint}{this.Context.Tenant.Code}/{this.Context.Tenant.EnvironmentCode}/Application/Supplier/{Supplier}";
var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

string responseBody = requestResult.Content.ReadAsStringAsync().Result;
var supplier = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

if (!requestResult.IsSuccessStatusCode)
    throw new Exception("Error on retrieving Supplier name: "+ responseBody);

SupplierName = supplier["_name"].ToString();

````

3. Build the model.

4. Go to **Application** area, and create a new **PurchaseOrder** document. Observe that, when **Supplier** is identified, the **SupplierName** is automatically retrieved.

### External API

1. Go to the **Modeler** and edit the previously modeled resource Product. Create a new  **Attribute**  by clicking the button  **Add new**  on the top right side, and setting its  **Code** and **Type**  to  **Artist** and **Primitive > Text**, respectively. Set the attribute as **Read Only**.

2. Create a new **Action Behaviour**  to fill the new attribute (on the PurchaseOrder document, go to tab **Behaviours** and click on **Add new > Action**). Set **GetRecordData** as **Code**, **Code** as the attribute that triggers the behaviour, and paste the following code:

````
var client = new System.Net.Http.HttpClient() {DefaultRequestHeaders = {}};
client.DefaultRequestHeaders.Add("User-Agent", "OMNIA");

string apiEndpoint = $"https://api.discogs.com/masters/{_code}";
var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

string responseBody = requestResult.Content.ReadAsStringAsync().Result;

Dictionary<string, object> responseDictionary = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

if (!requestResult.IsSuccessStatusCode)
    throw new Exception("Error on retrieving data from Discogs API: " + responseDictionary["message"].ToString() + " " + apiEndpoint);

_name = responseDictionary["title"].ToString();

if (responseDictionary.ContainsKey("artists")) {
    Linq.JArray artists = (Linq.JArray)responseDictionary["artists"];
                
    if (artists != null && artists.Count > 0) {
        Artist = artists[0]["name"].ToString();
    }
}
````

3. Build the model.

4. Go to **Application** area, and create a new **Product** resource. Observe that, when **Code** is identified (e.g. try with value 8540), the **Name** and **Artist** is automatically retrieved.

## 4. Data Analysis

###Queries and Lists

1. On **Modeler**, go to **Data Analytics > Queries** and click on button **Add New** to create a new query. Set **ProductsArtists_Query** as Code and **Resource > Product** as Type.

2. Click on button **Add New** to add columns to Query. Add a column with Alias **Code** and Path **_code**.

3. Repeat previous step to add columns with alias **Name** and **Artist**, whose Path is **_name** and **artist**, respectively.

4. Go to **Data Analytics > Lists** and click on button **Add New** to create a new list. Set **ProductsArtists_List** as Code, the query created on first step (**ProductsArtists_Query**) as the source of the list and **Products** as Label.

5. Click on button **Add New** to add columns to List. Add a column for Query Property **Code** with Label **Album Code**, and format as **Text**

6. Repeat previous step to add columns for Query Properties **Name** and **Artist**.


###Dashboards

1. On **Modeler**, go to **Data Analytics > Dashboards** and click on button **Add New** to create a new dashboard. Set **Home** as Code, so that the dashboard is visible on application's homepage.

2. Click on button **Add New** to add lists to Dashboard. Set **ProductsList** as Code, select **ProductsArtists_List** (created previously) and position it in the first **Row** and **Column**, with **Size** six.

3. Go to application and check the homepage dashboard.
