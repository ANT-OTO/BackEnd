--select * from [UIElement]
--select * from [UIElementY]
--select * from SystemLanguage

--truncate table UIElementY


declare @Tbl as Table
(
	[AppName] [nvarchar](64) NOT NULL,			-- Client, Provider, CompanySite 

	[DeviceType] [nvarchar](32) NOT NULL,		-- iPhone, Android, Web, EmptyString is applicable to all devices if no specific device is defined for the ElementKey

	[ElementKey] [nvarchar](128) NOT NULL,
	
	[EnglishContent] nvarchar(max) NOT NULL		

)

delete @Tbl

insert into @Tbl
([AppName], [DeviceType], [ElementKey], [EnglishContent])
select a.[AppName], a.[DeviceType], a.[ElementKey], [EnglishContent]
from (
	select 'Client' as [AppName], '' as [DeviceType], 'SignIn' as [ElementKey], 'SIGN IN' as [EnglishContent], 1 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Register' as [ElementKey], 'REGISTER' as [EnglishContent], 2 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'RegisterSignInTag' as [ElementKey], 'Get Human Interpreter With a Push of a Button' as [EnglishContent], 3 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_1' as [ElementKey], 'Create An Account' as [EnglishContent], 4 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_2' as [ElementKey], 'Go' as [EnglishContent], 5 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_3' as [ElementKey], 'We use email and mobile number to connect you to the interpreter' as [EnglishContent], 6 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_4' as [ElementKey], 'By creating a WEYI account, you agree to the' as [EnglishContent], 7 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_5' as [ElementKey], 'WEYI Terms and Conditions' as [EnglishContent], 8 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'WarningTitle' as [ElementKey], 'Warning' as [EnglishContent], 9 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_6' as [ElementKey], 'Please complete the registration form!' as [EnglishContent], 10 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'WarningButton' as [ElementKey], 'Return' as [EnglishContent], 11 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_7' as [ElementKey], 'Email is not in valid format.' as [EnglishContent], 12 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_8' as [ElementKey], 'Password needs to be between 6 and 15 characters' as [EnglishContent], 13 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_9' as [ElementKey], 'Phone Number Confirmation' as [EnglishContent], 14 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_10' as [ElementKey], 'We will send verification code to the following phone number:' as [EnglishContent], 15 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_11' as [ElementKey], 'OK' as [EnglishContent], 16 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CreateAnAccount_12' as [ElementKey], 'Cancel' as [EnglishContent], 16 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CodeVerification_1' as [ElementKey], 'CODE VERIFICATION' as [EnglishContent], 17 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CodeVerification_2' as [ElementKey], 'Your SMS verification code has been sent to ' as [EnglishContent], 18 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CodeVerification_3' as [ElementKey], 'Please enter your verification code within 60 seconds' as [EnglishContent], 19 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'CodeVerification_4' as [ElementKey], 'SUBMIT' as [EnglishContent], 20 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Profile_1' as [ElementKey], 'Your Profile' as [EnglishContent], 21 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Profile_2' as [ElementKey], 'Name:' as [EnglishContent], 22 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'LanguageSkills_1' as [ElementKey], 'LANGUAGE SKILLS' as [EnglishContent], 23 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'LanguageSkills_2' as [ElementKey], 'Your Native Language:' as [EnglishContent], 24 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'LanguageSkills_3' as [ElementKey], 'You can also talk in the following:' as [EnglishContent], 25 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Home_1' as [ElementKey], 'Request Interpreter' as [EnglishContent], 26 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_1' as [ElementKey], 'REQUEST INTERPRETER' as [EnglishContent], 27 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_2' as [ElementKey], 'I need help on' as [EnglishContent], 28 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_3' as [ElementKey], 'My Situation:' as [EnglishContent], 29 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_4' as [ElementKey], 'Call' as [EnglishContent], 30 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_5' as [ElementKey], 'Chat' as [EnglishContent], 31 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Request_6' as [ElementKey], 'Video' as [EnglishContent], 32 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_1' as [ElementKey], 'SETTINGS' as [EnglishContent], 33 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_2' as [ElementKey], 'My Account' as [EnglishContent], 34 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_3' as [ElementKey], 'Get Free Service' as [EnglishContent], 35 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_4' as [ElementKey], 'Performance' as [EnglishContent], 36 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_5' as [ElementKey], 'FAQ' as [EnglishContent], 37 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_6' as [ElementKey], 'About' as [EnglishContent], 38 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_7' as [ElementKey], 'Like us on Facebook' as [EnglishContent], 39 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_8' as [ElementKey], 'Like us on Twitter' as [EnglishContent], 40 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'Settings_9' as [ElementKey], 'Sign Out' as [EnglishContent], 41 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_1' as [ElementKey], 'ABOUT' as [EnglishContent], 42 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_2' as [ElementKey], 'Rate WEYI' as [EnglishContent], 43 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_3' as [ElementKey], 'Legal' as [EnglishContent], 44 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_4' as [ElementKey], 'Feedback' as [EnglishContent], 45 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_5' as [ElementKey], 'WEYI Inc.' as [EnglishContent], 46 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_6' as [ElementKey], 'Copyright ©' as [EnglishContent], 47 as SortOrder

	UNION

	select 'Client' as [AppName], '' as [DeviceType], 'About_7' as [ElementKey], 'WEYI Rights Reserved' as [EnglishContent], 48 as SortOrder
	
) a 
order by AppName, DeviceType, SortOrder, ElementKey

--select * from [UIElement]
insert into [UIElement]
(AppName,DeviceType,ElementKey,CreateDate)
select a.AppName,a.DeviceType,a.ElementKey, GETUTCDATE()
from @Tbl a left join [UIElement] z on a.AppName = z.AppName and a.DeviceType = z.DeviceType and a.ElementKey = z.ElementKey
where z.Id is null

delete 
--select * from
[UIElementY]
where UIElementId not in (
	select a.Id
	from [UIElement] a inner join @Tbl b on a.AppName = b.AppName and a.DeviceType = b.DeviceType and a.ElementKey = b.ElementKey
)

delete [UIElement]
where Id not in (
	select a.Id
	from [UIElement] a inner join @Tbl b on a.AppName = b.AppName and a.DeviceType = b.DeviceType and a.ElementKey = b.ElementKey
)

--select * from [UIElementY]
insert into [UIElementY]
(UIElementId,SystemLanguageId,Content, CreateDate)
select a.Id as UIElementId, c.Id as SystemLanguageId
	, b.EnglishContent
	, GETUTCDATE()
--select c.*
from [UIElement] a 
	inner join @Tbl b on a.AppName = b.AppName and a.DeviceType = b.DeviceType and a.ElementKey = b.ElementKey
	inner join SystemLanguage c on c.Available = 1
	left join [UIElementY] z on a.Id = z.UIElementId and z.SystemLanguageId = c.Id
where z.Id is null
 
--select * from SystemLanguage
--select * from UIElement

update a
set a.Content = case
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='SignIn' then N'登录'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='SignIn' then N'登錄'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='SignIn' then N'REGISTRARSE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Register' then N'注册'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Register' then N'註冊'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Register' then N'INSCRIBIRSE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='RegisterSignInTag' then N'实时真人翻译服务，就在你手掌中'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='RegisterSignInTag' then N'實時真人翻譯服務，就在你手掌中'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='RegisterSignInTag' then N'CONSEGUIR INTÉRPRETE HUMANO CON SÓLO PULSAR UN BOTÓN'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_1' then N'创建一个帐户'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_1' then N'創建一個帳戶'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_1' then N'CREAR UNA CUENTA'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_2' then N'注册'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_2' then N'註冊'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_2' then N'INSCRIBIRSE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_3' then N'我们使用电子邮件和手机号给你连接到翻译'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_3' then N'我們使用電子郵件和手機號給你連接到翻譯'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_3' then N'USAMOS EL CORREO ELECTRÓNICO Y NÚMERO DE TELÉFONO MÓVIL PARA CONECTARSE A LA INTÉRPRETE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_4' then N'通过创建WEYI帐户，您同意'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_4' then N'通過創建WEYI帳戶，您同意'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_4' then N'MEDIANTE LA CREACIÓN DE UNA CUENTA DE WEYI, USTED ESTÁ DE ACUERDO CON EL'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_5' then N'WEYI条款和条件'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_5' then N'WEYI條款和條件'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_5' then N'TÉRMINOS Y CONDICIONES WEYI'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningTitle' then N'注意'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningTitle' then N'注意'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningTitle' then N'ADVERTENCIA'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_6' then N'请填写报名表！'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_6' then N'請填寫報名表！'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_6' then N'POR FAVOR COMPLETE EL FORMULARIO DE INSCRIPCIÓN!'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningButton' then N'返回'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningButton' then N'返回'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='WarningButton' then N'RETORNO'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_7' then N'电子邮件格式错误。'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_7' then N'電子郵件格式錯誤。'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_7' then N'CORREO ELECTRÓNICO NO TIENE UN FORMATO VÁLIDO.'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_8' then N'密码需要6至15个字符'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_8' then N'密碼需要6至15個字符'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_8' then N'CONTRASEÑA DEBE TENER ENTRE 6 Y 15 CARACTERES'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_9' then N'手机号码确认'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_9' then N'手機號碼確認'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_9' then N'TELÉFONO NÚMERO DE CONFIRMACIÓN'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_10' then N'我们将发送验证码到以下手机号码：'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_10' then N'我們將發送驗證碼到以下手機號碼：'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_10' then N'LE ENVIAREMOS EL CÓDIGO DE VERIFICACIÓN AL SIGUIENTE NÚMERO DE TELÉFONO:'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_11' then N'好'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_11' then N'好'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_11' then N'OK'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_12' then N'取消'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_12' then N'取消'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CreateAnAccount_12' then N'Cancelar'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_1' then N'验证码'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_1' then N'驗證碼'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_1' then N'VERIFICACIÓN DE CÓDIGO'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_2' then N'您的短信验证码已经被寄往你手机'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_2' then N'您的短信驗證碼已經被寄往你手機'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_2' then N'EL CÓDIGO DE VERIFICACIÓN SMS HA SIDO ENVIADA A'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_3' then N'请在60秒内输入验证码'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_3' then N'請在60秒內輸入驗證碼'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_3' then N'POR FAVOR, INTRODUZCA SU CÓDIGO DE VERIFICACIÓN EN 60 SEGUNDOS'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_4' then N'提交'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_4' then N'提交'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='CodeVerification_4' then N'PRESENTAR'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_1' then N'您的个人资料'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_1' then N'您的個人資料'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_1' then N'TU PERFIL'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_2' then N'名字：'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_2' then N'名字：'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Profile_2' then N'NOMBRE:'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_1' then N'语言技能'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_1' then N'語言技能'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_1' then N'HABILIDADES LINGÜÍSTICAS'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_2' then N'你的母语：'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_2' then N'你的母語：'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_2' then N'SU LENGUA MATERNA:'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_3' then N'请告诉我们其他你会的语言：'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_3' then N'請告訴我們其他你會的語言：'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='LanguageSkills_3' then N'TAMBIÉN SE PUEDE TAK EN EL SIGUIENTE:'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Home_1' then N'请求实时翻译'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Home_1' then N'請求實時翻譯'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Home_1' then N'SOLICITUD DE INTÉRPRETE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_1' then N'请求实时翻译'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_1' then N'請求實時翻譯'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_1' then N'SOLICITUD DE INTÉRPRETE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_2' then N'我需要有人帮我翻译'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_2' then N'我需要有人幫我翻譯'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_2' then N'NECESITO AYUDA EN'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_3' then N'我的情况：'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_3' then N'我的情況：'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_3' then N'MI SITUACIÓN:'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_4' then N'通话'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_4' then N'通話'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_4' then N'LLAMADA'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_5' then N'句子图片语音'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_5' then N'句子圖片語音'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_5' then N'CHARLAR'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_6' then N'视频'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_6' then N'視頻'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Request_6' then N'VÍDEO'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_1' then N'设置'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_1' then N'設置'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_1' then N'AJUSTES'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_2' then N'我的账户'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_2' then N'我的賬戶'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_2' then N'MI CUENTA'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_3' then N'获得免费服务'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_3' then N'獲得免費服務'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_3' then N'OBTENER SERVICIO GRATUITO'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_4' then N'评分'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_4' then N'評分'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_4' then N'RENDIMIENTO'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_5' then N'常问问题'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_5' then N'常問問題'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_5' then N'PREGUNTAS MÁS FRECUENTES'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_6' then N'关于WEYI'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_6' then N'關於WEYI'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_6' then N'ACERCA DE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_7' then N''
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_7' then N''
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_7' then N'NOS GUSTARÍA EN FACEBOOK'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_8' then N''
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_8' then N''
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_8' then N'NOS GUSTARÍA EN TWITTER'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_9' then N'退出登录'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_9' then N'退出登錄'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='Settings_9' then N'DESCONECTARSE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_1' then N'关于WEYI'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_1' then N'關於WEYI'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_1' then N'ACERCA DE'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_2' then N'给WEYI打分'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_2' then N'給WEYI打分'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_2' then N'WEYI TASA'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_3' then N'法律相关内容'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_3' then N'法律相關內容'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_3' then N'Contenido Leyes relativas'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_4' then N'用户反馈'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_4' then N'用戶反饋'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_4' then N'Comentarios de los usuarios'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_5' then N'WEYI Inc.'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_5' then N'WEYI Inc.'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_5' then N'WEYI Inc.'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_6' then N'版权 ©'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_6' then N'版權 ©'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_6' then N'DERECHOS DE AUTOR ©'
when a.SystemLanguageId = 2 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_7' then N'WEYI 所有权利保留'
when a.SystemLanguageId = 3 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_7' then N'WEYI 所有權利保留'
when a.SystemLanguageId = 4 and d.AppName = 'Client' and d.DeviceType='' and d.ElementKey='About_7' then N'WEYI DERECHOS RESERVADOS'

					else b.Content end
--select *
from UIElementY a inner join UIElementY b on a.UIElementId = b.UIElementId and a.SystemLanguageId <> 1 and b.SystemLanguageId = 1
	inner join (
		select max(Id) as Id
		from UIElementY (nolock)
		group by UIElementId, SystemLanguageId
	) c on a.Id = c.Id
	inner join UIElement d on a.UIElementId = d.Id
--where a.Content = b.Content

--select *
/*

select 'when a.SystemLanguageId = ' + convert(nvarchar, a.SystemLanguageId) + ' and d.AppName = ''Client'' and d.DeviceType=''' + d.DeviceType + ''' and d.ElementKey=''' + d.ElementKey + ''' then N''' + a.Content + ''''
from UIElementY a inner join UIElementY b on a.UIElementId = b.UIElementId and a.SystemLanguageId <> 1 and b.SystemLanguageId = 1
	inner join (
		select max(Id) as Id
		from UIElementY (nolock)
		group by UIElementId, SystemLanguageId
	) c on a.Id = c.Id
	inner join UIElement d on a.UIElementId = d.Id and d.AppName = 'Client'
where a.Content <> b.Content

select * from [UIElementY] 
order by UIElementId, SystemLanguageId, Id
*/



select * from [UIElement] 
select * from [UIElementY] --where UIElementId = 1
