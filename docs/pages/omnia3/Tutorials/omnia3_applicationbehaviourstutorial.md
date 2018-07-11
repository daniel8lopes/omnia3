---
title: OMNIA Application Behaviours Tutorial
keywords: omnia3
summary: "Application Behaviours on OMNIA Platform 3.0"
sidebar: omnia3_sidebar
permalink: omnia3_applicationbehaviourstutorial.html
folder: omnia3
---

## 1. Introduction

After you have completed the [Beginner Tutorial](https://docs.numbersbelieve.com/omnia3_beginnertutorial.html), whose result is a functional order management application, OMNIA Application Behaviours Tutorial focus on the execution of behaviours on external applications.


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Beginner tutorial](http://docs.numbersbelieve.com/omnia3_beginnertutorial.html), as this tutorial builds upon it.

A connector is also required to complete this tutorial.

## 3. Application Behaviours

1. Access Omnia homepage, select the tenant where you have developed the beginner tutorial, and go to the modeling area.

2. Through the left side menu, create a new Data Source by accessing the option ***Data Sources / Add new*** on the top right side. Set its Name as "*Primavera*", Behaviour Runtime and Data Access Runtime as *"External"*.

    ![Modeler create DataSource](/images/tutorials/primaveraconnector/add-new-datasource.png)

3. Through the left side menu, create a new Agent Data Source by accessing the option ***Agents / Add new*** on the top right side. Set its Name as "*Employee*" and Data Source as Primavera.

4. On Agent *Employee*, navigate to tab **Data References**, and define a reference for Primavera assemblies

    - Interop.ErpBS900.dll
    - Interop.StdBE900.dll
    - Interop.GcpBE900.dll
    - Interop.IGcpBS900.dll

5. Navigate to tab “Data Behaviours“, and define a behaviour to be executed on “ReadList”. This behaviour will be used for Query and List requests for this entity.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
    List<IDictionary<string, object>> employeesList = new List<IDictionary<string, object>>();
    ErpBS qbsERP = new ErpBS();
    
    qbsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");
    
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

6. Navigate to tab Attributes, and add new one by clicking on button Add new. Set its Name as Primavera, Type as Data source / Primavera, and as required by checking option Is required?.

7. Navigate to tab Attributes, and add new one by clicking on button Add new. Set its Name as Employee, Type as Agent / Employee, and set Primavera as data source attribute.

8. Through the left side menu, create a new application behaviour by accessing the option ***Extensibility / Application Behaviours / Add new***. Set its name as "IntegratePurchaseOrder", and Primavera as Data Source.

    Copy and paste the following code:

    ```C#
    PurchaseOrderDto dto = JsonConvert.DeserializeObject<PurchaseOrderDto>(JsonConvert.SerializeObject(args));
    Interop.ErpBS900.ErpBS bsERP = new Interop.ErpBS900.ErpBS();

    bsERP.AbreEmpresaTrabalho(Interop.StdBE900.EnumTipoPlataforma.tpEmpresarial, dto.Primavera, "NB", "NB_2012#");

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

9. Through the left side menu, navigate to PurchaseOrder document, by accessing the option ***Documents / PurchaseOrder / Entity Behaviours***. Add a new entity behaviour by clicking on ***Add new / After Save***, setting its name as "IntegrateOnSave".

    Copy and paste the following code:

    ```C#   
    var context = new ConnectorContext(Context.Tenant.Code, Context.Tenant.EnvironmentCode, Context.Tenant.Version, Context.Authentication.AccessToken, Context.Tenant.BaseEndpoint);
    var client = new ConnectorClient(context);
    var message = new ConnectorMessage(MessageType.Application, "IntegratePurchaseOrder", OperationType.Execute);
    message.Data = new Dictionary<string, object>(){
        {"dataSource", _dto.Primavera}, {"dataSourceType", "Primavera"}, {"data", _dto}
    };
    var connectorUsername = "09adbc5f6f23489da6e189d7de33a824@connectors";
    var response = await client.ExecuteAsync(connectorUsername, message);
    if (response.ContainsKey("isSuccess") && (bool)response["isSuccess"] == false)
        throw new Exception(response.ContainsKey("message") ? response["message"].ToString() : "An error has occurred");
    ```

10. Build the model

11. Create a new Purchase Order