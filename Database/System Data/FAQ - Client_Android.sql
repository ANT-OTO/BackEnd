--select * from FAQ

declare @AppName varchar(32) = 'Client_Android'

declare @TblCode as Table
(
	[ItemKey] [varchar](16) NOT NULL,

	[Content] [nvarchar](max) NOT NULL,			
	
	[IsLink] [bit] NOT NULL,
	
	[ParentKey] [varchar](16) NULL,
	[Level] [int] NOT NULL,
	
	[DisplayOrder] [varchar](8) NOT NULL
)	



------------------------------------- Begin  ------------------------------------- 
--delete [FAQ] where Category = 'InterviewStatus'

delete @TblCode

insert into @TblCode	
([ItemKey], [Content], [IsLink], [ParentKey], [Level], [DisplayOrder])
select a.*
from (

	select '1' as [ItemKey], '<!DOCTYPE HTML>
<HTML>
<body>

<h2>Frequently Asked Questions</h2>

<ol type="1">
  <li>Can I use your app offline?</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">A: </td><td>The current functions only support online usage.</td></tr></table>
</div>

  <br /><br />
  <li>It feels like it is a little bit slow at the beginning, why?</strong></li>
  <br />
  <div>
<table><tr><td style="width:20px;" valign="top">A: </td><td>For the first usage, the app needs to load required information. Please be patient. In addition, slow network may cause longer intial loading time.</td></tr></table>
  </div>


</ol> 

</body>
</HTML>' as [Content], 0 as [IsLink], null as [ParentKey], 1 as [Level], '001' as [DisplayOrder]

) a 

insert into [FAQ]
([AppName], [ItemKey], [Content], [IsLink], [ParentKey], [Level], [DisplayOrder])
select @AppName, a.*
from @TblCode a left join  [FAQ] z on @AppName = z.AppName and a.[ItemKey] = z.[ItemKey]
where z.Id is null

update a
set a.[Content] = b.[Content], a.[IsLink] = b.[IsLink], a.[ParentKey] = b.[ParentKey], a.[Level] = b.[Level], a.[DisplayOrder] = b.[DisplayOrder]
from [FAQ] a inner join  @TblCode b on a.AppName = @AppName and a.[ItemKey] = b.[ItemKey]

delete 
--select * from
FAQY where FAQId in (select Id from FAQ where AppName = @AppName and [ItemKey] not in (select [ItemKey] from @TblCode))

delete FAQ where AppName = @AppName and [ItemKey] not in (select [ItemKey] from @TblCode)

select * from FAQ where AppName = @AppName


------------------------------------- End  ------------------------------------- 


