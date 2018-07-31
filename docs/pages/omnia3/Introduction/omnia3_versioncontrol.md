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
