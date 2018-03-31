OMNIA Platform 3.0, a truly **Agile Development** and operation of **Management Information Systems**' **platform**, welcomes you aboard to its continuous development process: the User Experience. 

We do understand all your difficulties on how to build a **business management application** from ground zero. That's why **OMNIA** takes the pledge to **leverage and accelerate** the entire development process, providing a **simple**, **fast** and **responsive-by-default** platform.

It's now time to judge our premises. To that end, we've just created a simple and intuitive tutorial based on an Order Management's example, guiding you throughout the **short-time period** of deploying all your inputs into a **business application**.  

## Start your 20-minute exercise on OMNIA Platform V.3.0!


## 1. First Steps on the OMNIA Modeler

At this stage, you should have already defined your **Tenant** - an **isolated development environment** - which means you're ready to access OMNIA platform's Main Menu.

![enter image description here](http://funkyimg.com/i/2DVGv.png)



## 2. Modeling Agents

Firstly, you'll define the **Agents** of your interaction in the **Modeler** menu:
- Create agent ***Company*** and agent ***Supplier***.




## 3. Modeling a Resource

- Add a new **Resource** and name it as ***Item***.

![Add a new Resource](http://funkyimg.com/i/2DWiH.png)


## 4. Create a new build

**For each time** you fill up your data on the Modeler Menu, don't forget to click on ***+ Create new***, in order to gather all kind of data that you're incorporating in the application.

![enter image description here](http://funkyimg.com/i/2DWab.png)


## 5. Identify your Agents

Go to the **Application** area, and proceed to the identification of your ***Agents*** and ***Resources***:
- Configure your **Company**, **Supplier** and **Item** with a *Code* and *Name* respectively (**note: both code and Name must have similar identity**)

## 6. Commitment

A **Commitment** is constituted by its **Agents** (***Provider*** and ***Receiver***) and **Resources**, each one of them with its own **Attributes** and **Behaviours**. 

-  Proceed to a new **Commitment**, naming it ***GoodsPurchaseRequest***. 



## 6.1. Add an attribute

You may characterize your Model with several **Attributes**, by determining their own *Codes* and *Types*. 
- Add the **Attribute** ***UnitPrice***, as it will indicate the unit price of the product being ordered.


## 6.1.1. Add a behaviour 

**Behaviours** execute and return the **value** of all variables inserted into the **Application**, such as *Attributes*. You may perform it by adding several new ***Formulas***, ***Actions***, ***Initializers*** or ***Finalizers*** (**note: see the Advanced Tutorial for further instructions**)

- On this exercise, calculate the ***Amount*** Attribute, by executing the following code: *return UnitPrice * Quantity;*


![enter image description here](http://funkyimg.com/i/2DVGr.png)




## 6.2. Edit an Attribute in your Commitment

- Still on the *Commitment*s tab,  edit the **Attribute** ***Amount*** and update the element *Is read-only?* with a check mark, as the **Attribute** ***Amount*** is a calculated one. 



## 7. Document

The **Document** will describe all ***Items*** exchanged between **Agents** - ***Supplier*** and ***Company***.   

- Name it as ***PurchaseOrder*** on the Application's Menu.


## 7.1. Add Attributes to your Document

 - Add a new **Attribute** to your **Document**, designated as *OrderLines* with *Code* and *Type* (Commitment) correspondingly, and associate both to your **Agents**. 





## 8. Perform a new build

![enter image description here](http://funkyimg.com/i/2DWab.png)



## 9. Originate your Purchase Order Serie

- Return to the Application's Environment and to your ***Document***.
By choosing the option *+Add new*, OMNIA creates automatically a *Serie* to your **PurchaseOrder** Document, in order to identify it afterwards.

## 10. Create your Purchase Order

- Go back to **Documents**, as your ***PurchaseOrder*** **Document** is now available with the **Attributes** previously defined on the **Modeler**.




## 11. Reorganize your Purchase Order's Form

## 11.1. Manage your User Interface Elements

- **Return** to your ***PurchaseOrder*** **Document** on the Modeling Environment and manage the **Attributes** *Serie* and *Number*, by re-positioning them on the *User Interface*'s dashboard.

-  **Replace** Rows and Columns, re-establishing the **size** and **position** of their fields [(***Serie***: Row 1, Column 1 and Size 4, respectively); (***Number***: Row 1, Column 5 and Size 4, respectively)].


## 11.2. Simplify your Purchase Order's Form

 Yet, there are still a couple of elements that could be simplified in your **PurchaseOrder**'s Form:
- Return to the ***User Interface*** area and delete the **Attributes** *Code*, *Provider* and *Receiver*, as they have been replaced already by ***Supplier*** and ***Company***, respectively. 
