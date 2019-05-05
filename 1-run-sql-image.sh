#!/bin/bash
#
# Run SQL Server in Docker
# The directory ./backups is mounted as /backups in the Docker container
#
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run  --name 'sqldocker' --cap-add SYS_PTRACE \
            -v  $DIR/backups:/backups \
            -e 'ACCEPT_EULA=Y' \
            -e 'MSSQL_SA_PASSWORD=Yukon900' \
            -e 'MSSQL_PID=Developer' \
            -p 1433:1433 \
            -d mcr.microsoft.com/mssql/server:2017-latest

