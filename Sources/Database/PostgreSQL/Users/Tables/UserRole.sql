-- Table: public."UserRole"

-- DROP TABLE public."UserRole";

CREATE TABLE public."UserRole"
(
    "UserId" integer NOT NULL,
    "AccountRoleId" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL,
    CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserId", "AccountRoleId"),
    CONSTRAINT "UserRole_U_AccountRoleId" UNIQUE ("AccountRoleId"),
    CONSTRAINT "UserRole_U_UserId" UNIQUE ("UserId"),
    CONSTRAINT "UserRole_AccountRole_FK" FOREIGN KEY ("AccountRoleId")
        REFERENCES public."AccountRole" ("AccountRoleId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    CONSTRAINT "UserRole_User_FK" FOREIGN KEY ("UserId")
        REFERENCES public."User" ("UserId") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."UserRole"
    OWNER to postgres;