---
title: OMNIA 3.0 Workflow Tutorial
keywords: omnia3
summary: "OMNIA Workflow Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_workflowtutorial.html
folder: omnia3
---

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

## 3. Modeling a Workflow apllication

1. Start by selecting the tenant where you are going to model, and you will be redirected to the modeling area.
 
    ![Homepage_Dashboard](http://funkyimg.com/i/2DVGv.png)
 
2. Create a new  **Agent**, and set its  *Code*  to  **Company**.
       
3. Return to the  **Agents** list and add a new agent, setting its *Code* as **Employee**.

    ![Modeler_Create_Agent](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Modeler-Agent-Employee.PNG)

4. Create a new  **Resource**, and set its  *Code*  to  **Task**.
    
5. Access the option  **Versioning > Builds**  and build your tenant, by clicking the button  **Create new**.

6. Proceed to the Application area, and configure all figures previously defined: create a new **Company**, by selecting the option **Configurations > Company** and defining its *Code* and *Name*.

7. Follow the same process of the previous step to create a new *Employee* and *Task*.

8. Go back to Modeling area and create a new **Event** with Code set as *Executedtask*, *Task* as the resource to be exchanged, *Employee* as provider agent, and *Company* as receiver agent.

    ![Event_Executed task](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Event-TaskList.PNG)

9. Create a new **Document**, naming it as **TaskReport**.

10. Add a new **Generic Entity**, and set the code as *Project*.

11. On Modeler, go to **Data Analytics > Queries** and verify if *Executedtask_Query* is already created.


12. Proceed to **Analytics > Dashboards** and create a new list. Set *Executedtasklist* as Code, the query created on first step (ExecutedtaskQuery) as the source of the list and Task as Label.

    ![Task List Query](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Queries-List-Executedtask.PNG)
    
12. Add new columns to **List**. Add a column for Query Property *Code*, with Label *Task*, and format as *Text*

    ![Task List Query](https://raw.githubusercontent.com/numbersbelieve/omnia3/master/docs/tutorialPics/modelingTutorial/Code-QueryList.PNG)

13. On **Data Analytics > Dashboards**, create a new dashboard and set *Home* as Code, so the dashboard will be visible on application’s homepage.

    ![Modeler_Create_Dashboard](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Dashboard.PNG)
    
14. Add lists to **Dashboard**. Set *Executedtask* as Code, Executedtask_List (created previously) and position it in the first Row and Column, with Size six.

15. Add an new Attribute to your Document. Set its Code as *Project*, Type as **Generic Entity > Project**.

    - Add a new Attribute to your Document. Set its Code as *Company*, Type as **Generic Entity > Project** , and as required by checking option *Is required?*.

    - Add a new Attribute to your Document. Set its Code as *Employee*, Type as **Generic Entity > Project**, and as required by checking option *Is required?*.


16. Edit the previously modeled **Document** *TaskReport*. Create a new Attribute, setting its Code and Type to EmployeeName and Primitive > Text, respectively. Set the attribute as Read Only.

17. Create a new **Action Behaviour** to fill the new attribute (on the *TaskReport* document, go to tab *Behaviours* and click on **Add new > Action**). Set *GetRecordData* as Code, Code as the attribute that triggers the behaviour, and paste the following code:







