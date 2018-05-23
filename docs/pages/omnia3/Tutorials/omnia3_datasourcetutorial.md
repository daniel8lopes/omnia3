---
title: OMNIA Data Source Tutorial
keywords: omnia3
summary: "OMNIA Platform 3.0 data source management"
sidebar: omnia3_sidebar
permalink: omnia3_datasourcetutorial.html
folder: omnia3
---

## 1. Introduction

Based on a simple Employee management scenario, this tutorial shows how easy can Omnia communicate with other systems.

The system we are using to communicate is a free API named REQRES [ReqRes](https://reqres.in/), that simulates real time CRUD operations.

However, since this is only a simulation, no actual data is manipulated (written, updated or removed) on REQRES system. 


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

If you do not have a tenant yet, please follow the steps of the [Tenant Creation tutorial](http://docs.numbersbelieve.com/omnia3_tenantcreation.html).

## 3. Modeling an application

1. Create a new Data Source, named "ExternalAPI". Set its Behaviour runtime as Internal, and its Data access runtime as External

2. Create a new Agent "Employee", and set it as using the external data source "ExternalAPI"

3. On Agent Employee, navigate to tab "Data Behaviours", and define a behaviour to be executed on "Create". This behaviour simulates a POST request to the external Application. Copy and paste the following code:

  ````
    var client = new System.Net.Http.HttpClient();
    
    string apiEndpoint = $"https://reqres.in/api/users/";

    var body = new
    {
      code = dto._code,
      name = dto._name
    };

    var jsonBody = JsonConvert.SerializeObject(body);
    var httpContent = new System.Net.Http.StringContent(jsonBody, System.Text.Encoding.UTF8, "application/json");

    var requestResult = client.PostAsync(apiEndpoint, httpContent).GetAwaiter().GetResult();

    string responseBody = requestResult.Content.ReadAsStringAsync().Result;

    if (!requestResult.IsSuccessStatusCode)
      throw new Exception("Error on creating contact: " + responseBody);

    var response = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

    EmployeeDto employeeResponse = new EmployeeDto();
    employeeResponse._code = response["code"].ToString();
    employeeResponse._name = response["name"].ToString();
    return employeeResponse;
    
  ````

4. On "Data Behaviours" of Agent Employee, define a behaviour, to be executed on "Delete" (when a Employee is deleted). Copy and paste the following code:


  ````
    var client = new System.Net.Http.HttpClient();
    
    string apiEndpoint = $"https://reqres.in/api/users/{identifier}";

    var requestResult = client.DeleteAsync(apiEndpoint).GetAwaiter().GetResult();

    string responseBody = requestResult.Content.ReadAsStringAsync().Result;

    if (!requestResult.IsSuccessStatusCode)
      throw new Exception("Error on removing Employee: " + responseBody);

    return true;
  
````

5. Create a new Data Behaviour for operation "Read", so that data is retrieved when a Employee is edited. Copy and paste the following code:

 ````
    var client = new System.Net.Http.HttpClient();
    string apiEndpoint = $"https://reqres.in/api/users/{identifier}";

    var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

    string responseBody = requestResult.Content.ReadAsStringAsync().Result;
    if (!requestResult.IsSuccessStatusCode)
      throw new Exception("Error on creating contact: " + responseBody);
      
    var response = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);
    var responseData = JsonConvert.DeserializeObject<Dictionary<string, object>>(response["data"].ToString());

    EmployeeDto employeeResponse = new EmployeeDto();
    employeeResponse._code = responseData["id"].ToString();
    employeeResponse._name = $"{responseData["first_name"].ToString()} {responseData["last_name"].ToString()}";

    return employeeResponse;
  
````

6. Create a new Data Behaviour for operation "ReadList", so that data is retrieved when Employees list is requested. Copy and paste the following code:

  ````
  {% raw %}
    var client = new System.Net.Http.HttpClient();
    string apiEndpoint = $"https://reqres.in/api/users?page={page}";

    var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

    string responseBody = requestResult.Content.ReadAsStringAsync().Result;
    if (!requestResult.IsSuccessStatusCode)
      throw new Exception("Error on creating contact: " + responseBody);
      
    var response = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);
    var responseData = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(response["data"].ToString());

    List<IDictionary<string, object>> employeesList = new List<IDictionary<string, object>>();

    foreach (var employee in responseData)
    {
      var line = new Dictionary<string, object>()
      {{"_code", employee["id"]}, {"_name", employee["first_name"] + " " + employee["last_name"]}};
      employeesList.Add(line);
    }

    return (responseData.Count, employeesList);
  {% endraw %}
````

7. Create a new Data Behaviour for operation "Update", so that data is retrieved when a single Employee is updated. Copy and paste the following code:

  ````
    var client = new System.Net.Http.HttpClient();
    string apiEndpoint = $"https://reqres.in/api/users/{dto._code}";

    var body = new
    {
      code = dto._code,
      name = dto._name
    };
    
    var jsonBody = JsonConvert.SerializeObject(body);

    var httpContent = new System.Net.Http.StringContent(jsonBody, System.Text.Encoding.UTF8, "application/json");

    var requestResult = client.PutAsync(apiEndpoint, httpContent).GetAwaiter().GetResult();
    string responseBody = requestResult.Content.ReadAsStringAsync().Result;
    
    if (!requestResult.IsSuccessStatusCode)
      throw new Exception("Error on creating contact: " + responseBody);

    var response = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

    EmployeeDto employeeResponse = new EmployeeDto();
    employeeResponse._code = response["code"].ToString();
    employeeResponse._name = response["name"].ToString();

    return employeeResponse;
  
````

8. Build the model

9. On Application area, create a new instance of the ExternalAPI data source, with code "ReqRes"

10. On left side menu, navigate to Configurations | Employee, and check that the list is filled with data retrieved from external data source ReqRes;



