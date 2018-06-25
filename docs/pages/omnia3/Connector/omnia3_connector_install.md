---
title: OMNIA 3.0 Connector Install Guide
keywords: omnia3
summary: "OMNIA 3.0 Connector Install Guide"
sidebar: omnia3_sidebar
permalink: omnia3_connector_install.html
folder: omnia3
---
## 1. Installing the connector

After you have downloaded the connector (see our [Downloads page](omnia3_downloads.html)) and extracted it, you can either run it directly or install it as a Windows service.

To run it, you should just do `Omnia.Connector.Windows.exe` (in cmd) or `./Omnia.Connector.Windows.exe` (in powershell) from the folder you extracted it to. In order to install the Windows service, add `install` to the end of that line. To uninstall it, add `uninstall`. In both of these scenarios, ensure you are running as an administrator.

## 2. Configuring the connector

A configuration file (_**config.json**_) is distributed together with the connector that you must fill in in order to use it. 

- **Endpoint**: The URL of the OMNIA subscription you want the connector to be used on.
- **Client**
    - **ID**: Client ID of the connector configuration you registered on the platform.
    - **Secret**: Client Secret of the connector configuration you registered on the platform.