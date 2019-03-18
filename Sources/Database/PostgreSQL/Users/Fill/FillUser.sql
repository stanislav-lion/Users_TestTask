CREATE EXTENSION "uuid-ossp";

INSERT INTO public."User"
	("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CultureCode", "CreatedUtc", "ModifiedUtc")
VALUES
	(1, uuid_generate_v4(), 'stanislav_lion', 1, 'Stanislav', 'Zrozhevskyi', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(2, uuid_generate_v4(), 'andrew', 2, 'Andrew', 'Dvornichenko', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(3, uuid_generate_v4(), 'sergei', 3, 'Sergei', 'Podolyanchuk', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(4, uuid_generate_v4(), 'alexander', 4, 'Alexander', 'Ostrovskyi', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(5, uuid_generate_v4(), 'ivan', 5, 'Ivan', 'Ponomarev', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(6, uuid_generate_v4(), 'luda', 6, 'Luda', 'Osovskaya', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(7, uuid_generate_v4(), 'karina', 7, 'Karina', 'Nosova', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(8, uuid_generate_v4(), 'lena', 8, 'Lena', 'Glushankova', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(9, uuid_generate_v4(), 'nastya', 9, 'Nastya', 'Kaluzhnaya', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW()),
	(10, uuid_generate_v4(), 'irina', 10, 'Irina', 'Alekseevna', null, 'test', 'test', null, 0, 1, 2, 'uk-UA', NOW(), NOW());