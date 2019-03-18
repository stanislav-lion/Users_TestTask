-- Table: public."Account"

-- DROP TABLE public."Account";

CREATE TABLE public."Account"
(
    "AccountId" integer NOT NULL,
    "AccountGuid" uuid,
    "AccountNumber" character(8) COLLATE pg_catalog."default" NOT NULL,
    "AccountName" character(50) COLLATE pg_catalog."default" NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "TimeZone" integer,
    "PasswordExpirationPeriodInDays" integer NOT NULL,
    "DataStorageTimeHrs" integer NOT NULL,
    "NumberOfCodeManagementApps" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "Account_pkey" PRIMARY KEY ("AccountId"),
    CONSTRAINT "Account_PK" UNIQUE ("AccountId"),
    CONSTRAINT "Account_U_AccountGuid" UNIQUE ("AccountGuid"),
    CONSTRAINT "Account_U_AccountNumber" UNIQUE ("AccountNumber")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Account"
    OWNER to postgres;