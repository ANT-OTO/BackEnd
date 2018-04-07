--select * from ScriptList


declare @ScriptListId int = 0

select @ScriptListId = a.Id
--select *
from ScriptList a 
where a.ListName = 'IU - CDCR-CCHCS' and a.Deleted = 0

if( @ScriptListId <= 0)
begin
	return
end

declare @TblCode as Table
(
	ItemValue nvarchar(64) NOT NULL,
	ItemContent nvarchar(1024) NOT NULL,
	AdditionalInfo1 nvarchar(max) NULL,
	AdditionalInfo2 nvarchar(max) NULL,
	AdditionalInfo3 nvarchar(max) NULL,
	AdditionalInfo4 nvarchar(max) NULL,
	SortOrder varchar(8) NOT NULL,
	Available bit NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 

delete @TblCode

insert into @TblCode	
(ItemValue, ItemContent, AdditionalInfo1, AdditionalInfo2, AdditionalInfo3, AdditionalInfo4, SortOrder, Available)
select distinct a.*
from (
	select '' as ItemValue, '' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
		'000' as SortOrder, 1 as Available
	UNION
	select '11561' as ItemValue, 'California City C orrectional Facility (CAC) - ID Code' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
		'001' as SortOrder, 1 as Available
	
	UNION select '11892' as ItemValue, 'Kern Valley State Prison (KVSP) - ID Code 11892' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14469' as ItemValue, 'Avenal State Prison (ASP) - ID Code 14469' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14471' as ItemValue, 'Calipatria State Prison (CAL) - ID Code 14471' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14472' as ItemValue, 'California Correctional Center (CCC) - ID Code 14472' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14473' as ItemValue, 'California Correctional Institution (CCI) - ID Code 14473' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14474' as ItemValue, 'Central California Women’s Facility (CCWF) - ID Code 14474' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14475' as ItemValue, 'California State Prison Centinela (CEN) - ID Code 14475' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14476' as ItemValue, 'California Institution for Men (CIM) - ID Code 14476' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14477' as ItemValue, 'California Institution for Women (CIW) - ID Code 14477' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14478' as ItemValue, 'California Men’s Colony (CMC) - ID Code 14478' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14479' as ItemValue, 'California Medical Facility (CMF) - ID Code 14479' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14480' as ItemValue, 'California State Prison Corcoran (COR) - ID Code 14480' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14481' as ItemValue, 'California Rehabilitation Center (CRC) - ID Code 14481' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14482' as ItemValue, 'Correctional Training Facility (CTF) - ID Code 14482' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14483' as ItemValue, 'Chucawalla Valley State Prison (CVSP) - ID Code 14483' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14484' as ItemValue, 'Deuel Vocational Institution (DVI) - ID Code 14484' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14485' as ItemValue, 'Folsom Sate Prison (FSP) - ID Code 14485' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14486' as ItemValue, 'High Desert State Prison (HDSP) - ID Code 14486' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14487' as ItemValue, 'Ironwood State Prison (ISP) - ID Code 14487' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14488' as ItemValue, 'California State Prison – Los Angeles County (LAC) - ID Code 14488' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14489' as ItemValue, 'Mule Creek State Prison (MCSP) - ID Code 14489' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14490' as ItemValue, 'North Kern State Prison (NKSP) - ID Code 14490' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14491' as ItemValue, 'Pelican Bay State Prison (PBSP) - ID Code 14491' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14492' as ItemValue, 'Pleasant Valley State Prison (PVSP) - ID Code 14492' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14493' as ItemValue, 'Richard J. Donovan Correctional Facility (RJD) - ID Code 14493' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14494' as ItemValue, 'California State Prison – Sacramento (SAC) - ID Code 14494' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14495' as ItemValue, 'California Substance Abuse Treatment Facility and State Prison, Corcoran (SATF) - ID Code 14495' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14496' as ItemValue, 'Sierra Conservation Center (SCC) - ID Code 14496' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14497' as ItemValue, 'California State Prison Solano  (SOL) - ID Code 14497' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14498' as ItemValue, 'San Quentin State Prison (SQ) - ID Code 14498' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14499' as ItemValue, 'Salinas Valley State Prison (SVSP) - ID Code 14499' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14500' as ItemValue, 'Valley State Prison for Women (VSPW) - ID Code 14500' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14501' as ItemValue, 'Wasco State Prison (WSP) - ID Code 14501' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
UNION select '14954' as ItemValue, 'California Health Care Facility (CHCF) - ID Code 14954' as ItemContent, null as AdditionalInfo1, null as AdditionalInfo2, null as AdditionalInfo3, null as AdditionalInfo4, 
                '001' as SortOrder, 1 as Available
	
	

	

) a 

insert into ScriptListDetail
(ScriptListId, ItemValue, ItemContent, AdditionalInfo1, AdditionalInfo2, AdditionalInfo3, AdditionalInfo4, SortOrder, Available)
select @ScriptListId, a.*
from @TblCode a left join  ScriptListDetail z on z.ScriptListId = @ScriptListId and z.ItemValue = a.ItemValue
where z.Id is null

update a
set a.ItemContent = b.ItemContent, a.AdditionalInfo1 = b.AdditionalInfo1, a.AdditionalInfo2 = b.AdditionalInfo2
	, a.AdditionalInfo3 = b.AdditionalInfo3, a.AdditionalInfo4 = b.AdditionalInfo4
	, a.SortOrder = b.SortOrder, a.Available = b.Available
	, a.LastUpdate = GETUTCDATE()
from ScriptListDetail a inner join  @TblCode b on a.ScriptListId = @ScriptListId and a.ItemValue = b.ItemValue

delete 
--select * from
ScriptListDetail where ScriptListId = @ScriptListId and ItemValue not in (select ItemValue from @TblCode)

select * from ScriptListDetail  where ScriptListId = @ScriptListId


------------------------------------- End  ------------------------------------- 

go

