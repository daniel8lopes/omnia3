---
title: OMNIA Multi System Connector Tutorial
keywords: omnia3
summary: "OMNIA Platform 3.0 ERP Primavera as Data Source"
sidebar: omnia3_sidebar
permalink: omnia3_multisystemconnectortutorial.html
folder: omnia3
---

## 1. Introduction

Based on a simple Employee management scenario, this tutorial shows a real scenario of how easily OMNIA can use information from an external data source, using the Omnia connector to access data located on-premises. 

This tutorial is an advanced implementation of the [data sources tutorial](omnia3_datasourcetutorial.html) in order to understand how data sources work, please read [this section of the documentation](omnia3_modeler_datasources.html).

On the CRUD Operations tutorial area, we are going to evaluate how to interact with an external data source, by reading and manipulating its data.

As our custom data source, we are going to use the [PRIMAVERA ERP V9](https://pt.primaverabss.com).

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant ([click here to see how](omnia3_tenantcreation.html)), and are logged in as a user with modeling privileges to this tenant. You must also have access to the management area to manage the connectors.

This tutorial also requires an access to [Primavera ERP](https://pt.primaverabss.com), on version 9. 

## 3. Create a new connector

1. Start by accessing the management area, by clicking the option "Go to Tenants management".

2. Through the left side menu, create a new connector by accessing the option ***Connectors / Add new***. Set its Code and Name as "AnalogSoundConnector"

3. Select the connector, and a modal with connector data should be shown.

4. Now we are going to grant the connector access privileges for the tenant. Access the option ***Security / Roles***, and select Administration role for the tenant (the tenant code with prefix "Administration")

5. Click the button ***Add new*** to grant the connector user access to the tenant. The user can be retrieved on step 3, property "Client Username"

6. Now use these configurations to configure a connector in the machine with the Primavera ERP, following the [installation guide](omnia3_connector_install.html) and [configuration guide](omnia3_connector_configuration.html).

7. Start the configured connector.

## 4. CRUD operations

1. Access Omnia homepage, select the tenant where you are going to model and you will be redirected to the modeling area.

2. Through the left side menu, create a new Agent by accessing the option ***Agents / Add new*** on the top right side. Set *"Company"* as its with name.

3. Through the left side menu, create a new Generic Entity by accessing the option ***Generic Entities / Add new***. Set *"Artist"* as its with name.
    
4. Through the left side menu, create a new Data Source by accessing the option ***Data Sources / Add new*** on the top right side. Set its Name as "*Primavera*", Behaviour Runtime as *"Internal"* and Data Access Runtime as *"External"*.

5. Create a new Agent with name *"Supplier"*, and set it as using the external data source *"Primavera"* that you created earlier.

6. On Agent *"Supplier"*, navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll
    3. Interop.IGcpBS900.dll
    4. Interop.GcpBE900.dll

7. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

    Copy and paste the following code (*Remember to **change** the **```"USER"```** and **```"PASS"```** fields to your actual username and password.*):

    ```C#
	try
	{
		List<IDictionary<string, object>> suppliersList = new List<IDictionary<string, object>>();

		ErpBS bsERP = new ErpBS();
		
		bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");
		StdBELista queryResults = bsERP.Consulta($"SELECT Suppliers.SuppliersCount, Fornecedor, Nome from Fornecedores CROSS JOIN (SELECT Count(*) AS SuppliersCount FROM Fornecedores) AS Suppliers ORDER BY Fornecedor ASC OFFSET {(page - 1)*pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY");

		int numberOfRecords = Convert.ToInt32(queryResults.Valor("SuppliersCount").ToString());
		while (!queryResults.NoFim())
		{

			var supplier = new Dictionary<string, object>() {
				{ "_code", queryResults.Valor("Fornecedor").ToString()},
				{ "_name", queryResults.Valor("Nome").ToString()}
			};

			suppliersList.Add(supplier);
			queryResults.Seguinte();
		}
                
		return (numberOfRecords, suppliersList);
	}
	catch (Exception e)
	{
		Console.WriteLine(e.Message);
		throw;
	}
    ```

8. Create a new Data Behaviour for the operation “Read”, so that data is retrieved when an Employee is edited on OMNIA.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
	SupplierDto dto = new SupplierDto();
	ErpBS bsERP = new ErpBS();
    
	bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");
	StdBELista queryResults = bsERP.Consulta($"SELECT Fornecedor, Nome FROM Fornecedores WHERE Fornecedor = '{identifier}'");
    
	if (!queryResults.Vazia())
	{
     		dto._code = queryResults.Valor("Fornecedor").ToString();
     		dto._name = queryResults.Valor("Nome").ToString();
	}
	else
	{
     		throw new Exception($"Could not retrieve Supplier with code '{identifier}'");
	}
	bsERP.FechaEmpresaTrabalho();
	return dto;
    ```
    
9. Create a new Data Behaviour for the operation “Create”, so that a new Supplier is created on Primavera ERP when it is created on OMNIA.

    Copy and paste the following code (Remember to change the "USER" and "PASS" fields to your actual username and password.):

    ```C#
	ErpBS bsERP = new ErpBS();

	bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");

	GcpBEFornecedor fornecedor = new GcpBEFornecedor();
	fornecedor.set_Fornecedor(dto._code);
	fornecedor.set_Nome(dto._name);
	fornecedor.set_Moeda("EUR");
	fornecedor.set_NumContribuinte("999999990");
            
	bsERP.Comercial.Fornecedores.Actualiza(fornecedor);

	bsERP.FechaEmpresaTrabalho();
	return dto;
    ```
    
10. Create a new Resource with name *"Product"*, and set it as using the external data source *"Primavera"* that you created earlier.

11. On Resource *"Product"*, navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll

12. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

    Copy and paste the following code (*Remember to **change** the **```"USER"```** and **```"PASS"```** fields to your actual username and password.*):

    ```C#
	try
        {
        	List<IDictionary<string, object>> productsList = new List<IDictionary<string, object>>();

        	ErpBS bsERP = new ErpBS();
		bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");
        	StdBELista queryResults = bsERP.Consulta($"SELECT Products.ProductsCount, Artigo, Descricao from Artigo CROSS JOIN (SELECT Count(*) AS ProductsCount FROM Artigo) AS Products ORDER BY Artigo ASC OFFSET {(page - 1)*pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY");

        	int numberOfRecords = Convert.ToInt32(queryResults.Valor("ProductsCount").ToString());
        	while (!queryResults.NoFim())
        	{
			var product = new Dictionary<string, object>() {
				{ "_code", queryResults.Valor("Artigo").ToString()},
        			{ "_name", queryResults.Valor("Descricao").ToString()}
        		};

        		productsList.Add(product);
        		queryResults.Seguinte();
        	}
                
        	return (numberOfRecords, productsList);
        }
        catch (Exception e)
        {
		Console.WriteLine(e.Message);
        	throw;
        }
    ```

13. Through the left side menu, create a new Commitment by accessing the option ***Commitments / Add new***. Set its Name as "*GoodsPurchaseRequest*", *"Provider"* as the resource to be exchanged, *"Supplier"* as provider agent and *"Company"* as receiver agent. Before saving, check option *"Uses a custom data source?"*, and select *"Primavera"* as Data Source.

14. Edit the commitment "*GoodsPurchaseRequest*", and create the following attributes:

    - Artist
    - Primavera
    - AlbumMBid

15. On Document "*GoodsPurchaseRequest*", navigate to tab *"[Entity References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for .NET assembly System.Net.Http

16. Navigate to tab *"[Entity Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define an *"Action"* behaviour to be executed when attribute _resource is changed. This behaviour will be used to retrieve from LastFM API a unique album identifier.

    Copy and paste the following code (*Remember to **change** the **```"API_KEY"```** field to your actual LastFM API Key.*):

    ```C#
	if (!string.IsNullOrEmpty(newValue) && !string.IsNullOrEmpty(this.Artist))
	{
		var client = new HttpClient();
		string apiEndpoint = $"http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=API_KEY&artist={this.Artist}&album={newValue}&format=json";
		var requestResult = client.GetAsync(apiEndpoint).GetAwaiter().GetResult();
		string responseBody = requestResult.Content.ReadAsStringAsync().Result;
		if (!requestResult.IsSuccessStatusCode)
			throw new Exception("Error on retrieving album: " + responseBody);
		var response = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseBody);
		var albumData = JsonConvert.DeserializeObject<Dictionary<string, object>>(response["album"].ToString());

		this._dto.AlbumMBid = albumData["mbid"].ToString();
	}
    ```

17. Still on commitment "*GoodsPurchaseRequest*", edit attributes _resource and _provider and set attribute Primavera as the Data Source

18. Through the left side menu, create a new Document by accessing the option ***Documents / Add new***. Set its Name as "*PurchaseOrder*". Before saving, check option *"Uses a custom data source?"*, and select *"Primavera"* as Data Source.

19. On Document "*PurchaseOrder*", add the following attributes:

    - Primavera
    - Supplier
    - OrderLines

20. Navigate to tab *"[Entity Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed *"After Change"*. This behaviour will be used to set default values on Commitment instances.

    Copy and paste the following code:

    ```C#
	OrderLines.ForEach(line => {
 		line._provider = Supplier;
		line._receiver = "AnalogSound";
		line.Primavera = Primavera;
	});
    ```

21. On Document "*PurchaseOrder*", navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll
    3. Interop.IGcpBS900.dll
    4. Interop.GcpBE900.dll

22. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

    Copy and paste the following code (*Remember to **change** the **```"USER"```** and **```"PASS"```** fields to your actual username and password.*):

    ```C#
	try
	{
		List<IDictionary<string, object>> ordersList = new List<IDictionary<string, object>>();

		ErpBS bsERP = new ErpBS();
		bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");

		Interop.StdBE900.StdBELista queryResults = bsERP.Consulta($"SELECT Orders.OrderCount, Serie, TipoDoc, NumDoc, Entidade, CONVERT (NVARCHAR(10), DataDoc, 120) AS DataDoc from CabecCompras  CROSS JOIN (SELECT Count(*) AS OrderCount FROM CabecCompras where TipoDoc = 'ECF') AS Orders where TipoDoc = 'ECF' ORDER BY DataDoc DESC OFFSET {(page - 1)*pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY");

		int numberOfRecords = Convert.ToInt32(queryResults.Valor("OrderCount").ToString());
		while (!queryResults.NoFim())
		{

			var order = new Dictionary<string, object>() {
				{ "_code", queryResults.Valor("Serie").ToString()+"/"+queryResults.Valor("NumDoc").ToString()},
				{ "_serie", queryResults.Valor("Serie").ToString()},
				{ "_number", queryResults.Valor("NumDoc").ToString()},
				{ "_date", queryResults.Valor("DataDoc").ToString()}
			};

			ordersList.Add(order);
			queryResults.Seguinte();
		}
                
		bsERP.FechaEmpresaTrabalho();
		return (numberOfRecords, ordersList);
	}
	catch (Exception e)
	{
		Console.WriteLine(e.Message);
		throw;
	}
    ```
23. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"Create"*. This behaviour will be used to create new instances on ERP everytime a new PurchaseOrder is created on Omnia.

    Copy and paste the following code (*Remember to **change** the **```"USER"```** and **```"PASS"```** fields to your actual username and password.*):

    ```C#
	try
	{
		List<IDictionary<string, object>> ordersList = new List<IDictionary<string, object>>();

		ErpBS bsERP = new ErpBS();
		bsERP.AbreEmpresaTrabalho(EnumTipoPlataforma.tpEmpresarial, "DEMO", "USER", "PASS");

		Interop.StdBE900.StdBELista queryResults = bsERP.Consulta($"SELECT Orders.OrderCount, Serie, TipoDoc, NumDoc, Entidade, CONVERT (NVARCHAR(10), DataDoc, 120) AS DataDoc from CabecCompras  CROSS JOIN (SELECT Count(*) AS OrderCount FROM CabecCompras where TipoDoc = 'ECF') AS Orders where TipoDoc = 'ECF' ORDER BY DataDoc DESC OFFSET {(page - 1)*pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY");

		int numberOfRecords = Convert.ToInt32(queryResults.Valor("OrderCount").ToString());
		while (!queryResults.NoFim())
		{

			var order = new Dictionary<string, object>() {
				{ "_code", queryResults.Valor("Serie").ToString()+"/"+queryResults.Valor("NumDoc").ToString()},
				{ "_serie", queryResults.Valor("Serie").ToString()},
				{ "_number", queryResults.Valor("NumDoc").ToString()},
				{ "_date", queryResults.Valor("DataDoc").ToString()}
			};

			ordersList.Add(order);
			queryResults.Seguinte();
		}
                
		bsERP.FechaEmpresaTrabalho();
		return (numberOfRecords, ordersList);
	}
	catch (Exception e)
	{
		Console.WriteLine(e.Message);
		throw;
	}
    ```

24. Reorganize the PurchaseOrder attributes (by accessing the option ***User Interface***)

25. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

26. Go to the Application area.

27. Create a new instance of the Primavera data source, with code *"DEMO"* and with the Code of the Connector that you have created.

28. On left side menu, navigate to *Configurations / Supplier*, identify the Primavera data source instance (DEMO) and check that the list is filled with data retrieved from Primavera.

29. Now you can try to List and Create new Products directly on your on-premise system

30. Finally, try to create new Purchase Orders on Omnia, and check that they are integrated on your on-premise system 
