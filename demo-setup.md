# SQL Server in Docker - Demo Setup

## What's here?

This page has the ***demo setup instructions*** for the ***SQL Server in Docker*** demos presented to the STRAPS team in Salesforce Marketing Cloud, May 2019.

Jump to:
- [Main README.md](https://github.com/sanagama/sqldemo-docker)
- [Demo Script](https://github.com/sanagama/sqldemo-docker/blob/master/demo-script.md)


## Prerequisites

This demo was done on a MacBook. Modify accordingly you're using Linux or Windows to run this demo.

These are the prerequisites to run this demo:
- A MacBook (or other computer)
- Azure Data Studio
- Docker

## Demo Setup

Perform these steps ***once*** on your computer:

### Setup MacBook

1. Install *Python* and *pip* on your MacBook. Here's a great guide for macOS: <https://hackercodex.com/guide/python-development-environment-on-mac-osx>
1. Download and install Azure Data Studio for MacOS from here: <https://docs.microsoft.com/en-us/sql/azure-data-studio/download>
1. Install the *mssql-scripter* commands line tool as described here: <https://github.com/Microsoft/sql-xplat-cli/blob/dev/doc/installation_guide.md>
1. Install *mssql-tools* for macOS as described here: <https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools#macos>
1. Install the *mssql-cli* command line tool as described here: <https://docs.microsoft.com/en-us/sql/tools/mssql-cli>
1. Browse to <https://github.com/sanagama/sqldemo-docker>
1. Click ```Clone or Download``` then click ```Download ZIP```
1. Save the ZIP file to your ```HOME``` directory
1. Extract the zip file to ```~/sql2017-docker```

### Setup Docker

Download Docker for your operating system and complete the installation:
- [Docker for Mac](https://www.docker.com/docker-mac)
- [Docker for Windows](https://www.docker.com/docker-windows)

Increase Docker memory to 4 GB as documented here:
<https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker#requirements>


### Congrats! You have completed the one-time demo setup!
