#!/bin/bash
#

#!/bin/bash
# Run sqlcmd on the host to execute the generated SQL script against 'sqldocker-dev'
#

set -x

# Execute T-SQL statement on 'sqldocker-dev' at port 1432
# Note that AdventureworksLT is not present
sqlcmd -S 127.0.0.1,1432 -U sa -P Yukon900 -Q "SELECT name from sys.databases"

# Execute generated script on 'sqldocker-dev' at port 1432
# This creates the AdventureworksLT database schema and inserts data
sqlcmd -S 127.0.0.1,1432 -U sa -P Yukon900 -i ./create-customer.sql

# Execute T-SQL starement on 'sqldocker-dev' at port 1432
# Note that AdventureworksLT has been created
sqlcmd -S 127.0.0.1,1432 -U sa -P Yukon900 -Q "SELECT name from sys.databases"

# Shrink the data in the dev image 'sqldocker-dev'
# There are smarter ways to do this, but we'll just DELETE rows for this demo
sqlcmd -S 127.0.0.1,1432 -U sa -P Yukon900 -d AdventureworksLT \
    -Q "DELETE FROM [SalesLT].[Customer] WHERE CustomerID > 10"

