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
    
    ![Homepage_Dashboard](/images/tutorials/beginner/Modeler-Homepage.PNG)
    
2.  Through the left side menu, access the option  ***Agents / Add new*** on the top right side, and set its  *Name*  as  **Company**.

    ![Modeler_Create_Agent](/images/tutorials/expensemanagement/Modeler-Add-Agent.PNG)
   
3.  Return to the  ***Agents / Add new*** and set its *Name* as **Employee**.
    
4.  Through the left side menu, access the option  ***Resources / Add new*** and set its  *Name*  as  **Expenses**.
    
5.  Build the model, by accessing the option  ***Versioning / Builds / Create new***.
    
6.  On the right side of the top bar, click second button and select option ***Application*** to be redirected to application area. Then, on left side menu, click on ***Configurations / Company / Create new*** to create a new Company. Define its *Code*  and  *Name*.
    
    ![Application_Create_Agent](/images/tutorials/expensemanagement/Application-Add-Agent.PNG)
    
7.  Follow the same process of the previous step to create a new  **Employee**  and  **Expenses**.
    
8.  Go back to modeling area (through the top bar, by accessing the option  ***Modeler***) and create a new  **Commitment**  with  *Name*  set as  **ExpenseRefundRequest**,  **Expenses**  as the resource to be exchanged,  **Employee**  as provider agent and  **Company**  as receiver agent.
  
    ![Modeler_Create_Commitment](/images/tutorials/expensemanagement/Modeler-Add-Commitment.PNG)
 
9. On the left side menu, select the option ***Commitments / ExpenseRefundRequest***. Create a new **Attribute**, by clicking the button  **Add new**  on the top right side, and setting its  *Name*  to  **ExpenseAmount**, *Type* as ***Primitive / Decimal***, and as required by checking option *Is required?*. Additionally, set *_amount* attribute as read-only.
    
10. Add a new document (by accessing the option ***Documents / Add new*** button) and set its *Name* as **ExpenseReport**. 
   
11. On the left side menu, select the option **Generic Entities**. Create a new one, by clicking the button  **Add new**  on the top right side, and set its *Name*  as  **Currency**.
  
12. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

13. Go back to application area (through the top bar option) and create a new **Currency**. Set its *Code* as EUR and *name* as Euro.

     ![Application_Create_Agent](/images/tutorials/expensemanagement/Application-Create-Currency.PNG)
        
14. Access the option ***Series / ExpenseReportSerie / Add new*** and set its *Code* as **A**, and *Name* as **Expenses Report Serie**.

15. Open ***Documents / Expense Report*** and create a document. As you can see, the interface usability can be improved. We will now proceed to simplify it, and add more information.

16. Go back to modeling area (through the top bar option) and edit the **Document / ExpenseReport**  document to simplify its interface. Add a new attribute by clicking on button  ***Add new***. Set its *Name* as **Company**, its *Type*  as  ***Agent / Company***, and as required by checking option *Is required?*.

17. Click on button **Add new** to add an **Attribute** to your **Document**. Set its *Name* as **ExpenseLines**, *Type* as ***Commitment / ExpenseRefundRequest***.

    ![Modeler_Add_Commitment_Attribute](/images/tutorials/expensemanagement/Modeler-Add-ExpenseReport-ExpenseRefundRequest.PNG)

    - Add a new Attribute to your **Document**. Set its *Name* as **Currency**, *Type* as ***Generic Entity / Currency***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Name* as **Employee**, *Type* as ***Agent / Employee***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Name* as **ExpenseDetails**, *Type* as ***Primitive / Text***.

    - Add a new Attribute to your **Document**. Set its *Name* as **ExchangeRate**, *Type* as ***Primitive / Decimal***, and as required by checking option *Is required?*.

    - Add a new Attribute to your **Document**. Set its *Name* as **TotalAmount**, *Type* as ***Primitive / Decimal***, as read only by checking option *Is read only* and as required by checking option *Is required?*.
    
    - Add a new Attribute to your **Document**. Set its *Name* as **ExpenseDate**, *Type* as ***Primitive / Date***, and as required by checking option *Is required?*.

18. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***). Access the application and test the new creation of the document.

19. Go back to modeling area (through the top bar option) and edit the  **Document / ExpenseReport**  document.

20. (**Optional**) Navigate to tab “Entity References“, and define a reference for .NET assembly System.Net.Http

    ![Modeler_Create_Reference](/images/tutorials/expensemanagement/Modeler-Create-Reference.PNG)
    
    Add a new **Action Behaviour**, in order to return automatically your updated *Exchange Rate*, based on an external API . Set *GetRateData* as Code, and the attribute as *Currency*. Paste the following code:

    ```C#
    var client = new HttpClient() { };

    string apiEndpoint = $"http://data.fixer.io/api/latest?access_key=13854a5cc70cff0901740c1a7ac3c5b3&symbols={Currency}";
    var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();

    var responseBody = requestResult.Content.ReadAsStringAsync().Result;
    var rateData = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);

    if (!requestResult.IsSuccessStatusCode)
        throw new Exception("Error on retrieving rate: " + responseBody);

    var value = JsonConvert.DeserializeObject<Dictionary<string, object>>(rateData["rates"].ToString());

    ExchangeRate = Convert.ToDecimal(value[$"{Currency}"].ToString());
    ```
    This example will give the exchange rate between EUR and the currency provided in the attribute Currency. You can try it out with different currencies, such as **GBP** or **USD**.

21. Add a new **Before Save Behaviour** to fill *Provider* and *Receiver* attributes by accessing the tab Behaviours and clicking the button ***Add new / Before Save***. Set *BeforeSaveBehaviours* as Name and paste the following code:

    ```C#
    ExpenseDetails.ForEach(a => {
        a._receiver = Company;
        a._provider = Employee;
        a._amount = a.ExpenseAmount/ExchangeRate
    });
    TotalAmount = ExpenseDetails.Sum(a => a._amount); 
    ```
    
22. Go to your **ExpenseReport** Document User Interface by accessing the respective tab, and reorganize it to simplify the interface. Delete the attributes Code, Provider, Receiver and Quantity from the **ExpenseDetails** element. At last, delete the Code attribute from Document.

23. Reorganize Rows and Columns, re-establishing the size and position of their attributes:
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

24. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

25. Go to application and validate User Interface changes, by creating a new **ExpenseReport** document. The interface should be equal to the one below:

       ![Application_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Application-ExpensesReport-Form.PNG)

    So, here you have it, a simple and descriptive Expense Report, completely built on **OMNIA Platform 3.0**!
    
