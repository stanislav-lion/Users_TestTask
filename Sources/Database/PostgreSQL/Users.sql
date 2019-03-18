--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

-- Started on 2019-03-19 00:40:22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16690)
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    "AccountId" integer NOT NULL,
    "AccountGuid" uuid,
    "AccountNumber" character(8) NOT NULL,
    "AccountName" character(50) NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "TimeZone" integer,
    "PasswordExpirationPeriodInDays" integer NOT NULL,
    "DataStorageTimeHrs" integer NOT NULL,
    "NumberOfCodeManagementApps" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16693)
-- Name: AccountAddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AccountAddress" (
    "AccountId" integer NOT NULL,
    "AddressType" integer NOT NULL,
    "AddressLine1" character(100),
    "AddressLine2" character(100),
    "AddressLine3" character(100),
    "City" character(50) NOT NULL,
    "County" character(50) NOT NULL,
    "StateProvince" character(50),
    "PostalCode" character(15),
    "CountryTwoLetterCode" character(2) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."AccountAddress" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16696)
-- Name: AccountRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AccountRole" (
    "AccountRoleId" integer NOT NULL,
    "AccountRoleGuid" uuid,
    "AccountId" integer NOT NULL,
    "RoleName" character(40) NOT NULL,
    "RoleType" integer NOT NULL,
    "PrivilegeType" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."AccountRole" OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16699)
-- Name: AddressType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AddressType" (
    "AddressTypeId" integer NOT NULL,
    "AddressTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."AddressType" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16702)
-- Name: PrivilegeType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PrivilegeType" (
    "PrivilegeTypeId" integer NOT NULL,
    "PrivilegeTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."PrivilegeType" OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16705)
-- Name: RoleType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RoleType" (
    "RoleTypeId" integer NOT NULL,
    "RoleTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."RoleType" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16708)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "UserId" integer NOT NULL,
    "UserGuid" uuid,
    "LogonName" character(100) NOT NULL,
    "AccountId" integer NOT NULL,
    "FirstName" character(50) NOT NULL,
    "LastName" character(100) NOT NULL,
    "MiddleName" character(30),
    "PasswordSalt" character(30) NOT NULL,
    "PasswordHash" character(30) NOT NULL,
    "PasswordChangeUtc" timestamp without time zone,
    "PasswordMustBeChanged" boolean NOT NULL,
    "IsLogonEnabled" boolean NOT NULL,
    "TimeZone" integer,
    "CultureCode" character(10),
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16711)
-- Name: UserRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRole" (
    "UserId" integer NOT NULL,
    "AccountRoleId" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);


ALTER TABLE public."UserRole" OWNER TO postgres;

--
-- TOC entry 2875 (class 0 OID 16690)
-- Dependencies: 196
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" ("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	4eda8f0f-ef3c-427a-85d9-2847eb04e319	Number1 	Stanislav Account                                 	t	2	3	60	1	2019-03-18 13:54:58.440163	2019-03-18 13:54:58.440163
2	417d370a-c0d9-42bd-9c52-cf79dcadaa95	Number2 	Andrew Account                                    	t	2	3	60	1	2019-03-18 17:50:27.971032	2019-03-18 17:50:27.971032
4	cd7c2606-e23d-4b70-b9dc-8668210f334e	Number4 	Alexander Account                                 	t	2	3	60	1	2019-03-18 17:52:14.12776	2019-03-18 17:52:14.12776
3	fe4a04f4-76cb-4fe1-be6a-bdf6812037cd	Number3 	Sergei Account                                    	t	2	3	60	1	2019-03-18 17:51:21.327305	2019-03-18 17:51:21.327305
5	4a8ddb81-1509-4d33-aa21-6b1c1afd909b	Number5 	Ivan Account                                      	t	2	3	60	1	2019-03-18 17:53:03.616082	2019-03-18 17:53:03.616082
6	482d9894-d35e-40e3-84d9-82718a4e96e9	Number6 	Luda Account                                      	t	2	3	60	1	2019-03-18 17:53:52.591519	2019-03-18 17:53:52.591519
7	ef5f14d9-e1a2-4659-b3ef-c0c707bf9cee	Number7 	Karina Account                                    	t	2	3	60	1	2019-03-18 17:54:36.492501	2019-03-18 17:54:36.492501
8	3c8cdba4-e2d5-4201-93d1-37bc2779191c	Number8 	Lena Account                                      	t	2	3	60	1	2019-03-18 17:55:27.635136	2019-03-18 17:55:27.635136
9	ee66e638-73dc-4a2b-babd-f089421f5c5b	Number9 	Nastya Account                                    	t	2	3	60	1	2019-03-18 17:56:15.401116	2019-03-18 17:56:15.401116
10	74fc3fdf-c8d8-455e-a101-1934aea896a8	Number10	Irina Account                                     	t	2	3	60	1	2019-03-18 17:56:57.509453	2019-03-18 17:56:57.509453
\.


--
-- TOC entry 2876 (class 0 OID 16693)
-- Dependencies: 197
-- Data for Name: AccountAddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountAddress" ("AccountId", "AddressType", "AddressLine1", "AddressLine2", "AddressLine3", "City", "County", "StateProvince", "PostalCode", "CountryTwoLetterCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	1	\N	\N	\N	Kyiv                                              	Ukraine                                           	Kiev region                                       	\N	UA	2019-03-18 14:06:47.051571	2019-03-18 14:06:47.051571
2	2	\N	\N	\N	Kyiv                                              	Ukraine                                           	Kiev region                                       	\N	UA	2019-03-18 18:12:06.547127	2019-03-18 18:12:06.547127
3	1	\N	\N	\N	Kyiv                                              	Ukraine                                           	Kiev region                                       	\N	UA	2019-03-18 18:13:45.229905	2019-03-18 18:13:45.229905
5	1	\N	\N	\N	Kharkiv                                           	Ukraine                                           	Kharkiv region                                    	\N	UA	2019-03-18 18:18:04.229097	2019-03-18 18:18:04.229097
4	2	\N	\N	\N	Kharkiv                                           	Ukraine                                           	Kharkiv region                                    	\N	UA	2019-03-18 18:16:53.893462	2019-03-18 18:16:53.893462
6	2	\N	\N	\N	Kharkiv                                           	Ukraine                                           	Kharkiv region                                    	\N	UA	2019-03-18 18:20:09.599224	2019-03-18 18:20:09.599224
7	1	\N	\N	\N	Lviv                                              	Ukraine                                           	Lviv region                                       	\N	UA	2019-03-18 18:20:54.108425	2019-03-18 18:20:54.108425
8	2	\N	\N	\N	Poltava                                           	Ukraine                                           	Poltava region                                    	\N	UA	2019-03-18 18:21:42.637558	2019-03-18 18:21:42.637558
9	1	\N	\N	\N	Vinnitsa                                          	Ukraine                                           	Vinnitsa region                                   	\N	UA	2019-03-18 18:22:26.971866	2019-03-18 18:22:26.971866
10	2	\N	\N	\N	Zhitomir                                          	Ukraine                                           	ZhItomir region                                   	\N	UA	2019-03-18 18:23:08.47295	2019-03-18 18:23:08.47295
\.


--
-- TOC entry 2877 (class 0 OID 16696)
-- Dependencies: 198
-- Data for Name: AccountRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountRole" ("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	61599863-4a42-4bd5-90a7-6cb79420a634	1	Administrator                           	1	3	2019-03-18 14:53:25.6479	2019-03-18 14:53:25.6479
2	c090d72d-62ec-463a-bef6-c7fabc087302	2	Administrator                           	2	3	2019-03-18 18:24:38.744942	2019-03-18 18:24:38.744942
3	e6d15dce-3891-4ace-b25e-eee47f5e15a0	3	User                                    	4	3	2019-03-18 18:27:31.039529	2019-03-18 18:27:31.039529
4	ca6d40a9-3fe2-4948-b441-1189865849b3	4	Administrator                           	16	3	2019-03-18 18:28:15.217272	2019-03-18 18:28:15.217272
5	4b701001-d9e5-4a9a-8ce8-8110cd71adb3	5	Administrator                           	32	3	2019-03-18 18:28:54.538118	2019-03-18 18:28:54.538118
6	8260dddb-aff6-4aa2-815d-f72e45054b66	6	Support                                 	64	3	2019-03-18 18:29:32.963463	2019-03-18 18:29:32.963463
7	6dfc7719-5990-42bc-877f-8bd29bdc1a94	7	Manager                                 	128	3	2019-03-18 18:30:12.402265	2019-03-18 18:30:12.402265
8	caf95d05-1c02-4a98-8d92-c1aba5c59b63	8	Coordinator                             	256	3	2019-03-18 18:30:49.014763	2019-03-18 18:30:49.014763
9	0f13a20f-68e3-40b2-8802-911852b8e22e	9	Specialist                              	512	2	2019-03-18 18:31:25.674033	2019-03-18 18:31:25.674033
10	1b7523ce-330a-41f2-951d-20015543468f	10	Guest                                   	8192	1	2019-03-18 18:32:03.466253	2019-03-18 18:32:03.466253
\.


--
-- TOC entry 2878 (class 0 OID 16699)
-- Dependencies: 199
-- Data for Name: AddressType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AddressType" ("AddressTypeId", "AddressTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	Billing                                                                                             	2019-03-18 14:57:22.713448	2019-03-18 14:57:22.713448
2	Physical                                                                                            	2019-03-18 14:57:45.453377	2019-03-18 14:57:45.453377
\.


--
-- TOC entry 2879 (class 0 OID 16702)
-- Dependencies: 200
-- Data for Name: PrivilegeType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PrivilegeType" ("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	None                                                                                                	2019-03-18 15:00:57.553243	2019-03-18 15:00:57.553243
2	View                                                                                                	2019-03-18 15:01:19.657324	2019-03-18 15:01:19.657324
3	Edit                                                                                                	2019-03-18 15:02:34.868281	2019-03-18 15:02:34.868281
\.


--
-- TOC entry 2880 (class 0 OID 16705)
-- Dependencies: 201
-- Data for Name: RoleType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RoleType" ("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	APPLICATION_ADMINISTRATOR                                                                           	2019-03-18 15:03:21.693022	2019-03-18 15:03:21.693022
2	COMPANY_ADMINISTRATOR                                                                               	2019-03-18 15:04:23.572998	2019-03-18 15:04:23.572998
4	COMPANY_USER                                                                                        	2019-03-18 15:05:26.04202	2019-03-18 15:05:26.04202
16	SYSTEM_ADMINISTRATOR                                                                                	2019-03-18 15:05:49.719468	2019-03-18 15:05:49.719468
32	ACCOUNT_ADMINISTRATOR                                                                               	2019-03-18 15:06:16.009999	2019-03-18 15:06:16.009999
64	ACCOUNT_SUPPORT                                                                                     	2019-03-18 15:06:36.260126	2019-03-18 15:06:36.260126
128	NETWORK_MANAGER                                                                                     	2019-03-18 15:06:56.294293	2019-03-18 15:06:56.294293
256	SITE_COORDINATOR                                                                                    	2019-03-18 15:07:19.957836	2019-03-18 15:07:19.957836
512	SERVICE_SPECIALIST                                                                                  	2019-03-18 15:07:42.978707	2019-03-18 15:07:42.978707
8192	GUEST                                                                                               	2019-03-18 15:08:02.689946	2019-03-18 15:08:02.689946
\.


--
-- TOC entry 2881 (class 0 OID 16708)
-- Dependencies: 202
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CultureCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
10	5024abbf-804b-4007-b534-0edfd4f1b207	irina                                                                                               	10	Irina                                             	Alekseevna                                                                                          	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 22:37:13.207041	2019-03-18 22:37:13.207041
1	e6385ac9-21bf-4349-babe-80b91a717f53	stanislav_lion                                                                                      	1	Stanislav                                         	Zrozhevskyi                                                                                         	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:31:35.02677	2019-03-18 21:31:35.02677
2	153e5897-590c-4d78-a5bf-5d61d1634655	andrew                                                                                              	2	Andrew                                            	Dvornichenko                                                                                        	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:31:50.24691	2019-03-18 21:31:50.24691
3	6896680f-4600-4a31-8292-a526237ff23e	sergei                                                                                              	3	Sergei                                            	Podolyanchuk                                                                                        	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:01.230148	2019-03-18 21:32:01.230148
4	cd35e703-f910-4538-b34f-a16d81fb5052	alexander                                                                                           	4	Alexander                                         	Ostrovskyi                                                                                          	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
5	6b3791dd-9c29-4076-98d4-958c36d54b80	ivan                                                                                                	5	Ivan                                              	Ponomarev                                                                                           	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
6	72fd1b25-6d70-4770-a357-fddb441c5301	luda                                                                                                	6	Luda                                              	Osovskaya                                                                                           	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
7	7b0eeb1b-5723-4d7f-989e-960389080538	karina                                                                                              	7	Karina                                            	Nosova                                                                                              	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
8	13467c7c-a6ca-4e72-8c03-adf64f5e492b	lena                                                                                                	8	Lena                                              	Glushankova                                                                                         	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
9	c8bd1b9b-71d7-4802-a98b-2af1dedc3ebd	nastya                                                                                              	9	Nastya                                            	Kaluzhnaya                                                                                          	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 21:32:56.066358	2019-03-18 21:32:56.066358
\.


--
-- TOC entry 2882 (class 0 OID 16711)
-- Dependencies: 203
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRole" ("UserId", "AccountRoleId", "CreatedUtc", "ModifiedUtc") FROM stdin;
1	1	2019-03-18 15:27:34.165981	2019-03-18 15:27:34.165981
2	2	2019-03-18 18:57:27.05137	2019-03-18 18:57:27.05137
3	3	2019-03-18 18:57:39.573818	2019-03-18 18:57:39.573818
4	4	2019-03-18 18:57:52.27989	2019-03-18 18:57:52.27989
5	5	2019-03-18 18:58:04.144325	2019-03-18 18:58:04.144325
6	6	2019-03-18 18:58:16.282499	2019-03-18 18:58:16.282499
7	7	2019-03-18 18:58:29.024663	2019-03-18 18:58:29.024663
8	8	2019-03-18 18:58:43.349447	2019-03-18 18:58:43.349447
9	9	2019-03-18 18:58:56.624795	2019-03-18 18:58:56.624795
10	10	2019-03-18 22:38:24.400758	2019-03-18 22:38:24.400758
\.


--
-- TOC entry 2705 (class 2606 OID 16715)
-- Name: AccountAddress AccountAddress_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_PK" UNIQUE ("AccountId");


--
-- TOC entry 2707 (class 2606 OID 16717)
-- Name: AccountAddress AccountAddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_pkey" PRIMARY KEY ("AccountId");


--
-- TOC entry 2709 (class 2606 OID 16719)
-- Name: AccountRole AccountRole_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PK" UNIQUE ("AccountRoleId");


--
-- TOC entry 2711 (class 2606 OID 16721)
-- Name: AccountRole AccountRole_U_AccountId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountId" UNIQUE ("AccountId");


--
-- TOC entry 2713 (class 2606 OID 16723)
-- Name: AccountRole AccountRole_U_AccountRoleGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountRoleGuid" UNIQUE ("AccountRoleGuid");


--
-- TOC entry 2715 (class 2606 OID 16725)
-- Name: AccountRole AccountRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_pkey" PRIMARY KEY ("AccountRoleId");


--
-- TOC entry 2697 (class 2606 OID 16727)
-- Name: Account Account_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_PK" UNIQUE ("AccountId");


--
-- TOC entry 2699 (class 2606 OID 16729)
-- Name: Account Account_U_AccountGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountGuid" UNIQUE ("AccountGuid");


--
-- TOC entry 2701 (class 2606 OID 16731)
-- Name: Account Account_U_AccountNumber; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountNumber" UNIQUE ("AccountNumber");


--
-- TOC entry 2703 (class 2606 OID 16733)
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("AccountId");


--
-- TOC entry 2717 (class 2606 OID 16735)
-- Name: AddressType AddressType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_PK" UNIQUE ("AddressTypeId");


--
-- TOC entry 2719 (class 2606 OID 16737)
-- Name: AddressType AddressType_U_AddressTypeName; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_U_AddressTypeName" UNIQUE ("AddressTypeName");


--
-- TOC entry 2721 (class 2606 OID 16739)
-- Name: AddressType AddressType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_pkey" PRIMARY KEY ("AddressTypeId");


--
-- TOC entry 2723 (class 2606 OID 16741)
-- Name: PrivilegeType PrivilegeType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_PK" UNIQUE ("PrivilegeTypeId");


--
-- TOC entry 2725 (class 2606 OID 16743)
-- Name: PrivilegeType PrivilegeType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_pkey" PRIMARY KEY ("PrivilegeTypeId");


--
-- TOC entry 2727 (class 2606 OID 16745)
-- Name: RoleType RoleType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_PK" UNIQUE ("RoleTypeId");


--
-- TOC entry 2729 (class 2606 OID 16747)
-- Name: RoleType RoleType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_pkey" PRIMARY KEY ("RoleTypeId");


--
-- TOC entry 2741 (class 2606 OID 16749)
-- Name: UserRole UserRole_U_AccountRoleId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_AccountRoleId" UNIQUE ("AccountRoleId");


--
-- TOC entry 2743 (class 2606 OID 16751)
-- Name: UserRole UserRole_U_UserId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_UserId" UNIQUE ("UserId");


--
-- TOC entry 2745 (class 2606 OID 16753)
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserId", "AccountRoleId");


--
-- TOC entry 2731 (class 2606 OID 16755)
-- Name: User User_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_PK" UNIQUE ("UserId");


--
-- TOC entry 2733 (class 2606 OID 16757)
-- Name: User User_U_AccountId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_AccountId" UNIQUE ("AccountId");


--
-- TOC entry 2735 (class 2606 OID 16759)
-- Name: User User_U_LogonName; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_LogonName" UNIQUE ("LogonName");


--
-- TOC entry 2737 (class 2606 OID 16761)
-- Name: User User_U_UserGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_UserGuid" UNIQUE ("UserGuid");


--
-- TOC entry 2739 (class 2606 OID 16763)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserId");


--
-- TOC entry 2746 (class 2606 OID 16764)
-- Name: AccountAddress AccountAddress_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;


--
-- TOC entry 2747 (class 2606 OID 16769)
-- Name: AccountAddress AccountAddress_AddressType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_AddressType_FK" FOREIGN KEY ("AddressType") REFERENCES public."AddressType"("AddressTypeId") ON UPDATE CASCADE;


--
-- TOC entry 2748 (class 2606 OID 16774)
-- Name: AccountRole AccountRole_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;


--
-- TOC entry 2749 (class 2606 OID 16779)
-- Name: AccountRole AccountRole_PrivilegeType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PrivilegeType_FK" FOREIGN KEY ("PrivilegeType") REFERENCES public."PrivilegeType"("PrivilegeTypeId");


--
-- TOC entry 2750 (class 2606 OID 16784)
-- Name: AccountRole AccountRole_RoleType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_RoleType_FK" FOREIGN KEY ("RoleType") REFERENCES public."RoleType"("RoleTypeId");


--
-- TOC entry 2752 (class 2606 OID 16789)
-- Name: UserRole UserRole_AccountRole_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_AccountRole_FK" FOREIGN KEY ("AccountRoleId") REFERENCES public."AccountRole"("AccountRoleId") ON UPDATE CASCADE;


--
-- TOC entry 2753 (class 2606 OID 16794)
-- Name: UserRole UserRole_User_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_User_FK" FOREIGN KEY ("UserId") REFERENCES public."User"("UserId") ON UPDATE CASCADE;


--
-- TOC entry 2751 (class 2606 OID 16799)
-- Name: User User_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId");


-- Completed on 2019-03-19 00:40:23

--
-- PostgreSQL database dump complete
--

