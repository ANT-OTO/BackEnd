IF NOT EXISTS(
    SELECT *
    FROM sys.columns
    WHERE Name      = N'ShippingChannelTypeCodeId'
      AND Object_ID = Object_ID(N'ANTOTO.dbo.ShippingChannel'))
BEGIN
    -- Column NOT Exists
	ALTER TABLE ANTOTO.dbo.ShippingChannel
	ADD ShippingChannelTypeCodeId int NULL
	DEFAULT 1
END

update a
set a.ShippingChannelTypeCodeId = 1
from ShippingChannel a

select * from ShippingChannel

go
