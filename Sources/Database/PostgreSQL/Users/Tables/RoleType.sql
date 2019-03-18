-- Table: public."RoleType"

-- DROP TABLE public."RoleType";

CREATE TABLE public."RoleType"
(
    "RoleTypeId" integer NOT NULL,
    "RoleTypeName" character(100) COLLATE pg_catalog."default" NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "RoleType_pkey" PRIMARY KEY ("RoleTypeId"),
    CONSTRAINT "RoleType_PK" UNIQUE ("RoleTypeId")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."RoleType"
    OWNER to postgres;