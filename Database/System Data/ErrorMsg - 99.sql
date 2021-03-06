

-- SET IDENTITY_INSERT to ON.  
SET IDENTITY_INSERT dbo.ErrorMsg ON;  
GO  
  
-- Try to insert an explicit ID value of 3.  
INSERT INTO dbo.ErrorMsg 
(ID, Msg, CreateDate) 
select a.*
from (
	select 99 as Id, 'You have reached your daily limit for Fong Live' as Msg, GETUTCDATE() as CreateDate
) a left join dbo.ErrorMsg z on a.Id = z.Id
where z.Id is null

SET IDENTITY_INSERT dbo.ErrorMsg OFF;  
GO  


INSERT INTO dbo.ErrorMsgY
(ErrorMsgId, SystemLanguageId, Msg, CreateDate) 
select a.*
from (
	select 99 as ErrorMsgId, 2 as SystemLanguageId, N'您今天的真人翻译额度已达到' as Msg, GETUTCDATE() as CreateDate 
) a left join dbo.ErrorMsgY z on a.ErrorMsgId = z.ErrorMsgId and a.SystemLanguageId = z.SystemLanguageId
where z.Id is null

GO  

select * from ErrorMsg order by Id desc
select * from ErrorMsgY order by Id desc