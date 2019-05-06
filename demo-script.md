# SQL Server in Docker - Demo Script

## What's here?

This page has the ***demo scripts*** and ***talking points*** for the ***SQL Server in Docker*** demos presented to the STRAPS team in Salesforce Marketing Cloud, May 2019.

Jump to:
- [README.md](https://github.com/sanagama/sqldemo-docker)


## Demo Script
There are 4 demos below. I recommend you perform these demos in sequence if possible.

Jump to:
1. [Run SQL in Docker](#1-run-sql-in-docker)
1. [Restore a Database backup](#2-restore-a-database-backup)
1. [Create pre-production environment](#3-create-pre-production-environment)
1. [Create dev environment](#4-create-dev-environment)
1. [Share container](#5-share-container)

### SQL in Docker Intro

(**Talking Points**)
- Let me talk a bit about running SQL in Docker.
- Why would you do this?
- Ultimately, this is about empowering you to deliver continuous value to your customers in an agile manner
- Developers working with Continuous Integration/Continuous Deployment (CI/CD) pipelines can now include SQL Server containers as a component of their apps for an integrated build, test, and deploy experience.
- You can use this approach for local development and CI/CD automation (e.g. [Travis CI](https://travis-ci.org)) to run Database integratiin tests and Database unit tests on the fly.

Running SQL Server in Docker gives you 4 major benefits:
1. Dramatically simplifies development, testing, and deployment of applications (you can package app + dependencies, including SQL Server, into a portable environment)
1. Greatly reduces variability and increases the speed of every iteration in the CI/CD pipeline
1. Enforces a consistent dev/test environment for your team, since they can share the same state of an application in their container
1. Helps you automate large-scale testing of containerized apps + SQL Server with high-intensity container deployments with managed container services.
    - e.g. Kubernetes, Docker Swarm, or other orchestration systems.
    - Spin up on demand, execute tests, spin down when finished.

Let's start!

### 1. Run SQL in Docker

Launch a ```Terminal``` window and type the following:
```
cd ~/sqldemo-docker
ls -al
cat ./1-run-sql-image.sh
./1-run-sql-image.sh
```

(**Talking Points**)
- This pulls down the SQL Server image from Docker Hub and runs it

(**Talking Points**)
- The SQL command line tools you know & love (sqlcmd and bcp) are now available on macOS
- Let's run sqlcmd omn the host and execute some queries against SQL running in Docker
- Note that sqlcmd and bcp are also included in the Docker image, so you can run them from there too

Type the following in the ```Terminal``` window:
```
ls -al
cat ./2-run-sqlcmd.sh
./2-run-sqlcmd.sh
```

(**Talking Points**)
- That was a basic demo of SQL Server in Docker

### 2. Restore a database backup

(**Talking Points**)
- Let's try restoring a backup of the ```Wide World Importers``` database to SQL running in Docker
- The BAK file we want to restore is in the ```backups``` directory
- Recall I mounted a volume ```backups```  on my MacBook to a directory inside Docker when I ran SQL in Docker


Type the following in the ```Terminal``` window:
```
ls -al
cat ./3-restore-db.sh
./3-restore-db.sh
```

### 3. Create pre-production environment

(**Talking Points**)
- Let's do something more interesting
- Assume that the SQL Server we just ran in Docker represents your pre-production environment.
- Imagine you're an app dev and you're told to create a simple app to edit data in the ```Customer``` table in the ```Adventureworks``` database.
- Your DBA gave you ```Adventureworks.BAK``` to restore in pre-production.
- However, there are two requirements:
    1. the security folks in your team don't want you to see sensitive production data.
    1. you don't need the full database; you only the data in the ```Customer``` table to write your app.

(**Talking Points**)
How can we make this happen?
Well, first let's restore ```Adventureworks.BAK``` to pre-production.

Let's fire up Azure Data Studio and connect to SQL in Docker:
- Launch Azure Data Studio
- Connect to ```localhost```
- Open file ```~/sqldemo-docker/backups/create-db-preprod.sql```

Talk to each statement as you execute it.

(**Talking Points**)
- Great, we've now have a pre-production environment where we've masked sensitive data
- Next problem: this is the full database but you only needs the ```Customer``` table.
- Let's see how we can address that

### 4. Create dev environment

(**Talking Points**)
- My ```sqldocker``` Docker image is still running
- Let's create a new image for the developer called ```sqldocker-dev```

Type the following in the ```Terminal``` window:
```
ls -al
cat ./4-run-dev-image.sh
./4-run-dev-image.sh
```

(**Talking Points**)
- We've released a new Python-based open source command line tool called ```mssql-scripter```
- We can use it to generate scripts to create database schema - think of this as a multi-OS CLI equivalent of the *Generate Scripts Wizard* in SSMS.
- Recall that the the dev only needs the data from the ```Customer``` table
- Let's use it to connect to ```sqldocker``` and generate a DDL + DML script only for the ```Customer``` table
- Recall that we had masked sensitive data in the ```sqldocker``` container

Type the following in the ```Terminal``` window:
```
ls -al
cat ./5-create-script-dev-db.sh
./5-create-script-dev-db.sh
```

(**Talking Points**)
- The script has been generated in file ```create-customer.sql```
- Note that the scripts has the schema + data only for the ```Customer``` table
- Note that sensitive data is masked because we ran the command as the ```scripter``` user
- Let's execute the generated script against ```sqldocker-dev``` to create the database schema and also insert data.
- New requirement: the dev only wants about 10 rows from the ```Customer``` table

Type the following in the ```Terminal``` window:
```
ls -al
cat ./6-run-script-dev-db.sh
./6-run-script-dev-db.sh
```

(**Talking Points**)
- Cool, all done
- Let's take a look at the dev image

Switch back to Azure Data Studio.
- Connect to ```localhost,1432```
- Open a new query window and type ```SELECT * FROM [SalesLT].[Customer]```

(**Talking Points**)
- Our dev environment is ready!
- Now, how can we share these environments with the rest of the team?

### 5. Share container

(**Talking Points**)
- We can easily push these images to Docker hub for others to use
- This way, the image can be pulled into a testing/QA  environment to test with a larger, more representative dataset - and the image includes SQL Server + the database

(**Talking Points**)
- That was a quick example of using SQL in Docker for dev/test scenarios
- I showed you how to get SQL in Docker up & running, restore a backup in a pre-prod, mask data and then create a dev environment with a subset of the data.
- Next, I showed you how to share these Docker images via docker hub
- You can easily integrate these steps with CI/CD pipelines and augment with automated database unit testing processes.
