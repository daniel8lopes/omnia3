---
title: How to use the API
keywords: omnia3, api
summary: "How to use the OMNIA Platform's API, using Swagger"
sidebar: omnia3_sidebar
permalink: omnia3_api_swagger.html
folder: omnia3
---

## 1. Introduction
In the third release of the OMNIA Platform, the API and its usage were two of our main concerns. This version provides a clear API that has all of the functionality and doesn't require the clients to implement logic.

The OMNIA API was implemented together respecting the OpenAPI specification. This means that, with the use of [Swagger](swagger.io), it is possible to:
- Generate API clients for whichever languages users want to use to develop software that requires our API;
- Generate documentation automatically, using Swagger UI.

## 2. Using Swagger UI

By accessing the Swagger UI page hosted at /api/docs/ (i.e. if your subscription of the platform is installed at omnia.example.com, omnia.example.com/api/docs/), you will see all of the possible options for interacting with the platform via the API.

We are actively working on enriching this API documentation with more and  better examples of the information to be sent in different scenarios.

Usage guidelines:
- Authorization is required to access almost every method in our API. Swagger UI provides an Authorize button that allows you to perform an authorization operation.
- To use a method, after selecting it / seeing the documentation, you can click the **Try it out** button and Swagger will open a series of fields you can type your information into, and an **Execute** button.
- All updates to existing resources use the HTTP PATCH method and implement the [JSONPatch](http://jsonpatch.com/) standard.

  In order to calculate the patch between the current state and the state you want it to be in, there are a number of tools, such as [JSON Patch Builder Online](https://json-patch-builder-online.github.io/).

## 3. Consuming the API with an API Client
It's possible to use whatever language you want to access the OMNIA API, allowing you to use the API the way you need to.

To do that, first you need to register an API client in the platform ([see here how](omnia3_management_introduction.html#4-api-clients)).

After the register, using the generated _Client ID_ and _Client Secret_, you are able to authenticate on the platform, through an OAuth 2.0 [Client Credentials](https://tools.ietf.org/html/rfc6749#section-1.3.4) flow, and to start using the API.