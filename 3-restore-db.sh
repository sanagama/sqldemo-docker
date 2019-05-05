#!/bin/bash
#
# Create sample databases (Adventureworks, BollywoodDB & WideWorldImporters) in SQL Server in Docker
#
set -x

# Restore a BAK file from the host into SQL running in Docker
# The BAK file is in the 'backups' directory whicb is mounted into Docker container

docker exec -it sqldocker /backups/restore-wwi.sh
