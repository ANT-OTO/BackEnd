--select * from [ErrorMsg]
--select * from [ErrorMsgY]
--select * from SystemLanguage


declare @SystemLanguageId int
select @SystemLanguageId = Id
--select *
from SystemLanguage where [Name] = N'繁體中文'


insert into [ErrorMsgY]
(ErrorMsgId, Msg, SystemLanguageId, CreateDate)
select a.*, @SystemLanguageId, GETDATE() as CreateDate
from (
	select a.*
	from (
	select a.Id as ErrorMsgId,
		case when [Msg] = N'System Error' then N'系統錯誤'
			when [Msg] = 'Requires Login' then N'需要登錄'
			when [Msg] = 'Invalid System Language' then N'系统语言不合要求'
			when [Msg] = 'Record not found' then N'記錄未找到'
			when [Msg] = 'Invalid Email' then N'電子郵箱不合要求'
			when [Msg] = 'Password needs to be between 6 and 15 characters' then N'密碼需要6至15個字符'
			when [Msg] = 'Invalid Region' then N'地區不合要求'
			when [Msg] = 'Invalid Mobile Number' then N'手機號碼不合要求'
			when [Msg] = 'Email is already registered' then N'電子郵箱已經被註冊'
			when [Msg] = 'Mobile Number is already registered' then N'手機號碼已被注册'
			when [Msg] = 'Invalid Name' then N'名字不合要求'
			when [Msg] = 'Invalid Input' then N'輸入不合要求'
			when [Msg] = 'Invalid Code' then N'輸入驗證碼不匹配'
			when [Msg] = 'Code Already Validated' then N'已經驗證過了'
			when [Msg] = 'Code Expired' then N'驗證碼過期了'
			when [Msg] = 'Invalid Image Format' then N'圖像格式不對'
			when [Msg] = 'Please enter certificate info' then N'請輸入證書信息'
			when [Msg] = 'File Required' then N'文件是必需的'
			when [Msg] = 'Login Failed' then N'登錄失敗'
			when [Msg] = 'No Profile Image' then N'沒有圖片'
		else N''
		end as Msg
	from [ErrorMsg] a
	) a where a.[Msg] <> ''

	
) a left join  [ErrorMsgY] z on a.ErrorMsgId = z.ErrorMsgId and z.SystemLanguageId = @SystemLanguageId 
where z.Id is null


select * from ErrorMsgY