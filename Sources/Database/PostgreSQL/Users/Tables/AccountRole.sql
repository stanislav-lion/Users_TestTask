-- Table: public."AccountRole"

-- DROP TABLE public."AccountRole";

CREATE TABLE public."AccountRole"
(
    "AccountRoleId" integer NOT NULL,
    "AccountRoleGuid" uuid,
    "AccountId" integer NOT NULL,
    "RoleName" character(40) COLLATE pg_catalog."default" NOT NULL,
    "RoleType" integer NOT NULL,
    "PrivilegeType" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "AccountRole_pkey" PRIMARY KEY ("AccountRoleId"),
    CONSTRAINT "AccountRole_PK" UNIQUE ("AccountRoleId"),
    CONSTRAINT "AccountRole_U_AccountId" UNIQUE ("AccountId"),
    CONSTRAINT "AccountRole_U_AccountRoleGuid" UNIQUE ("AccountRoleGuid"),
    CONSTRAINT "AccountRole_Account_FK" FOREIGN KEY ("AccountId")
        REFERENCES public."Account" ("AccountId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT "AccountRole_PrivilegeType_FK" FOREIGN KEY ("PrivilegeType")
        REFERENCES public."PrivilegeType" ("PrivilegeTypeId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "AccountRole_RoleType_FK" FOREIGN KEY ("RoleType")
        REFERENCES public."RoleType" ("RoleTypeId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."AccountRole"
    OWNER to postgres;