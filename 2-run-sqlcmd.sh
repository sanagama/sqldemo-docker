#!/bin/bash
#
# Run sqlcmd in host to execute T-SQL queries against SQL Server running in Docker
#

set -x

sqlcmd -S 127.0.0.1 -U sa -P Yukon900 -Q "SELECT @@version"

sqlcmd -S 127.0.0.1 -U sa -P Yukon900 -Q "SELECT name from sys.databases"

