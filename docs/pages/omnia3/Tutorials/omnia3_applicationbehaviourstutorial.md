---
title: OMNIA Application Behaviours Tutorial
keywords: omnia3
summary: "Application Behaviours on OMNIA Low-Code Platform"
sidebar: omnia3_sidebar
permalink: omnia3_applicationbehaviourstutorial.html
folder: omnia3
---

## 1. Introduction

After you have completed the [Beginner Tutorial](https://docs.omnialowcode.com/omnia3_beginnertutorial.html), whose result is a functional order management application, OMNIA Application Behaviours Tutorial focus on the execution of behaviours on external data sources.

As our custom data source, we are going to use the [PRIMAVERA ERP V9](https://pt.primaverabss.com).


## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant, and are logged in as a user with modeling privileges to this tenant.

It is necessary to have completed the steps in the  [Beginner tutorial](https://docs.omnialowcode.com/omnia3_beginnertutorial.html), as this tutorial builds upon it.

A connector and an access to [Primavera ERP](https://pt.primaverabss.com), on version 10 are also required to complete this tutorial.

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

4. Through the left side menu, navigate to PurchaseOrder Document, by accessing the option ***Documents / PurchaseOrder***. Add a new attribute by clicking on option **Add new / Reference** and setting its *Name* and *Type* as *Primavera* and *Data Source / Primavera*, respectively.

5. Through the left side menu, create a new application behaviour by accessing the option ***Extensibility / Application Behaviours / Add new***. Set its *Name* as "IntegratePurchaseOrder", "Primavera" as *Data Source* and "External" as *Execution Location*.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
    PurchaseOrderDto dto = JsonConvert.DeserializeObject<PurchaseOrderDto>(JsonConvert.SerializeObject(args["purchaseOrder"]));

    ErpBS bsERP = new ErpBS();

    Dictionary<string, object> arguments = new Dictionary<string, object>();
    arguments.Add("Company", dto.Primavera);

    IDictionary<string, object> erpBs = PrimaveraApplicationBehaviours.Primavera_OpenCompany(arguments, context);

    if (!erpBs.ContainsKey("ErpBS"))
	    throw new Exception("Can't open the ERP company");

    bsERP = (ErpBS)erpBs["ErpBS"];

    GcpBEDocumentoCompra purchaseOrder = new GcpBEDocumentoCompra();

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

    string integrationMessage = $"Integrado documento {purchaseOrder.get_Tipodoc()} {purchaseOrder.get_Serie()}/{purchaseOrder.get_NumDoc()}";

    bsERP.FechaEmpresaTrabalho();

    return new Dictionary<string, object>() { { "Message", integrationMessage } };

    ```

6. Edit Application Behaviour *IntegratePurchaseOrder* and click on button *Edit Namespaces* to add the following namespaces:

    - Interop.ErpBS900
    - Interop.StdBE900
    - Interop.GcpBE900
    - Interop.IGcpBS900

    ![Modeler ApplicationBehaviour Add_Namespace](/images/tutorials/applicationbehaviours/Modeler-IntegratePurchaseOrder-Add-Namespace.PNG)

7. Through the left side menu, navigate to PurchaseOrder Document, by accessing the option ***Documents / PurchaseOrder / Entity Behaviours***. Add a new entity behaviour by clicking on ***Add new / After Save***, setting its name as "IntegrateOnSave".

    Copy and paste the following code (Remember to change the "CONNECTORUSER" field to your actual connector user.):

    ```C#   
    if (_Context.Operation.Action != Action.EntityCreate)
    return await Task.FromResult(AfterSaveMessage.Empty);
    
    var context = new ConnectorContext(this._Context);
    var client = new ConnectorClient(context);

    Dictionary<string, object> requestData = new Dictionary<string, object>();
    requestData.Add("purchaseOrder", this.ToDto());

    var message = new ConnectorMessage(MessageType.Application, "IntegratePurchaseOrder", OperationType.Execute);
    message.Data = new Dictionary<string, object>(){
    {"dataSource", this.Primavera}, {"dataSourceType", "Primavera"}, {"data", requestData}
    };

    var httpClient = this._Context.CreateApplicationHttpClient();
    var primaveraResult = httpClient.GetAsync($"Primavera/Default/{this.Primavera}").Result;

    if (!primaveraResult.IsSuccessStatusCode)
	    throw new Exception($"Could not retrieve Primavera '{this.Primavera}' data");

    PrimaveraDto primavera = primaveraResult.Content.ReadAsAsync<PrimaveraDto>().Result;
    var connectorUsername = primavera.ConnectorUsername;

    if (string.IsNullOrEmpty(connectorUsername))
        throw new Exception("Before accessing the connector, please define it's username (email) on the After Save behaviour.");

    var response = await client.ExecuteRequestAsync(connectorUsername, message);

    if (!response.IsSuccess)
        throw new Exception(response.Message);

    var responseData = JsonConvert.DeserializeObject<Dictionary<string, object>>(JsonConvert.SerializeObject(response.Data["data"]));

    string returnMessage = string.Empty;
    if(responseData.ContainsKey("message"))
        returnMessage = responseData["message"].ToString();

    return await Task.FromResult(new AfterSaveMessage(returnMessage, AfterSaveMessageType.Success));
    ```

8. Build & Deploy the model.

9. Go to application area, and create new instance of Primavera. The Connector value is the code defined earlier when the connector was created

10. Create a new Purchase Order.

11. After creating the purchase order, click on the first option of the top bar, and check the operation result is now visible.

    ![Modeler view Notifications](/images/tutorials/applicationbehaviours/Application-NotificationCenter.PNG)
