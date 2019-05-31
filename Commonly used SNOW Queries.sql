/* This is the query used to get all devices that where scanned yesterday.
This query is setup to run in the SLM DB*/
select * from dbo.tblComputer 
where LastScanDate >= dateadd(day,datediff(day,1,GETDATE()),0)	
	
/* This is the query used for Server software True-Ups.
This query is setup to run in teh SLM DB*/
Select c.computerID, h.CoreCount, h.ProcessorCount, a.ApplicationName, a.Version, l.HostName from dbo.tblComputerHardware h 
inner join dbo.tblComputerApplications c
on h.ComputerID = c.ComputerID
inner join dbo.tblApplicationAlias a
on a.ApplicationID = c.ApplicationID
inner join dbo.tblComputer l
on c.ComputerID  = l.ComputerID
where ApplicationName like '%SQL%'

/* This is the query used to check the installed applications on a device 
This query is setup to run in the SLM DB*/

select h.name from dbo.tblComputer c 
inner join dbo.tblComputerApplications a
on c.ComputerID = a.ComputerID
inner join dbo.tblApplication h 
on h.ApplicationId = a.ApplicationID
where HostName = 'l19309'


/* this is a query that was used to find all software on a specific list of devices 
this Query uses two select statements that are intersected. Pay attention to the
inner joins and the aliases. This query is setup to run in the SLM DB */

Select l.HostName, x.Name, t.ProcessorCount, t.CoreCount  from dbo.tblComputer l 
inner join dbo.tblComputerApplications c
on l.ComputerID = c.ComputerID
inner join dbo.tblComputerHardware t
on t.Computerid = c.ComputerID
inner join dbo.tblApplication x
on c.ApplicationID = x.ApplicationID
Where l.HostName in ('L19962') 
intersect select l.HostName, x.Name, t.ProcessorCount, t.CoreCount from dbo.tblComputer l 
inner join dbo.tblComputerApplications c
on l.ComputerID = c.ComputerID
inner join dbo.tblComputerHardware t
on t.Computerid = c.ComputerID
inner join dbo.tblApplication x
on c.ApplicationID = x.ApplicationID
where x.Name like '%SQL%'


select * from [dbo].[tblUserInfo]
where OrgChecksum = -1914384426
select * from 


/* this query is used to get all of the user data and their primary devce for any application specified in the where clause. 
The query is setup to run in the Snow inventory DB*/

select l.FullName, l.Email, l.Location, c.HostName, x.Name, Comp.LicensesPurchased, Comp.ExpiredSubscriptionLicenses,comp.AvailableLicenses from SnowLicenseManager.dbo.tblUserInfo l 
inner join SnowLicenseManager.dbo.tblComputerUsers k on l.UserID = k.UserID
inner join SnowLicenseManager.dbo.tblComputer c on k.ComputerID = c.ComputerID
inner join SnowLicenseManager.dbo.tblComputerApplications a on c.ComputerID =a.ComputerID
inner join SnowLicenseManager.dbo.tblApplication x on a.ApplicationID = x.ApplicationID
join SnowLicenseManager.dbo.tblComplianceLicense comp on  x.ApplicationID = comp.ApplicationID
join SnowLicenseManager.[dbo].[tblComplianceMetric] Met on Comp.ApplicationID = Me
where x.Name like 'Adobe Creative Cloud%' and k.MostFrequent = 1 

/* this query is used to get the users primary device/devices 
The query is setup to run in the Snow inventory DB*/

select l.FullName, l.Email, l.Location, c.HostName from SnowLicenseManager.dbo.tblUserInfo l 
inner join SnowLicenseManager.dbo.tblComputerUsers k on l.UserID = k.UserID
inner join SnowLicenseManager.dbo.tblComputer c on k.ComputerID = c.ComputerID
where l.FullName like '%John Smith%' and k.MostFrequent = 1 


