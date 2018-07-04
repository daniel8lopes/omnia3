---
title: OMNIA Multi System Connector Tutorial
keywords: omnia3
summary: "OMNIA Platform 3.0 Multi System Connector Tutorial"
sidebar: omnia3_sidebar
permalink: omnia3_multisystemconnectortutorial.html
folder: omnia3
---

## 1. Introduction

Based on a Purchase Orders management scenario, this tutorial shows a real scenario of how easily OMNIA can combine information from multiple external data sources, using the Omnia connector to access data located on-premises. 

This tutorial is an advanced implementation of the [data sources tutorial](omnia3_datasourcetutorial.html) in order to understand how data sources work, please read [this section of the documentation](omnia3_modeler_datasources.html).

On the Modeling Scenario tutorial area, we are going to evaluate how to develop this solution from scratch, and how we can combine information present on Omnia, an on-premises ERP, and an API.

As our custom data source, we are going to use the [PRIMAVERA ERP V9](https://pt.primaverabss.com).

## 2. Prerequisites

This tutorial assumes that you have created a OMNIA tenant ([click here to see how](omnia3_tenantcreation.html)), and are logged in as a user with modeling privileges to this tenant. You must also have access to the management area to manage the connectors.

This tutorial also requires an access to [Primavera ERP](https://pt.primaverabss.com), on version 9. 

## 3. Create a new connector

1. Start by accessing the management area, by clicking the option "Go to Tenants management".

2. Through the left side menu, create a new connector by accessing the option ***Connectors / Add new***. Set its Code and Name as "AnalogSoundConnector"

3. On connectors list, select the previously created connector, and a modal with its data should be shown.

4. Now we are going to grant the connector access privileges for the tenant. Access the option ***Security / Roles***, and select Administration role for the tenant (composed by the tenant code with prefix "Administration". E.g. AdministrationDemoTenant)

5. Click the button ***Add new*** to grant the connector user access to the tenant. The user can be retrieved on step 3, property "Client Username"

6. Now use these configurations to configure a connector in the machine with the Primavera ERP, following the [installation guide](omnia3_connector_install.html) and [configuration guide](omnia3_connector_configuration.html).

7. Start the configured connector.

## 4. Modeling Entities

1. Access Omnia homepage, select the tenant where you are going to model and you will be redirected to the modeling area.

2. Through the left side menu, create a new Agent by accessing the option ***Agents / Add new*** on the top right side. Set *"Company"* as its with name.

    ![Modeler create Agent_Company](/images/tutorials/multisystemconnector/Create-Agent-Company.PNG)

3. Through the left side menu, create a new Generic Entity by accessing the option ***Generic Entities / Add new***. Set *"Artist"* as its with name.

    ![Modeler create GenericEntity_Artist](/images/tutorials/multisystemconnector/Create-GenericEntity-Artist.PNG)

4. Perform a new Build (by accessing the option ***Versioning / Builds / Create new***).

5. Go to application area and create a new Company (by accessing the option ***Configurations / Company / Create new***)

6. Create a new Artist
    
7. Go to modeling area, and through the left side menu, create a new Data Source by accessing the option ***Data Sources / Add new*** on the top right side. Set its Name as "*Primavera*", Behaviour Runtime as *"Internal"* and Data Access Runtime as *"External"*. Check the flag "Will be executed in a connector?"

    ![Modeler create DataSource_Primavera](/images/tutorials/multisystemconnector/Create-DataSource-Primavera.PNG)

8. Create a new Agent with name *"Supplier"*, and set it as using the external data source *"Primavera"* that you created earlier.

    ![Modeler create Agent_Supplier](/images/tutorials/multisystemconnector/Create-Agent-Supplier.png)

9. On Agent *"Supplier"*, navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll
    3. Interop.IGcpBS900.dll
    4. Interop.GcpBE900.dll

10. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

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

		bsERP.FechaEmpresaTrabalho();
		
		return (numberOfRecords, suppliersList);
	}
	catch (Exception e)
	{
		Console.WriteLine(e.Message);
		throw;
	}
    ```

11. Create a new Data Behaviour for the operation “Read”, so that data is retrieved when an Employee is edited on OMNIA.

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
    
12. Create a new Data Behaviour for the operation “Create”, so that a new Supplier is created on Primavera ERP when it is created on OMNIA.

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
  
13. Perform a new build

14. Go to application area, and create new instance of Primavera. The Connector value is the code defined earlier when the connector was created

    ![Modeler create Primavera_Demo](/images/tutorials/multisystemconnector/Create-Primavera-Demo.PNG)

15. List Suppliers. If prompted, select the Primavera instance and check that list is filled with ERP database Suppliers

16. Create a new Supplier, and check that it is integrated on ERP Primavera

17. Go to modeling area. Create a new Resource with name *"Product"*, and set it as using the external data source *"Primavera"* that you created earlier.

    ![Modeler create Resource_Product](/images/tutorials/multisystemconnector/Create-Resource-Product.PNG)

18. On Resource *"Product"*, navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll

19. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

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
		bsERP.FechaEmpresaTrabalho();
		return (numberOfRecords, productsList);
	}
	catch (Exception e)
	{
		Console.WriteLine(e.Message);
		throw;
	}
    ```

20. Perform a new build

21. Go to application area, and check that ERP Products can now be listed on Omnia

## 5. Modeling Purchase Order

1. Go to modeling area and, through the left side menu, create a new Commitment by accessing the option ***Commitments / Add new***. 

    Set its Name as "*GoodsPurchaseRequest*", *"Product"* as the resource to be exchanged, *"Supplier"* as provider agent and *"Company"* as receiver agent. Before saving, check option *"Uses a custom data source?"*, and select *"Primavera"* as Data Source.

    ![Modeler create Commitment_GoodsPurchaseRequest](/images/tutorials/multisystemconnector/Create-Commitment-GoodsPurchaseRequest.PNG)

2. Edit the commitment "*GoodsPurchaseRequest*", and create the following attributes:

    - Artist (Type: Generic entity, Artist)
    - Primavera (Type: Data source, Primavera)
    - AlbumMBid (Type: Primitive, Text)

3. Still on commitment "*GoodsPurchaseRequest*", edit attributes *"_resource"* and *"_provider"* and set attribute Primavera as the Data Source

    ![Modeler edit Attribute_Resource](/images/tutorials/multisystemconnector/Edit-Attribute-Resource.PNG)

4. Through the left side menu, create a new Document by accessing the option ***Documents / Add new***. Set its Name as "*PurchaseOrder*". Before saving, check option *"Uses a custom data source?"*, and select *"Primavera"* as Data Source.

5. On Document "*PurchaseOrder*", add the following attributes:

    - Primavera
    - Supplier
    - OrderLines

6. On Document "*PurchaseOrder*", navigate to tab *"[Data References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for Primavera assemblies:

    1. Interop.StdBE900.dll
    2. Interop.ErpBS900.dll
    3. Interop.IGcpBS900.dll
    4. Interop.GcpBE900.dll

7. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"ReadList"*. This behaviour will be used for Query and List requests for this entity.

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
8. Navigate to tab *"[Data Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed on *"Create"*. This behaviour will be used to create new instances on ERP everytime a new PurchaseOrder is created on Omnia.

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

9. Reorganize the PurchaseOrder attributes (by accessing the option ***User Interface***)

10. Perform a new Build

11. Go to the Application area.

12. Demo

13. Navigate to tab *"[Entity Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define a behaviour to be executed *"After Change"*. This behaviour will be used to set default values on Commitment instances.

    Copy and paste the following code:

    ```C#
	OrderLines.ForEach(line => {
		line._provider = Supplier;
		line._receiver = "AnalogSound";
		line.Primavera = Primavera;
	});
    ```

14. Reorganize UI

## 5. Communicate with an external API

1. On Commitment "*GoodsPurchaseRequest*", navigate to tab *"[Entity References](https://docs.numbersbelieve.com/omnia3_modeler_references.html)"*, and define a reference for .NET assembly System.Net.Http

2. Navigate to tab *"[Entity Behaviours](https://docs.numbersbelieve.com/omnia3_modeler_datasources.html)"*, and define an *"Action"* behaviour to be executed when attribute _resource is changed. This behaviour will be used to retrieve from LastFM API a unique album identifier.

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
