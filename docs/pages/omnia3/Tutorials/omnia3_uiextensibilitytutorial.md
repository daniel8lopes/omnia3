---
title: OMNIA UI Extensibility Tutorial
keywords: omnia3
summary: "UI Extensibility Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_uiextensibilitytutorial.html
folder: omnia3
---


## 1. Introduction

After you have completed the [Beginner Tutorial](https://docs.numbersbelieve.com/omnia3_beginnertutorial.html), whose result is a functional order management application, OMNIA UI Extensibility Tutorial focus on the execution of behaviours on the user interface (cient browser).

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html), as this tutorial builds upon it.

## 3. UI Extensibility

1. Access Omnia homepage, select the tenant where you have developed the beginner tutorial, and go to the modeling area.

2. Through the left side menu, edit *PurchaseOrder* document by accessing the option ***Documents / PurchaseOrder***

3. Add a new attribute by clicking on button **Add new**. Set its *Name* as **IsDelivered**, *Type* as ***Primitive / Boolean***

    ![Modeler_Create_Attribute](/images/tutorials/beginner/Modeler-Create-Attribute.PNG)
    
4. Add a new attribute by clicking on button **Add new**. Set its *Name* as **DeliveryAddress**, *Type* as ***Primitive / Text***

    ![Modeler_Create_Attribute](/images/tutorials/beginner/Modeler-Create-Attribute.PNG)
    
5. Navigate to tab **User Interface Behaviours** click on top left button *Add new* to add a new behaviour, that will control  *DeliveryAddress* attribute visibility and value, depending on *IsDelivered*. Set its *Name* as **IsDeliveredChange**, *Behaviour Type* as **On change** and copy the following JavaScript code as the *Expression*

```JavaScript
    if(this.isDelivered === true){
        this._metadata.elements.deliveryAddress.isHidden = false;
    }else{
        this._metadata.elements.deliveryAddress.isHidden = true;
        this.deliveryAddress = "";
    
    }
    
```
