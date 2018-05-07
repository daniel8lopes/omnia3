---
title: Authorization
keywords: omnia3
summary: "Authorization"
sidebar: omnia3_sidebar
permalink: omnia3_authorization.html
folder: omnia3
---


## 1. Introduction

The **OMNIA Platform** authorization uses a policy-based model. This policy-based model consists of three main concepts: policies, permissions and roles.

## 2. Policies, permissions and roles

- A policy is composed by one or more permissions
- A permission is a function/area to protect and has a collection of roles used to evaluate users permissions
- A role is an easy way to group users of an application based on what they can or cannot do

![The authorization policy-based model](images\authz_model.jpg)

## 3. Authorization management in the **OMNIA Platform**

The authorization management is divided in two main areas, the platform authorization and the [tenant](omnia3_management_introduction.html) authorization.

### 3.1 Platform

In the platform authorization area you can manage the automatically created policies and roles besides the policies and roles created by you for the platform global security.

For each tenant in the platform a policy with code Administration[TenantCode] was created. Each policy contains at least the automatically create role with the code Administration.

Aside from the policies for each tenant a polic with code PlatformPolicy is created. This policy let you manage the permissions for the platform management.

### 3.2 Tenant

