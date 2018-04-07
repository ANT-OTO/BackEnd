alter table BillPersonPreChargeProductAuthorization
add [Amount] decimal (14,2) NOT NULL CONSTRAINT [DF_BillPersonPreChargeProductAuthorization_Amount]  DEFAULT (50)

alter table BillPersonPreChargeProductAuthorization
drop constraint [DF_BillPersonPreChargeProductAuthorization_Amount]

