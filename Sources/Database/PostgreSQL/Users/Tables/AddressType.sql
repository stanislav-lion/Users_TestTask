-- Table: public."AddressType"

-- DROP TABLE public."AddressType";

CREATE TABLE public."AddressType"
(
    "AddressTypeId" integer NOT NULL,
    "AddressTypeName" character(100) COLLATE pg_catalog."default" NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "AddressType_pkey" PRIMARY KEY ("AddressTypeId"),
    CONSTRAINT "AddressType_PK" UNIQUE ("AddressTypeId"),
    CONSTRAINT "AddressType_U_AddressTypeName" UNIQUE ("AddressTypeName")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."AddressType"
    OWNER to postgres;