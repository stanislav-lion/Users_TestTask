INSERT INTO public."RoleType"
	("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc")
VALUES
	(1, 'APPLICATION_ADMINISTRATOR', NOW(), NOW()),
	(2, 'COMPANY_ADMINISTRATOR', NOW(), NOW()),
	(4, 'COMPANY_USER', NOW(), NOW()),
	(16, 'SYSTEM_ADMINISTRATOR', NOW(), NOW()),
	(32, 'ACCOUNT_ADMINISTRATOR', NOW(), NOW()),
	(64, 'ACCOUNT_SUPPORT', NOW(), NOW()),
	(128, 'NETWORK_MANAGER', NOW(), NOW()),
	(256, 'SITE_COORDINATOR', NOW(), NOW()),
	(512, 'SERVICE_SPECIALIST', NOW(), NOW()),
	(8192, 'GUEST', NOW(), NOW());