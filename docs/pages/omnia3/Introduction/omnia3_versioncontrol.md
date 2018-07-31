---
title: Version Control
keywords: omnia3
summary: "OMNIA Platform Version Control"
sidebar: omnia3_sidebar
permalink: omnia3_versioncontrol.html
folder: omnia3
---

## 1. Introduction

OMNIA Platform has a version control system, that not only controls the versions of platform releases, but also the version of the developed models.

The version can be consulted through OMNIA API and User Interface.

## 2. Platform Version

The platform version is incremented on each new release, and it can be checked on both API and User Interface:

### User Interface

Platform version is available, after logging in, on top navbar middle button option *About*.

### API

Platform version can be retrieved, by making an HTTP GET request to the following service:

```
/api/v1/system
```

The response will be a Json with the following structure:

```
{
  "version": "1.0.96"
}
```

## 2. Model Version

The model version is incremented on each new build, and it can be checked on both API and User Interface:

### User Interface

Model version is available, on Modeling and Application areas, by clicking on top navbar middle button option *About*. The Tenant version will be shown along with the Platform version.

### API

Latest model version can be retrieved, by making an HTTP GET request to the following service:

```
/Model/builds?filter=Active&page=1&pageSize=1
```

The response will be a Json with the following structure:

```
[
  {
    "date": "2018-07-01T14:00:01.9814483Z",
    "buildVersion": "1.0.8",
    "code": "1.0.8",
    "state": "Successful"
  }
]
```
