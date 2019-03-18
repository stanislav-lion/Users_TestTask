-- Table: public."User"

-- DROP TABLE public."User";

CREATE TABLE public."User"
(
    "UserId" integer NOT NULL,
    "UserGuid" uuid,
    "LogonName" character(100) COLLATE pg_catalog."default" NOT NULL,
    "AccountId" integer NOT NULL,
    "FirstName" character(50) COLLATE pg_catalog."default" NOT NULL,
    "LastName" character(100) COLLATE pg_catalog."default" NOT NULL,
    "MiddleName" character(30) COLLATE pg_catalog."default",
    "PasswordSalt" character(30) COLLATE pg_catalog."default" NOT NULL,
    "PasswordHash" character(30) COLLATE pg_catalog."default" NOT NULL,
    "PasswordChangeUtc" timestamp without time zone,
    "PasswordMustBeChanged" boolean NOT NULL,
    "IsLogonEnabled" boolean NOT NULL,
    "TimeZone" integer,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "User_pkey" PRIMARY KEY ("UserId"),
    CONSTRAINT "User_PK" UNIQUE ("UserId"),
    CONSTRAINT "User_U_AccountId" UNIQUE ("AccountId"),
    CONSTRAINT "User_U_LogonName" UNIQUE ("LogonName"),
    CONSTRAINT "User_U_UserGuid" UNIQUE ("UserGuid"),
    CONSTRAINT "User_Account_FK" FOREIGN KEY ("AccountId")
        REFERENCES public."Account" ("AccountId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."User"
    OWNER to postgres;