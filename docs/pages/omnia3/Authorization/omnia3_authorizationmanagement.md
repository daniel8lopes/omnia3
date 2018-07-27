---
title: Authorization Management
keywords: omnia3
summary: "Authorization"
sidebar: omnia3_sidebar
permalink: omnia3_authorizationmanagement.html
folder: omnia3
---

## 1. Introduction

On OMNIA Platform, authorization is managed on two distinct areas, one for the Platform and another for the tenant.

### 1.1 Platform

In the platform authorization area (option **Management / Security**) you can manage all *Policies* and *Roles*. 

#### Roles

By default, Omnia Platform suggests one role, named *Administration*. This role has, by default, associated the user identified on platform setup as the *Platform Administrator* and it cannot be removed. Other users can be added to this *Role*.

Additionally, when a tenant is created, two new roles are automatically added:

- Administration[TenantCode]
- Users[TenantCode]

If needed, new Roles can be created to grant a set of policies to a group of users

#### Policies

Aside from the policies for each tenant a polic with code PlatformPolicy is created. This policy let you manage the permissions for the platform management.

### 1.2 Tenant


