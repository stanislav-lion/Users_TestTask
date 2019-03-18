CREATE EXTENSION "uuid-ossp";

INSERT INTO public."AccountRole"
	("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc")
VALUES
	(1, uuid_generate_v4(), 1, 'Administrator', 1, 3, NOW(), NOW()),
	(2, uuid_generate_v4(), 2, 'Administrator', 2, 3, NOW(), NOW()),
	(3, uuid_generate_v4(), 3, 'User', 4, 3, NOW(), NOW()),
	(4, uuid_generate_v4(), 4, 'Administrator', 16, 3, NOW(), NOW()),
	(5, uuid_generate_v4(), 5, 'Administrator', 32, 3, NOW(), NOW()),
	(6, uuid_generate_v4(), 6, 'Support', 64, 3, NOW(), NOW()),
	(7, uuid_generate_v4(), 7, 'Manager', 128, 3, NOW(), NOW()),
	(8, uuid_generate_v4(), 8, 'Coordinator', 256, 3, NOW(), NOW()),
	(9, uuid_generate_v4(), 9, 'Specialist', 512, 2, NOW(), NOW()),
	(10, uuid_generate_v4(), 10, 'Guest', 8192, 1, NOW(), NOW());