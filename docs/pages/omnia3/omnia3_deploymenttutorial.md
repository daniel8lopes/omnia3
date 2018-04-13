---
title: OMNIA 3.0 Deployment Tutorial
keywords: omnia3
summary: "Deploying OMNIA Platform 3.0"
sidebar: omnia3_sidebar
permalink: omnia3_deploymenttutorial.html
folder: omnia3
---


## 1. Prerequisites

1.1. Create a Linux server (Ubuntu 16.04 LTS recommended), with an **omnia** user, who will be responsible for running the application.

1.2. Install .NET Core 2.0.3 SDK, by following the official Microsoft [instructions](https://docs.microsoft.com/en-us/dotnet/core/linux-prerequisites?tabs=netcore2x).

    _(NOTE: 
     This guide installs **the whole SDK** - for production, thus it is recommended to install the runtime only; however, the runtime installation on linux has no official guide, and requires extracting a .tar.gz and installing from there. )_

1.3. Install the ASP.NET Core Runtime Store, **only if you have installed the runtime** instead of the SDK:
```
for version in '2.0.0' '2.0.3'; do \
        curl -o /tmp/runtimestore.tar.gz https://dist.asp.net/runtimestore/$version/linux-x64/aspnetcore.runtimestore.tar.gz \
        && export DOTNET_HOME=$(dirname $(readlink $(which dotnet))) \
        && tar -x -C $DOTNET_HOME -f /tmp/runtimestore.tar.gz \
        && rm /tmp/runtimestore.tar.gz; \
    done
```

- Install NGINX on the server, by running the following commmand:

```
    sudo apt-get install nginx
```

## 2. Configuring the database
2.1. Create a database with name **omnia**, with any username & password you want, in a PostgreSQL database server (version 9.6 supported)

2.2. Run the setup script in ./setup/database/dbschema.sql to set it up.

## 3. Installation 

### 3.1. Copying the binaries & installer
- Copy all from the publish folder over to the target machine**, to the /home/omnia/ folder (create it if it doesn't exist)

### 3.2. Installing the services

```
sudo cp /home/omnia/setup/services/*.service /etc/systemd/system/
sudo systemctl daemon-reload
cd /etc/systemd/system/
sudo systemctl enable omnia omnia-*
```

- Services will be launched in the following ports:

    49900: web api
    49901: tenant
    49902: identity
    49999-50***: behaviours

- You wouldn't need to expose any of these ports, as all communication with the exterior will go through NGINX.

## 4. Configuring the services

### 4.1. Configure OMNIA

- Edit /home/omnia/app/config/omnia.json, and fill in the following parameters:
    - ConnectionStrings > PostgreSQL: insert your database connection string;
    - Hostname: Platform hostname;
    - SMTP: A valid SMTP server configuration;
    

### 4.2. Configure NGINX
```
sudo cp /home/omnia/setup/nginx/* /etc/nginx/ -r
```


### 4.3. Configure HTTPS

In the nginx site configuration (`/etc/nginx/sites-enabled/default`), there is a series of commented out lines. 

If you have a valid SSL certificate, follow the instructions in the file to set the site to run in HTTPS-by-default mode, which is **the only supported mode** of running the platform.

If you don't have a certificate, you can choose one of these alternatives:
- If you have a valid DNS name for your site that you own (i.e., not aws, azure, etc.) , you can set up **Let's Encrypt** for a free certificate. See [this DigitalOcean tutorial](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04) for an example of setting it up.

- If you don't, you can use the platform via HTTP. This is **not supported** though, but it can be a solution for a quick trial.

Running the platform without an SSL certificate in production is **not supported,** as well not GDPR-compliant.

## 5. Starting the site
- When you run `sudo systemctl start omnia` (don't do it yet, though, finish the configuring process), services will be launched.

- Do `sudo service nginx reload` and verify if the platform is running when accessing the site, the swagger api (site/api/docs), and logging in.

- Ensure that ports 80 and 443 (for https traffic) are opened on firewall. Without these ports available, the site will not be available.

## 6. First login
On a web browser, access the site with the defined url.

You will be asked for a platform administrator email. Insert a valid email address and a message will be sent with the instructions for the first login.

Site must contain a valid SMTP configuration, so that emails are sent correctly.
