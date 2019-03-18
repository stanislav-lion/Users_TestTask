INSERT INTO public."PrivilegeType"
	("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc")
VALUES
	(1, 'None', NOW(), NOW()),
	(2, 'View', NOW(), NOW()),
	(3, 'Edit', NOW(), NOW());