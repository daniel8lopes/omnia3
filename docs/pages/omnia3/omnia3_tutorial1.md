---
title: OMNIA Beginner Tutorial
keywords: omnia3
summary: "Beginner Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_tutorial1.html
folder: omnia3
---

## 1. Introduction

OMNIA Platform 3.0, a truly **Agile Development** and operation of **Management Information Systems**' **platform**, welcomes you aboard to its continuous development process: the User Experience.

We do understand all your difficulties on how to build a **business management application** from ground zero. That's why **OMNIA** takes the pledge to **leverage and accelerate** the entire development process, providing a **simple**, **fast** and **responsive-by-default** platform.

It's now time to judge our premises. To that end, we've just created a simple and intuitive tutorial based on an Order Management's example, guiding you throughout the **short-time period** of deploying all your inputs into a **business application**.

**Start your 20-minute exercise on OMNIA Platform V.3.0!**

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

## 3. Modeling an application

1. Start by selecting the tenant where you are going to model, and you will be redirected to the modeling area.
 
    ![Homepage_Dashboard](http://funkyimg.com/i/2DVGv.png)
 
2. Through the left side menu, access the option **Agents**. Create a new **Agent** by clicking the button **Add new**  on the top right side, and setting its **Code** to **Company**.

    ![Modeler_Create_Agent](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Agent.PNG)

3. Return to the **Agents** list and add a new agent by clicking on button **Add new** and setting its *Code* as **Supplier**.

4. Through the left side menu, access the option **Resources**. Create a new **Resource** by clicking the button **Add new**  on the top right side, and setting its **Code** to **Product**.

5. Access the option **Versioning > Builds** and build the tenant by clicking the button **Create new**.

6. On the left side menu, select option **Go to > Application**, and create a new **Company** by selecting the option **Configurations > Company**  and defining its *Code* and *Name*.

    ![Application_Create_Agent](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Application-Create-Agent.PNG)

7.  Follow the same process of the previous step to create a new **Supplier** and **Product**.

8. Go back to modeling area (by accessing the option **Go to > Modeler**) and create a new **Commitment** with *Code* set as ***GoodsPurchaseRequest***, **Product** as the resource to be exchanged, **Supplier** as provider agent and **Company** as receiver agent.

    ![Modeler_Create_Commitment](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Commitment.PNG)

9. Add a new attribute by clicking on button **Add new**. Set its *Code* as **UnitPrice**, *Type* as **Primitive > Decimal**, and as required by checking option *Is required?*.

    ![Modeler_Create_Attribute](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-Attribute.PNG)

10. Add a new behaviour by selecting the tab **Behaviours** and clicking on button **Add new > Formula**. Set its *Code* as **CalculateAmount**, attribute as **_amount** and set as code to execute `return UnitPrice * _quantity;`.

11. Add a new document (by accessing the option **Documents** on side menu and clicking on **Add new** button). Set **PurchaseOrder** as the document's *Code*;

12. Click on button **Add new** to add an **Attribute** to your **Document**. Set its *Code* as *OrderLines*, *Type* as **Commitment > GoodsPurchaseRequest**.

    ![Modeler_Create_Composite_Attribute](https://github.com/numbersbelieve/omnia3/raw/master/docs/tutorialPics/modelingTutorial/Modeler-Create-CompositeAttribute.PNG)

13. Perform a new Build (by accessing the option **Versioning > Builds** and clicking on button **Create new**).

14. Select option **Go to > Application**, and create a new **PurchaseOrder** by selecting the option **Documents > PurchaseOrder**.

15. Go back to modeling area (by accessing the option **Go to > Modeler**) and edit the **PurchaseOrder** document to simplify its interface. Add a new attribute by clicking on button **Add new**. Set its *Code* as **Company**, *Type* as **Agent > Company**, and as required by checking option *Is required?*.

16. Add a new attribute by clicking on button **Add new**. Set its *Code* as **Supplier**, *Type* as **Agent > Supplier**, and as required by checking option *Is required?*. 

17. Add Finalize Behaviour

18. Go to your ***PurchaseOrder*** **Document** User Interface by accessing the respective tab, and reorganize them to simplify the interface. Remove attribute **Provider**, **Receiver**  and **Code** from **OrderLines** element. At last, remove **Code** attribute from Document.

19. Reorganize Rows and Columns, re-establishing the **size** and **position** of their attributes:
  * ***Serie***: Row 1, Column 1 and Size 4; 
  * ***Number***: Row 1, Column 5 and Size 4; 
  * ***Date***: Row 1, Column 9 and Size 4; 
  * ***Company***: Row 2, Column 1 and Size 4;
  * ***Supplier***: Row 2, Column 5 and Size 4.
