USE [Nizy]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetAllKPITable]
@Status CHAR(1) = NULL -- Y = Active, N = Inactive, NULL = All
AS
BEGIN
SET NOCOUNT ON;


SELECT 
    [KPI ID],
    [KPI or Standalone Metric],
    [KPI Name],
    [KPI Short Description],
    [KPI Impact],
    [Numerator Description],
    [Denominator Description],
    [Unit],
    [Datasource],
    [OrderWithinSecton],
    [Active],
    [FLAG_DIVISINAL],
    [FLAG_VENDOR],
    [FLAG_ENGAGEMENTID],
    [FLAG_CONTRACTID],
    [FLAG_COSTCENTRE],
    [FLAG_DEUBALvl4],
    [FLAG_HRID],
    [FLAG_REQUESTID]
FROM dbo.KPITable
WHERE @Status IS NULL OR Active = @Status
END;

GO
