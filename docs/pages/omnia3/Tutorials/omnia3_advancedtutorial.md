---
title: OMNIA Advanced Tutorial
keywords: omnia3
summary: "Advanced Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_advancedtutorial.html
folder: omnia3
---

## 1. Introduction

After you have completed our first tutorial, whose result is a functional order management application, **OMNIA Advanced Tutorial** focus on advanced behaviour modeling and data analysis.

In *advanced behaviours* area, we will explore how to comunicate with **OMNIA's native API**, in order to improve the user experience, and an external API. As a external API, [Discogs](https://www.discogs.com/developers/) was chosen for this example.

In *data analysis*, we will explore how to model new lists and how to create dashboards on OMNIA.

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html), as this tutorial builds upon it.

## 3. Advanced Behaviours

### Native API
 
1. Go to the **Modeler** and edit the previously modeled document *PurchaseOrder*. Create a new  **Attribute**  by clicking the button  ***Add new***  on the top right side, and setting its  **Name** and **Type**  to  **SupplierName** and ***Primitive / Text***, respectively. Set the attribute as **Read Only**.

    ![Modeler_Create_Document_Attribute](/images/tutorials/advanced/Modeler-Create-Attribute-SupplierName.PNG)

2. Create a new ***Action Behaviour***  to fill the new attribute (on the *PurchaseOrder* document, go to tab **Entity Behaviours** and click on ***Add new / Action***). Set **GetSupplierName** as **Name**, **Supplier** as the attribute that triggers the behaviour, and paste the following code:

    ```C#
    var supplier = ApiClient.Get(this.Context, "Supplier", newValue);
    SupplierName = supplier["_name"].ToString();
    ```

3. Build the model.

4. Go to **Application** area, and create a new **PurchaseOrder** document. Observe that, when **Supplier** is identified, the **SupplierName** is automatically retrieved.

### External API

1. Go to the **Modeler** and edit the previously modeled resource *Product*. Create a new  **Attribute**  by clicking the button  **Add new**  on the top right side, and setting its  **Name** and **Type**  to  **Artist** and ***Primitive / Text***, respectively. Set the attribute as **Read Only**.

2. Navigate to tab *"[Entity References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for .NET assembly System.Net.Http

    ![Modeler goodsPurchaseRequest Add_Reference](/images/tutorials/advanced/Modeler-Create-Reference.PNG)

3. Create a new **Action Behaviour**  to fill the new attribute (on the PurchaseOrder document, go to tab ***Entity Behaviours*** and click on ***Add new / Action***). Set ***GetRecordData*** as **Name**, ***_code*** as the attribute that triggers the behaviour, and paste the following code:

    ```C#
    var client = new HttpClient() {DefaultRequestHeaders = {}};
    client.DefaultRequestHeaders.Add("User-Agent", "OMNIA");

    string apiEndpoint = $"https://api.discogs.com/masters/{_code}";
    var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

    string responseBody = requestResult.Content.ReadAsStringAsync().Result;

    Dictionary<string, object> responseDictionary = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

    if (!requestResult.IsSuccessStatusCode)
    throw new Exception("Error on retrieving data from Discogs API: " + responseDictionary["message"].ToString() + " " + apiEndpoint);

    _name = responseDictionary["title"].ToString();

    if (responseDictionary.ContainsKey("artists")) {
        Newtonsoft.Json.Linq.JArray artists = (Newtonsoft.Json.Linq.JArray)responseDictionary["artists"];
                
        if (artists != null && artists.Count > 0) {
            Artist = artists[0]["name"].ToString();
        }
    }
    ```

4. Build the model.

5. Go to **Application** area, and create a new **Product** resource. Observe that, when **Code** is identified (e.g. try with value 8540), the **Name** and **Artist** is automatically retrieved.

    ![Application_Create_Resource](/images/tutorials/advanced/Application-Create-Product.PNG)

## 4. Data Analysis

### Queries and Lists

1. On **Modeler**, go to ***Data analytics / Queries*** and click on button ***Add New*** to create a new query. Set **ProductsArtists_Query** as *Name* and ***Resource / Product*** as *Type*.

    ![Modeler_Create_Query](/images/tutorials/advanced/Modeler-Create-Query.PNG)

2. Click on button **Add New** to add columns to Query. Add a column with Alias **Code** and Path **_code**.
    
3. Repeat previous step to add columns with alias **Name** and **Artist**, whose Path is **_name** and **artist**, respectively.

4. Go to ***Data Analytics / Lists*** and click on button **Add New** to create a new list. Set **ProductsArtists_List** as Code, the query created on first step (**ProductsArtists_Query**) as the source of the list and **Products** as Label.

    ![Modeler_Create_List](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-List.PNG)
    
5. Click on button **Add New** to add columns to List. Add a column for Query Property **Code** with Label **Album Code**, and format as **Text**

    ![Modeler_Create_List_Attribute](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-List-Attribute.PNG)

6. Repeat previous step to add columns for Query Properties **Name** and **Artist**.


### Dashboards

1. On **Modeler**, go to ***Data Analytics / Dashboards*** and click on button **Add New** to create a new dashboard. Set **Home** as Code, so that the dashboard is visible on application's homepage.

    ![Modeler_Create_Dashboard](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Dashboard.PNG)

2. Click on button **Add New** to add lists to Dashboard. Set **ProductsList** as Code, select **ProductsArtists_List** (created previously) and position it in the first **Row** and **Column**, with **Size** six.

    ![Modeler_Add_List_Dashboard](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Add-List-Dashboard.PNG)

3. **Build** the model.

4. Go to the application and check the homepage dashboard. Data for the products you have created will be visible.
