---
title: OMNIA Application Behaviours Tutorial
keywords: omnia3
summary: "Application Behaviours on OMNIA Platform 3.0"
sidebar: omnia3_sidebar
permalink: omnia3_applicationbehaviourstutorial.html
folder: omnia3
---

## 1. Introduction

After you have completed the [Beginner Tutorial](https://docs.numbersbelieve.com/omnia3_beginnertutorial.html), whose result is a functional order management application, OMNIA Application Behaviours Tutorial focus on the execution of behaviours on external data sources.

As our custom data source, we are going to use the [PRIMAVERA ERP V9](https://pt.primaverabss.com).


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html), as this tutorial builds upon it.

A connector and an access to [Primavera ERP](https://pt.primaverabss.com), on version 9 are also required to complete this tutorial.

## 3. Application Behaviours

1. Access Omnia homepage, select the tenant where you have developed the beginner tutorial, and go to the modeling area.

2. Through the left side menu, create a new Data Source by accessing the option ***Data Sources / Add new*** on the top right side. Set its Name as "*Primavera*", Behaviour Runtime and Data Access Runtime as *"External"*.

    ![Modeler create DataSource](/images/tutorials/applicationbehaviours/Modeler-Create-DataSource.PNG)
    
3. Still on Data Source *Primavera*, navigate to tab **Behaviour Dependencies**, and define a reference for Primavera assemblies

    - Interop.ErpBS900.dll
    - Interop.StdBE900.dll
    - Interop.GcpBE900.dll
    - Interop.IGcpBS900.dll
    
    ![Modeler add Reference](/images/tutorials/applicationbehaviours/Modeler-Primavera-Add-Dependency.PNG)

4. Through the left side menu, create a new Agent by accessing the option ***Agents / Add new*** on the top right side. Set its Name as *Employee* and Data Source as *Primavera*.

5. Navigate to tab “Data Behaviours“, and define a behaviour to be executed on “ReadList”. This behaviour will be used for Query and List requests for this entity.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
    List<IDictionary<string, object>> employeesList = new List<IDictionary<string, object>>();
    ErpBS qbsERP = new ErpBS();
    
    qbsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, Context.Operation.DataSource, "USER", "PASS");
    
    StdBELista queryResults = qbsERP.Consulta($"SELECT Employees.EmployeesCount, Codigo, Nome FROM Funcionarios CROSS JOIN (SELECT Count(*) AS EmployeesCount FROM  Funcionarios) AS Employees ORDER BY Codigo OFFSET {(page - 1)*pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY");
    
    int numberOfRecords = Convert.ToInt32(queryResults.Valor("EmployeesCount").ToString());
    while (!queryResults.NoFim())
    {    
        var employee = new Dictionary<string, object>() {
            { "_code", queryResults.Valor("Codigo").ToString()},
            { "_name", queryResults.Valor("Nome").ToString()}
        };
    
        employeesList.Add(employee);
        queryResults.Seguinte();
    }
    
    qbsERP.FechaEmpresaTrabalho();
    
    return (numberOfRecords, employeesList);
    ```

6. Through the left side menu, navigate to PurchaseOrder Document, by accessing the option ***Documents / PurchaseOrder***. Add the following attributes by clicking on button Add new. 

    - Primavera (Type: Data source / Primavera)
    - Employee (Type: Agent / Employee; Data Source attribute: Primavera)

7. Through the left side menu, create a new application behaviour by accessing the option ***Extensibility / Application Behaviours / Add new***. Set its *Name* as "IntegratePurchaseOrder", and "Primavera" as *Data Source*.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
    PurchaseOrderDto dto = JsonConvert.DeserializeObject<PurchaseOrderDto>(JsonConvert.SerializeObject(args));
    Interop.ErpBS900.ErpBS bsERP = new Interop.ErpBS900.ErpBS();

    bsERP.AbreEmpresaTrabalho(Interop.StdBE900.EnumTipoPlataforma.tpEmpresarial, dto.Primavera, "USER", "PASS");

    Interop.GcpBE900.GcpBEDocumentoCompra purchaseOrder = new Interop.GcpBE900.GcpBEDocumentoCompra();

    purchaseOrder.set_Tipodoc("ECF");
    purchaseOrder.set_Serie("A");
    purchaseOrder.set_TipoEntidade("F");
    purchaseOrder.set_Entidade(dto.Supplier);
    purchaseOrder.set_NumDocExterno("0");
    purchaseOrder.set_Observacoes($"Documento gerado no portal OMNIA: Pedido de Encomenda {dto._serie} / {dto._number}");
    purchaseOrder.set_DataCarga(DateTime.Now.ToShortDateString());
    purchaseOrder.set_DataDescarga(DateTime.Now.ToShortDateString());

    bsERP.Comercial.Compras.PreencheDadosRelacionados(purchaseOrder);
    foreach (var line in dto.OrderLines)
    {
        bsERP.Comercial.Compras.AdicionaLinha(purchaseOrder, line._resource, Convert.ToDouble(line._quantity));
    }

    bsERP.Comercial.Compras.Actualiza(purchaseOrder);

    bsERP.FechaEmpresaTrabalho();

    return new Dictionary<string, object>();
    ```

8. Through the left side menu, navigate to PurchaseOrder Document, by accessing the option ***Documents / PurchaseOrder / Entity Behaviours***. Add a new entity behaviour by clicking on ***Add new / After Save***, setting its name as "IntegrateOnSave".

    Copy and paste the following code (Remember to change the "CONNECTORUSER" field to your actual connector user.):

    ```C#   
    var context = new ConnectorContext(Context.Tenant.Code, Context.Tenant.EnvironmentCode, Context.Tenant.Version, Context.Authentication.AccessToken, Context.Tenant.BaseEndpoint);
    
    var client = new ConnectorClient(context);
    
    var message = new ConnectorMessage(MessageType.Application, "IntegratePurchaseOrder", OperationType.Execute);
    message.Data = new Dictionary<string, object>(){
        {"dataSource", _dto.Primavera}, {"dataSourceType", "Primavera"}, {"data", _dto}
    };
    
    var connectorUsername = "CONNECTORUSER";
    
    var response = await client.ExecuteAsync(connectorUsername, message);
    if (response.ContainsKey("isSuccess") && (bool)response["isSuccess"] == false)
        throw new Exception(response.ContainsKey("message") ? response["message"].ToString() : "An error has occurred");

    return await Task.FromResult(new AfterSaveMessage("Integration with Primavera successful.", AfterSaveMessageType.Success));
    ```

9. Build the model.

10. Go to application area, and create new instance of Primavera. The Connector value is the code defined earlier when the connector was created

11. Create a new Purchase Order.

12. After creating the purchase order, click on the first option of the top bar, and check the operation result is now visible.

    ![Modeler view Notifications](/images/tutorials/applicationbehaviours/Application-NotificationCenter.PNG)
