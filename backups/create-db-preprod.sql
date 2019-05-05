/*
 * Here's what a DBA might do to create a pre-prod environment for a dev and mask sensitive data:
 *
 * 1. Restore the database to SQL in Docker
 * 2. Mask sensitive columns (EmailAddress and Phone)
 * 3. Create a new user ('scripter') with UNMASK permission
 * 4. EmailAddress and Phone will be masked for user 'scripter'
 */

-- Dump database names
SELECT NAME FROM SYS.DATABASES
GO

-- 1. Restore database into Docker
-- The .BAK file is a directory outside the Docker image that is mounted as a volume
RESTORE FILELISTONLY FROM DISK = '/backups/AdventureworksLT.bak'
GO

RESTORE DATABASE AdventureworksLT
FROM DISK = '/backups/AdventureworksLT.bak'
 WITH
    MOVE 'AdventureworksLT_Data' TO '/var/opt/mssql/data/AdventureworksLT_Data.mdf',
    MOVE 'AdventureworksLT_Log' TO '/var/opt/mssql/data/AdventureworksLT_Log.ldf'
GO

-- Dump database names
SELECT NAME FROM SYS.DATABASES
GO

-- 2. Create a new user called 'scripter' 
USE [master]
CREATE LOGIN scripter WITH PASSWORD = 'Yukon900'
GO

USE [AdventureworksLT]
GO

CREATE USER scripter FOR LOGIN scripter
GO

ALTER ROLE [db_datareader] ADD MEMBER [scripter]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [scripter]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [scripter]
GO
GRANT VIEW DEFINITION TO [scripter]
GO
print(N'Successfully created user: scripter without UNMASK permission on AdventureworksLT database');

-- EmailAddress and Phone are currently visible to everyone
SELECT * FROM [SalesLT].[Customer]
GO

-- Apply Dynamic Data Masking: mask e-mail with a built-in function
ALTER TABLE [SalesLT].[Customer] ALTER COLUMN [EmailAddress]
ADD MASKED WITH (FUNCTION = 'email()');
GO

-- Apply Dynamic Data Masking: only show first 2 digits of the phone number
ALTER TABLE [SalesLT].[Customer] ALTER COLUMN [Phone]
ADD MASKED WITH (FUNCTION = 'partial(2, "XXXXXXXX", 0)');
GO

-- EmailAddress and Phone are masked for user 'scripter'
EXECUTE AS USER = 'scripter';
SELECT * FROM [SalesLT].[Customer];
REVERT;
GO
