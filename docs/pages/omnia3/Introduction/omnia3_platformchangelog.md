---
title: Platform Changelog
keywords: omnia3
summary: "OMNIA Platform Changelog"
sidebar: omnia3_sidebar
permalink: omnia3_platformchangelog.html
folder: omnia3
---

Visit our [Downloads](/omnia3_downloads.html#platform) page to get the latest version.

## [3.0.83](#3.0.83)
Release Date: 2018-11-08

### Implemented enhancements:

 - Support visibility based on screen sizes
  
   - Mobile
   - Tablet
   - Desktop
   - Widescreen
 
 - Add context to menu when a folder is open
 - Horizontal Scrollable lists
 
 ## [3.0.85](#3.0.85)
Release Date: 2018-11-30

### Implemented enhancements:

 - Calendar element
 - UI Behaviours - Support async behaviours
 - Access to translations in UI behaviours
 
### Bugs:
 
 - Don't allow to write in the readonly numeric fields
 - Review list columns to don't break when the text is too big
 
## [3.0.89](#3.0.89)
Release Date: 2018-12-10

### Implemented enhancements:

 - Calendar: Add "See all" option when there are too many entries in one day
 - Send list filters & sort conditions to external data sources data behaviours
 
### Bugs:
 
 - Translate column names in List filters
 - Exceptions throwed at Before Save in UI Behaviours aren't visible
 - Review list columns to don't break when the text is too big
 
## [3.0.90](#3.0.90)
Release Date: 2018-12-10

### Bugs:
 
 - 403 Error when using the lookup in a Calendar modal
 
## [3.0.93](#3.0.93)
Release Date: 2018-12-12

### Bugs:
 
 - Trigger C# On Change behaviours on edit
 
### Implemented enhancements:

 - Allow to control the state of form footer options (using UI extensibility)
 - Allow to pass list and list parameters to queries in UI Shared Reference attributes
 - Date elements: Add a button to clear the value in optional fields

## [3.0.113](#3.0.113)
Release Date: 2018-12-26

### Bugs:
 
 - Fix sidebar translations in top entries
 - Allow to select the WebComponent mapping when the list is inside a container
 - Don't block save button while the temporary is being updated
 
### Implemented enhancements:

 - Allow to redirect to application address using JS extensibility
 - Allow to control the List "Add new" button state
 - Allow to call a function when the calendar form opens
 - Render Calendars in Dashboards

## [3.0.119](#3.0.119)
Release Date: 2019-01-02
 
### Implemented enhancements:

 - Display cell text in a list cell on mouse over
 - Preserve user session when the application reboot
 - Apply a default filter in lists to only return active entities, when the inactive column exists in the query result
 - Auto-select the role when there is only one
 
 
## [3.0.153](#3.0.153)
Release Date: 2019-01-29

### Bugs:
 - UI Reference Selector - use camel case getting selected data
 - Limit the User's access to all areas based on permissions
 - WebComponents in Lists: set the width property in the list header
 - Review grid column's size calculation to fix multi-browser issues

### Implemented enhancements:

 - Commulative Roles
 - Add JSON editor to ApplicationMenu
 - Users with only 1 tenant: Don't show the tenant selection page
 - Allow to define sensitive data attributes
 - WebApp: Allow to export list data as CSV in application area
 - Access to user language in Behaviours
 - Grids: Show full text on mouse over (only to text fields)
 - Remove version from behaviours Namespace
 - Generate a .csproj per data source and allow to download it

 
## [3.0.170](#3.0.170)
Release Date: 2019-02-04

### Bugs:
 - Review grid column's size calculation to fix multi-browser issues
 - Validation: Ignore non-required attributes without value
 - Users removal from Authorization Roles
 - Queries - Filter non-text columns

### Implemented enhancements:

 - Generate a .csproj per data source and allow to download it
 - Move behaviour compilation output to bin folder
 - Lists: Allow to use ranges to filter numeric and date columns
 - TopBar: Restrict the available space to show the tenant name
 - Scheduler: block days that are out of the start and finish dates
 - Call onDataRangeChange event when the date range or the view is changed
 - Add Week calendar
 - 
