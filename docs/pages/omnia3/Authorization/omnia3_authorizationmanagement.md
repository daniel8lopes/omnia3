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

By default, Omnia Platform has one role, named *Administration*. This role has, by default, associated the user identified on platform setup as the *Platform Administrator* and it cannot be removed. Other users can be added to this *Role*.

Additionally, when a tenant is created, two new roles are automatically added:

- Administration[TenantCode]
- Users[TenantCode]

If needed, new Roles can be created to grant a set of policies to a group of users

#### Policies

By default, Omnia Platform has one policy, named *PlatformSecurity*, that controls the access to the following security permissions:

- Tenants
- Users
- Roles
- Privileges

*Administration* role has access granted to all this permissions.

When a new tenant is created, a new policy is created, whose name is the tenant code with the Tenant suffix (e.g. TenantAnalogSound). These policies only have one possible permission (ALL- grants access to the tenant), and multiple roles can be added to it.

Since policies and permissions are limited and managed by the platform, they cannot be created manually or removed.


### 1.2 Tenant


