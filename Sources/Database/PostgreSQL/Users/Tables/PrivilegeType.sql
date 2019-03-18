-- Table: public."PrivilegeType"

-- DROP TABLE public."PrivilegeType";

CREATE TABLE public."PrivilegeType"
(
    "PrivilegeTypeId" integer NOT NULL,
    "PrivilegeTypeName" character(100) COLLATE pg_catalog."default" NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "PrivilegeType_pkey" PRIMARY KEY ("PrivilegeTypeId"),
    CONSTRAINT "PrivilegeType_PK" UNIQUE ("PrivilegeTypeId")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."PrivilegeType"
    OWNER to postgres;