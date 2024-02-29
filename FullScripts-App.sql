use HR_Management_db
go
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    CREATE TABLE [LeaveTypes] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [DefaultDay] int NOT NULL,
        [DateCreated] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedDate] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_LeaveTypes] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    CREATE TABLE [LeaveAllocations] (
        [Id] int NOT NULL IDENTITY,
        [NumberOfDays] int NOT NULL,
        [LeaveTypeId] int NOT NULL,
        [Priod] int NOT NULL,
        [DateCreated] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedDate] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_LeaveAllocations] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_LeaveAllocations_LeaveTypes_LeaveTypeId] FOREIGN KEY ([LeaveTypeId]) REFERENCES [LeaveTypes] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    CREATE TABLE [LeaveRequests] (
        [Id] int NOT NULL IDENTITY,
        [StartDate] datetime2 NOT NULL,
        [EndDate] datetime2 NOT NULL,
        [LeaveTypeId] int NOT NULL,
        [DateRequested] datetime2 NOT NULL,
        [RequestComments] nvarchar(max) NOT NULL,
        [DateActioned] datetime2 NULL,
        [Approved] bit NULL,
        [Cancelled] bit NOT NULL,
        [DateCreated] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NOT NULL,
        [LastModifiedDate] datetime2 NOT NULL,
        [LastModifiedBy] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_LeaveRequests] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_LeaveRequests_LeaveTypes_LeaveTypeId] FOREIGN KEY ([LeaveTypeId]) REFERENCES [LeaveTypes] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    CREATE INDEX [IX_LeaveAllocations_LeaveTypeId] ON [LeaveAllocations] ([LeaveTypeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    CREATE INDEX [IX_LeaveRequests_LeaveTypeId] ON [LeaveRequests] ([LeaveTypeId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230416063118_InitDatabse')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230416063118_InitDatabse', N'6.0.19');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveTypes]') AND [c].[name] = N'LastModifiedBy');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [LeaveTypes] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [LeaveTypes] ALTER COLUMN [LastModifiedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveTypes]') AND [c].[name] = N'CreatedBy');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [LeaveTypes] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [LeaveTypes] ALTER COLUMN [CreatedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveRequests]') AND [c].[name] = N'LastModifiedBy');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [LeaveRequests] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [LeaveRequests] ALTER COLUMN [LastModifiedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveRequests]') AND [c].[name] = N'CreatedBy');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [LeaveRequests] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [LeaveRequests] ALTER COLUMN [CreatedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveAllocations]') AND [c].[name] = N'LastModifiedBy');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [LeaveAllocations] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [LeaveAllocations] ALTER COLUMN [LastModifiedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[LeaveAllocations]') AND [c].[name] = N'CreatedBy');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [LeaveAllocations] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [LeaveAllocations] ALTER COLUMN [CreatedBy] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedBy', N'DateCreated', N'DefaultDay', N'LastModifiedBy', N'LastModifiedDate', N'Name') AND [object_id] = OBJECT_ID(N'[LeaveTypes]'))
        SET IDENTITY_INSERT [LeaveTypes] ON;
    EXEC(N'INSERT INTO [LeaveTypes] ([Id], [CreatedBy], [DateCreated], [DefaultDay], [LastModifiedBy], [LastModifiedDate], [Name])
    VALUES (1, NULL, ''0001-01-01T00:00:00.0000000'', 10, NULL, ''0001-01-01T00:00:00.0000000'', N''Vacation'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedBy', N'DateCreated', N'DefaultDay', N'LastModifiedBy', N'LastModifiedDate', N'Name') AND [object_id] = OBJECT_ID(N'[LeaveTypes]'))
        SET IDENTITY_INSERT [LeaveTypes] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedBy', N'DateCreated', N'DefaultDay', N'LastModifiedBy', N'LastModifiedDate', N'Name') AND [object_id] = OBJECT_ID(N'[LeaveTypes]'))
        SET IDENTITY_INSERT [LeaveTypes] ON;
    EXEC(N'INSERT INTO [LeaveTypes] ([Id], [CreatedBy], [DateCreated], [DefaultDay], [LastModifiedBy], [LastModifiedDate], [Name])
    VALUES (2, NULL, ''0001-01-01T00:00:00.0000000'', 12, NULL, ''0001-01-01T00:00:00.0000000'', N''Sick'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'CreatedBy', N'DateCreated', N'DefaultDay', N'LastModifiedBy', N'LastModifiedDate', N'Name') AND [object_id] = OBJECT_ID(N'[LeaveTypes]'))
        SET IDENTITY_INSERT [LeaveTypes] OFF;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20230429045259_seedingDataEf')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230429045259_seedingDataEf', N'6.0.19');
END;
GO

COMMIT;
GO

