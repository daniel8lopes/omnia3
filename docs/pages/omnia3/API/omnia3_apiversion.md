---
title: Versioning
keywords: omnia3
summary: "OMNIA Platform Versioning"
sidebar: omnia3_sidebar
permalink: omnia3_apiversion.html
folder: omnia3
---

## 1. Introduction

OMNIA Platform has a version control system, that not only controls the versions of platform releases, but also the version of the developed models.

The version can be consulted through the OMNIA API.

## 2. How to view current version through API?

### Platform Version

The Platform version is incremented in new releases, and it can be retrieved by making an HTTP GET request to the following service:

```
/api/v1/system
```

The response will be a JSON object with the following structure:

```
{
  "version": "1.0.96"
}
```

### Model Version

Model version is incremented in each build, and can be retrieved by making an HTTP GET request to the following service:

```
/Model/builds?filter=Active&page=1&pageSize=1
```

The response will be a JSON object with the following structure:

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

