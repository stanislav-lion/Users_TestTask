-- Table: public."AccountAddress"

-- DROP TABLE public."AccountAddress";

CREATE TABLE public."AccountAddress"
(
    "AccountId" integer NOT NULL,
    "AddressType" integer NOT NULL,
    "AddressLine1" character(100) COLLATE pg_catalog."default",
    "AddressLine2" character(100) COLLATE pg_catalog."default",
    "AddressLine3" character(100) COLLATE pg_catalog."default",
    "City" character(50) COLLATE pg_catalog."default" NOT NULL,
    "County" character(50) COLLATE pg_catalog."default" NOT NULL,
    "StateProvince" character(50) COLLATE pg_catalog."default",
    "PostalCode" character(15) COLLATE pg_catalog."default",
    "CountryTwoLetterCode" character(2) COLLATE pg_catalog."default" NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "AccountAddress_pkey" PRIMARY KEY ("AccountId"),
    CONSTRAINT "AccountAddress_PK" UNIQUE ("AccountId"),
    CONSTRAINT "AccountAddress_Account_FK" FOREIGN KEY ("AccountId")
        REFERENCES public."Account" ("AccountId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT "AccountAddress_AddressType_FK" FOREIGN KEY ("AddressType")
        REFERENCES public."AddressType" ("AddressTypeId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."AccountAddress"
    OWNER to postgres;