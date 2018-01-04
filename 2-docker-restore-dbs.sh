#!/bin/bash

#
# Create sample databases (Adventureworks, BollywoodDB & WideWorldImporters) in SQL Server 2017 in Docker
#
set -x

# run a script inside the Docker container to restore database backups from the mounted /backups directory
docker exec -it sqldocker /backups/restore-db.sh
