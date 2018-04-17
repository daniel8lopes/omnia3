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

- A policy is composed by one or more permissions
- A permission is a function/area to protect and has a collection of roles used to evaluate users permissions
- A role is an easy way to group users of an application based on what they can or cannot do

## 2. Why policy-based?

Roles are essentially flat concepts and even a simple hierarchy  can increase significantly as the number of overrules grows. 

Another benefit of a policy-based approach is the shift into what to protect instead of who can access some functionality. We center our authorization to protect functionalities and only then do we assign access to roles.


