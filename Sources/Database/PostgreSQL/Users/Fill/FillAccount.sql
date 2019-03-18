CREATE EXTENSION "uuid-ossp";

INSERT INTO public."Account"
	("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc")
VALUES
	(1, uuid_generate_v4(), 'Number1', 'Stanislav Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(2, uuid_generate_v4(), 'Number2', 'Andrew Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(3, uuid_generate_v4(), 'Number3', 'Sergei Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(4, uuid_generate_v4(), 'Number4', 'Alexander Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(5, uuid_generate_v4(), 'Number5', 'Ivan Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(6, uuid_generate_v4(), 'Number6', 'Luda Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(7, uuid_generate_v4(), 'Number7', 'Karina Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(8, uuid_generate_v4(), 'Number8', 'Lena Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(9, uuid_generate_v4(), 'Number9', 'Nastya Account', 1, 2, 3, 60, 1, NOW(), NOW()),
	(10, uuid_generate_v4(), 'Number10', 'Irina Account', 1, 2, 3, 60, 1, NOW(), NOW());