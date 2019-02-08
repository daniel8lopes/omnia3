---
title: GDPR (General Data Protection Regulation)
keywords: omnia3
summary: "OMNIA 3 GDPR Compliance"
sidebar: omnia3_sidebar
permalink: omnia3_gdpr.html
folder: omnia3
---

GDPR compliance has been a priority for OMNIA since it's release and below is the list of topics and measures that were developed in order to comply with its regulation.

## Sensitive Data

OMNIA allows for attribute data classification as "sensitive" that, when combined with the correctly configured user role, will allow the designated role to destroy it when/if necessary. This operation will replace the sensitive attribute values with meaningless data and destroy all its history.

Defining an attribute with Personal Identifiable Information (PII) as "sensitive" requires 2 steps:

 - Access the "Modeler" dashboard;
 - Find and access the attribute you need and activate the "Is sensitive?" option;
 
The role in question should have unique access to the "Destroy Sensitive Data" option, that's located at the bottom left corner of every document, under the menu "More Options". Using this feature guarantees the immediate destruction of the document's sensitive data, immediately and irreversibly.
 
## Encryption

Data encryption is recommended for GDPR compliance and, to that effect, two elements should to be configured to be encrypted from the start:

- Database(s);
- Attachments Storage (File Storage, AWS S3 or Azure Blob Storage);

By ensuring the encription of these elements you are ensuring GDPR compliance. 

## Logging

OMNIA logs every single API request and every single login attempt in its log files.

Access to these documents requires an enquiry to the system's administrator.

Logs can be accessed under _/var/logs/omnia_.

## Production Environment

It's recomended the configuration of Secure Sockets Layer (SSL) and Hyper Text Transfer Protocol Secure (HTTPS) at the moment of instalation of OMNIA's production environment. Also recommended is the use of [SSL Mode](https://www.npgsql.org/doc/connection-string-parameters.html) in PostgreSQL Database connection string.
