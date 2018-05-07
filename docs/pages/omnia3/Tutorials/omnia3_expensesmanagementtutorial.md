---
title: OMNIA Expenses Management Tutorial
keywords: omnia3
summary: "Expenses Management Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_expensemanagementtutorial.html
folder: omnia3
---

## 1. Introduction

Based on a practical example of Expenses reporting, this Management Tutorial highlights the versatility and usability of OMNIA Platform on the daily cycle of businesses and organizations.


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

## 3. Modeling OMNIA Expenses Management

1.  Start by selecting the tenant where you are going to model, and you will be redirected to the modeling area.
    
    ![Homepage_Dashboard](http://funkyimg.com/i/2DVGv.png)
    
2.  Through the left side menu, access the option  ***Agents / Create new*** on the top right side, and setting its  *Code*  to  **Company**.
    
   
3.  Return to the  ***Agents / Add new*** and set its  *Code*  as  **Employee**.

    ![Modeler_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Agent-Employee.PNG)
    
4.  Through the left side menu, access the option  ***Resources / Create new*** and set its  *Code*  to  **Expenses**.
    
5.  Access the option  ***Versioning / Builds / Create new***.
    
6.  On the left side menu, select option  ***Go to / Application***, ***Configurations / Company / Create new***, and define its *Code*  and  *Name*.
    
    ![Application_Create_Agent](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Application-Create-Agent.PNG)
    
7.  Follow the same process of the previous step to create a new  **Employee**  and  **Expenses**.
    
8.  Go back to modeling area (by accessing the option  ***Go to / Modeler***) and create a new  **Commitment**  with  *Code*  set as  **ExpensesRequest**,  **Expenses**  as the resource to be exchanged,  **Employee**  as provider agent and  **Company**  as receiver agent.
  
    ![Modeler_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Commitment-ExpenseRequest.PNG)
    
9. Add a new document (by accessing the option ***Documents / Add new*** button) and set its *Code* as **ExpenseReport**. 
   
10. On the left side menu, select the option **Generic Entity**. Create a new **Entity**, by clicking the button  **Add new**  on the top right side, and setting its  **Code**  to  **Currency**.
  
11. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

12. Go back to application area (by accessing the option ***Go to / Application*** and configure the option  **Currency**. Set its *Code* as EUR and *name* as Euro.

     ![Application_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Application-Configurations-Currency.PNG)
        
13. Access the option ***Series / Add new*** and set its *Code* as **A**, and *name* as **Expenses Report Serie**.

14. Open ***Documents / Expense Report*** and create a document. As you can see, the interface is too complicated. We will now proceed to simplify it, and add more information.

15. Go back to modeling area (by accessing the option  ***Go to / Modeler***) and edit the **Document / ExpenseReport**  document to simplify its interface. Add a new attribute by clicking on button  ***Add new***. Set its _Code_ as **Company**, its *Type*  as  ***Agent / Company***, and as required by checking option *Is required?*.

16. Click on button **Add new** to add an **Attribute** to your **Document**. Set its *Code* as **ExpenseLines**, *Type* as ***Commitment / ExpensesRequest***.

    ![Application_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Document-Attribute2.PNG)

    - Add a new Attribute to your **Document**. Set its *Code* as **Currency**, *Type* as ***Generic Entity / Currency***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Code* as **Employee**, *Type* as ***Agent / Employee***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Code* as **ExpenseDetails**, *Type* as ***Commitment / ExpensesRequest***.

    - Add a new Attribute to your **Document**. Set its *Code* as **ExchangeRate**, *Type* as ***Primitive / Decimal***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Code* as **TotalAmount**, *Type* as ***Primitive / Decimal***, as read only by checking option *Is read only* and as required by checking option *Is required?*.
    
    - Add a new Attribute to your **Document**. Set its *Code* as **ExpenseDate**, *Type* as ***Primitive / Date***, and as required by checking option *Is required?*.

17. On the left side menu, select the option ***Commitments / ExpensesRequest***. Create a new **Attribute**, by clicking the button  **Add new**  on the top right side, and setting its  *Code*  to  **ExpenseAmount**, *Type* as ***Primitive / Decimal***, and as required by checking option *Is required?*.

18. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***). Access the application and test the new creation of the document.

15. Go back to modeling area (by accessing the option  ***Go to / Modeler***) and edit the  **Document / ExpenseReport**  document.

19. (**Optional**)  Add a new **Action Behaviour**, in order to return automatically your updated *Exchange Rate*, based on an external API . Set *GetRateData* as Code, and the attribute as _Currency_. Paste the following code:

            var client = new System.Net.Http.HttpClient() { };

            string apiEndpoint = $"http://data.fixer.io/api/latest?access_key=13854a5cc70cff0901740c1a7ac3c5b3&symbols={Currency}";
            var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

            var responseBody = requestResult.Content.ReadAsStringAsync().Result;
            var rateData = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

            if (!requestResult.IsSuccessStatusCode)
                throw new Exception("Error on retrieving rate: " + responseBody);

            var value = JsonConvert.DeserializeObject<Dictionary<string, object>>(rateData["rates"].ToString());

            ExchangeRate = Convert.ToDecimal(value[$"{Currency}"].ToString());

This example will give the exchange rate between EUR and the currency provided in the attribute Currency. You can try it out with different currencies, such as **GBP** or **USD**.

20. Add a new **Before Save Behaviour** to fill *Provider* and *Receiver* attributes by accessing the tab Behaviours and clicking the button ***Add new / Before Save***. Set *BeforeSaveBehaviours* as Code and paste the following code:

            ExpenseDetails.ForEach(a => a._receiver = Company);
            ExpenseDetails.ForEach(a => a._provider = Employee);
            ExpenseDetails.ForEach(a => a._amount = a.ExpenseAmount/ExchangeRate);
            TotalAmount = ExpenseDetails.Sum(a => a._amount); 
                        
    
21. Go to your **ExpenseReport** Document User Interface by accessing the respective tab, and reorganize them to simplify the interface. Delete the attributes Code, Provider, Receiver and Quantity from the **ExpenseDetails** element. At last, delete the Code attribute from Document.

22. Reorganize Rows and Columns, re-establishing the size and position of their attributes:
    - ***Serie***: Row 1, Column 1 and Size 4;
    - ***Number***: Row 1, Column 2 and Size 4;
    - ***Date***: Row 1, Column 3 and Size 4;
    - ***Company***: Row 2, Column 1 and Size 4;
    - ***Employee***: Row 2, Column 2 and Size 4;
    - ***Currency***: Row 2, Column 3 and Size 4;
    - ***ExchangeRate***: Row 3, Column 1 and Size 2;
    - ***ExpenseDate***: Row 3, Column 5 and Size 4;
    - ***ExpenseDetails***: Row 5, Column 1 and Size 12. Within the Expense Details, change the attributes:
        - ***Resource***: Row 1, Column 1 and Size 2;
        - ***Amount***: Row 1, Column 11 and Size 2;
    - ***TotalAmount***: Row 8, Column 11 and Size 2.

23. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

24. Go to application and validate User Interface changes, by creating a new **ExpenseReport** document. The interface should be equal to the one below:

       ![Application_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Application-ExpensesReport-Form.PNG)

    So, here you have it, a simple and descriptive Expense Report, completely built on **OMNIA Platform 3.0**!
    
    We have one more exercise for you. At this time, your **OMNIA skills** are getting sharpened and you're feeling comfortable with our technology. Now, we want to show you how **OMNIA** can guide you through your **daily workflow** checklist: time to proceed to our [**Workflow Tutorial**](http://docs.numbersbelieve.com/omnia3_workflowtutorial.html).
    
