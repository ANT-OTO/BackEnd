

declare @pCompanyId int = 1019,
		@pClientId int = 10039,
		@pCompanyServiceId int = NULL,
		@pBillCompanyProductId int = 35,
		@pAdditionalOptionRequired bit = 0,
		@pTime datetime = getutcdate(),
		@pPhoneNumber nvarchar(128) = '+19542660856',
		@pOperatorLanguageId int = 13


insert into [dbo].[VOSPhoneNumber](
	[PhoneNumber],			-- NoReply (noreply@weyimobile.com), System (system@weyimobile.com)
	[CompanyId],
	[ClientId],
	[OperatorLanguageId],
	[CompanyServiceId],
	[BillCompanyProductId],
	[AdditionalOptionRequired],
	[CreateDate],
	[LastUpdate]
)
select  @pPhoneNumber,
		@pCompanyId,
		@pClientId,
		@pOperatorLanguageId,
		@pCompanyServiceId,
		@pBillCompanyProductId,
		@pAdditionalOptionRequired,
		@pTime,
		@pTime
select * from VOSPhoneNumber 