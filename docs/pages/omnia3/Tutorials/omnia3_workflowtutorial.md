---
title: OMNIA 3.0 Workflow Tutorial
keywords: omnia3
summary: "OMNIA Workflow Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_workflowtutorial.html
folder: omnia3
---

## 1. Introduction

OMNIA's Worflow Tutorial enhances your experience on OMNIA Platform 3.0, combining advanced elements and features from previous Tutorials with your daily workflow tools.

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

## 3. Modeling a Workflow apllication

1. Start by selecting the tenant where you are going to model, and you will be redirected to the modeling area.
 
    ![Homepage_Dashboard](http://funkyimg.com/i/2DVGv.png)
 
2. Create a new  **Agent**, and set its  *Code*  to  **Company**.
       
3. Return to ***Agents / Add new***, and set its *Code* as **Employee**.

    ![Modeler_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Agent-Employee.PNG)

4. Create a new  **Resource**, and set its  *Code*  to  **Task**.
    
5. Access the option  ***Versioning / Builds / Create new***.

6. Proceed to the Application area, configure all figures previously defined, by selecting the option ***Configurations / Company / Create new***, and defining its *Code* and *Name*.

7. Follow the same process of the previous step to create a new **Employee** and **Task**.

8. Go back to Modeling area and create a new **Event** with *Code* set as **Executedtask**, **Task** as the *resource* to be exchanged, **Employee** as provider agent, and **Company** as receiver agent.

    ![Event_Executed task](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Event-TaskList.PNG)

9. Add a new **Generic Entity**, and set the code as *Project*.

10. Create a new **Document**, naming it as **TaskReport**.

11. Go to ***Data Analytics / Queries*** and create a query for your Event. Name it **Executedtask_Query**. Add a single property with alias **Code** for the path **_code**.

12. Access ***Data Analytics / Lists*** and create a new list. Set **Executedtask_List** as *Code*, the query created on first step (**ExecutedtaskQuery**) as the *source* of the list and **Task** as *Label*.

    ![Task List Query](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Queries-List-Executedtask.PNG)
    
13. Add new columns to **List**. Add a column for Query Property *Code*, with Label *Task*, and format as *Text*

    ![Task List Query](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Code-QueryList.PNG)

14. On ***Data Analytics / Dashboards***, create a new dashboard and set **Home** as *Code*, so the dashboard will be visible on application’s homepage.

    ![Modeler_Create_Dashboard](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Dashboard.PNG)
    
15. Add lists to **Dashboard**. Set **Executedtask** as *Code*, its List as **Executedtask_List** (created previously) and position it in the first Row and Column, with Size six. Set its label as **Executed Tasks**.

16. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***). Access the application and verify the homepage dashboard shows up.

17. Go back to the modeler and edit the **TaskReport** Document, by accessing ***Documents / TaskReport***.
    - Add an new Attribute to your Document. Set its *Code* as **Project**, *Type* as ***Generic Entity / Project***.

    - Add a new Attribute to your Document. Set its *Code* as **Company**, *Type* as ***Agent / Company*** , and as required by checking option *Is required?*.

    - Add a new Attribute to your Document. Set its *Code* as **Employee**, Type as ***Agent / Employee***, and as required by checking option *Is required?*.

    - Add a new Attribute to your Document. Set its *Code* as **EmployeeName**, Type as ***Primitive / Text***, and as read-only by checking option *Is Read Only?*.

    - Add a new Attribute to your Document. Set its *Code* as **SheetID**, Type as ***Primitive / Text***, and as read-only by checking option *Is Read Only?*.

    - Add a new Attribute to your Document. Set its *Code* as **ReportLines** and Type as ***Event / ExecutedTask***.

    ![Modeler_Create_Dashboard](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Attribute%20-%20EmployeeName.PNG)

18. Go back to **Generic Entity**, and add a new **Attribute** to **Project**. Set its *Code* as ***SheetID***, and its type as ***Primitive / Text***.

19. Go to **Events**, and add a new **Attribute** to **Executedtask**. Set its *Code* as *TaskDate*, and its type as ***Primitive / Date***.

20. Add another **Attribute** to **Executedtask**, setting its *Code* as ***Description***, and its type as *** Primitive / Text***. 

21. Go to **Google Sheets** and create a new file. [Generate an API key to access it](https://developers.google.com/sheets/api/guides/authorizing). Make a note of the file's ID, which you can obtain from the URL; for example, for the URL https://docs.google.com/spreadsheets/d/omniaID1234/edit#gid=0, the ID would be **omniaID1234**.

Copy the data from [this file](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Task%20Project%2001.xlsx) to the sheet you just created.

23. In the **TaskReport** document, go to tab *Behaviours* and click on ***Add new / Action***. Set **GetReportData** as *Code*, **SheetID** as the attribute that triggers the behaviour, and paste the following code, taking care to replace the "INSERT YOUR KEY HERE" with the key obtained in the last step:

    ````
    if (!string.IsNullOrEmpty(SheetID))
    {
        var client = new System.Net.Http.HttpClient()
        {};
        string googleApiKey = "INSERT YOUR KEY HERE";
        string apiEndpoint = $"https://sheets.googleapis.com/v4/spreadsheets/{SheetID}/values/Sheet1?key={googleApiKey}";
        var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();
        string responseBody = requestResult.Content.ReadAsStringAsync().Result;
        if (!requestResult.IsSuccessStatusCode)
            throw new Exception("Error on retrieving Google sheet: " + responseBody);
        var sheet = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);
        var values = JsonConvert.DeserializeObject<List<List<string>>>(sheet["values"].ToString());

        for (int i = 2; i < values.Count; i++) //first two lines are headers
        {
            ExecutedTask taskLine = new ExecutedTask(_context, null);
            taskLine._resource = values[i].ElementAt(0);
            taskLine.TaskDate = Convert.ToDateTime(values[i].ElementAt(1));
            taskLine.Description = values[i].ElementAt(2);
            taskLine._quantity = Convert.ToInt32(values[i].ElementAt(3));
            ReportLines.Add(taskLine);
        }
    }
    ```` 

24. In the **TaskReport** document, go to tab *Behaviours* and click on ***Add new / Action***. Set **GetSheetID** as *Code*, **Project** as the attribute that triggers the behaviour, and paste the following code:
    ```` 
    var project = ApiClient.Get(this.Context, "Project", newValue);
    SheetID = project["sheetID"].ToString();
    ```` 

25. In the **TaskReport** document, go to tab *Behaviours* and click on ***Add new / Action***. Set **GetEmployeeName** as *Code*, **Employee** as the attribute that triggers the behaviour, and paste the following code:
    ```` 
    var employee = ApiClient.Get(this.Context, "Employee", newValue);
    EmployeeName = employee["_name"].ToString();
    ```` 

26. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

27. Go to ***Application / Configurations*** area, and create a new **Project**. Set its **SheetID** attribute to the value we obtained earlier when setting up the Google Sheet.

28. Return to **Application** area, and create a new *Taskreport* **Document**. If **Project** has an associated and valid **Google Sheet**, your **TaskReport** lines will be automatically loaded.








