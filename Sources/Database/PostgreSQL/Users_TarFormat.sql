toc.dat                                                                                             0000600 0004000 0002000 00000046362 13444017250 0014452 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       ,    )                 w            Users    10.6    10.6 9    E           0    0    ENCODING    ENCODING     #   SET client_encoding = 'SQL_ASCII';
                       false         F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         H           1262    16689    Users    DATABASE     �   CREATE DATABASE "Users" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Users";
             postgres    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         I           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                     3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         J           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1         �            1259    16690    Account    TABLE     �  CREATE TABLE public."Account" (
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
    DROP TABLE public."Account";
       public         postgres    false    3         �            1259    16693    AccountAddress    TABLE       CREATE TABLE public."AccountAddress" (
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
 $   DROP TABLE public."AccountAddress";
       public         postgres    false    3         �            1259    16696    AccountRole    TABLE     g  CREATE TABLE public."AccountRole" (
    "AccountRoleId" integer NOT NULL,
    "AccountRoleGuid" uuid,
    "AccountId" integer NOT NULL,
    "RoleName" character(40) NOT NULL,
    "RoleType" integer NOT NULL,
    "PrivilegeType" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
 !   DROP TABLE public."AccountRole";
       public         postgres    false    3         �            1259    16699    AddressType    TABLE     �   CREATE TABLE public."AddressType" (
    "AddressTypeId" integer NOT NULL,
    "AddressTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
 !   DROP TABLE public."AddressType";
       public         postgres    false    3         �            1259    16702    PrivilegeType    TABLE     �   CREATE TABLE public."PrivilegeType" (
    "PrivilegeTypeId" integer NOT NULL,
    "PrivilegeTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
 #   DROP TABLE public."PrivilegeType";
       public         postgres    false    3         �            1259    16705    RoleType    TABLE     �   CREATE TABLE public."RoleType" (
    "RoleTypeId" integer NOT NULL,
    "RoleTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
    DROP TABLE public."RoleType";
       public         postgres    false    3         �            1259    16708    User    TABLE     �  CREATE TABLE public."User" (
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
    DROP TABLE public."User";
       public         postgres    false    3         �            1259    16711    UserRole    TABLE     �   CREATE TABLE public."UserRole" (
    "UserId" integer NOT NULL,
    "AccountRoleId" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
    DROP TABLE public."UserRole";
       public         postgres    false    3         ;          0    16690    Account 
   TABLE DATA               �   COPY public."Account" ("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    196       2875.dat <          0    16693    AccountAddress 
   TABLE DATA               �   COPY public."AccountAddress" ("AccountId", "AddressType", "AddressLine1", "AddressLine2", "AddressLine3", "City", "County", "StateProvince", "PostalCode", "CountryTwoLetterCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    197       2876.dat =          0    16696    AccountRole 
   TABLE DATA               �   COPY public."AccountRole" ("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    198       2877.dat >          0    16699    AddressType 
   TABLE DATA               h   COPY public."AddressType" ("AddressTypeId", "AddressTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    199       2878.dat ?          0    16702    PrivilegeType 
   TABLE DATA               n   COPY public."PrivilegeType" ("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    200       2879.dat @          0    16705    RoleType 
   TABLE DATA               _   COPY public."RoleType" ("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    201       2880.dat A          0    16708    User 
   TABLE DATA                 COPY public."User" ("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CultureCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    202       2881.dat B          0    16711    UserRole 
   TABLE DATA               \   COPY public."UserRole" ("UserId", "AccountRoleId", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    203       2882.dat �
           2606    16715     AccountAddress AccountAddress_PK 
   CONSTRAINT     f   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_PK" UNIQUE ("AccountId");
 N   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_PK";
       public         postgres    false    197         �
           2606    16717 "   AccountAddress AccountAddress_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_pkey" PRIMARY KEY ("AccountId");
 P   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_pkey";
       public         postgres    false    197         �
           2606    16719    AccountRole AccountRole_PK 
   CONSTRAINT     d   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PK" UNIQUE ("AccountRoleId");
 H   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PK";
       public         postgres    false    198         �
           2606    16721 #   AccountRole AccountRole_U_AccountId 
   CONSTRAINT     i   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountId" UNIQUE ("AccountId");
 Q   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountId";
       public         postgres    false    198         �
           2606    16723 )   AccountRole AccountRole_U_AccountRoleGuid 
   CONSTRAINT     u   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountRoleGuid" UNIQUE ("AccountRoleGuid");
 W   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountRoleGuid";
       public         postgres    false    198         �
           2606    16725    AccountRole AccountRole_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_pkey" PRIMARY KEY ("AccountRoleId");
 J   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_pkey";
       public         postgres    false    198         �
           2606    16727    Account Account_PK 
   CONSTRAINT     X   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_PK" UNIQUE ("AccountId");
 @   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_PK";
       public         postgres    false    196         �
           2606    16729    Account Account_U_AccountGuid 
   CONSTRAINT     e   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountGuid" UNIQUE ("AccountGuid");
 K   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountGuid";
       public         postgres    false    196         �
           2606    16731    Account Account_U_AccountNumber 
   CONSTRAINT     i   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountNumber" UNIQUE ("AccountNumber");
 M   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountNumber";
       public         postgres    false    196         �
           2606    16733    Account Account_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("AccountId");
 B   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_pkey";
       public         postgres    false    196         �
           2606    16735    AddressType AddressType_PK 
   CONSTRAINT     d   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_PK" UNIQUE ("AddressTypeId");
 H   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_PK";
       public         postgres    false    199         �
           2606    16737 )   AddressType AddressType_U_AddressTypeName 
   CONSTRAINT     u   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_U_AddressTypeName" UNIQUE ("AddressTypeName");
 W   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_U_AddressTypeName";
       public         postgres    false    199         �
           2606    16739    AddressType AddressType_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_pkey" PRIMARY KEY ("AddressTypeId");
 J   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_pkey";
       public         postgres    false    199         �
           2606    16741    PrivilegeType PrivilegeType_PK 
   CONSTRAINT     j   ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_PK" UNIQUE ("PrivilegeTypeId");
 L   ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_PK";
       public         postgres    false    200         �
           2606    16743     PrivilegeType PrivilegeType_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_pkey" PRIMARY KEY ("PrivilegeTypeId");
 N   ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_pkey";
       public         postgres    false    200         �
           2606    16745    RoleType RoleType_PK 
   CONSTRAINT     [   ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_PK" UNIQUE ("RoleTypeId");
 B   ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_PK";
       public         postgres    false    201         �
           2606    16747    RoleType RoleType_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_pkey" PRIMARY KEY ("RoleTypeId");
 D   ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_pkey";
       public         postgres    false    201         �
           2606    16749 !   UserRole UserRole_U_AccountRoleId 
   CONSTRAINT     k   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_AccountRoleId" UNIQUE ("AccountRoleId");
 O   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_AccountRoleId";
       public         postgres    false    203         �
           2606    16751    UserRole UserRole_U_UserId 
   CONSTRAINT     ]   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_UserId" UNIQUE ("UserId");
 H   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_UserId";
       public         postgres    false    203         �
           2606    16753    UserRole UserRole_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserId", "AccountRoleId");
 D   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_pkey";
       public         postgres    false    203    203         �
           2606    16755    User User_PK 
   CONSTRAINT     O   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_PK" UNIQUE ("UserId");
 :   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_PK";
       public         postgres    false    202         �
           2606    16757    User User_U_AccountId 
   CONSTRAINT     [   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_AccountId" UNIQUE ("AccountId");
 C   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_AccountId";
       public         postgres    false    202         �
           2606    16759    User User_U_LogonName 
   CONSTRAINT     [   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_LogonName" UNIQUE ("LogonName");
 C   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_LogonName";
       public         postgres    false    202         �
           2606    16761    User User_U_UserGuid 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_UserGuid" UNIQUE ("UserGuid");
 B   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_UserGuid";
       public         postgres    false    202         �
           2606    16763    User User_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserId");
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public         postgres    false    202         �
           2606    16764 (   AccountAddress AccountAddress_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;
 V   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_Account_FK";
       public       postgres    false    196    2697    197         �
           2606    16769 ,   AccountAddress AccountAddress_AddressType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_AddressType_FK" FOREIGN KEY ("AddressType") REFERENCES public."AddressType"("AddressTypeId") ON UPDATE CASCADE;
 Z   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_AddressType_FK";
       public       postgres    false    2717    197    199         �
           2606    16774 "   AccountRole AccountRole_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;
 P   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_Account_FK";
       public       postgres    false    196    2697    198         �
           2606    16779 (   AccountRole AccountRole_PrivilegeType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PrivilegeType_FK" FOREIGN KEY ("PrivilegeType") REFERENCES public."PrivilegeType"("PrivilegeTypeId");
 V   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PrivilegeType_FK";
       public       postgres    false    2723    198    200         �
           2606    16784 #   AccountRole AccountRole_RoleType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_RoleType_FK" FOREIGN KEY ("RoleType") REFERENCES public."RoleType"("RoleTypeId");
 Q   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_RoleType_FK";
       public       postgres    false    2727    198    201         �
           2606    16789     UserRole UserRole_AccountRole_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_AccountRole_FK" FOREIGN KEY ("AccountRoleId") REFERENCES public."AccountRole"("AccountRoleId") ON UPDATE CASCADE;
 N   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_AccountRole_FK";
       public       postgres    false    198    2709    203         �
           2606    16794    UserRole UserRole_User_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_User_FK" FOREIGN KEY ("UserId") REFERENCES public."User"("UserId") ON UPDATE CASCADE;
 G   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_User_FK";
       public       postgres    false    202    2731    203         �
           2606    16799    User User_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId");
 B   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_Account_FK";
       public       postgres    false    196    202    2697                                                                                                                                                                                                                                                                                      2875.dat                                                                                            0000600 0004000 0002000 00000003154 13444017250 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	4eda8f0f-ef3c-427a-85d9-2847eb04e319	Number1 	Stanislav Account                                 	t	2	3	60	1	2019-03-18 13:54:58.440163	2019-03-18 13:54:58.440163
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


                                                                                                                                                                                                                                                                                                                                                                                                                    2876.dat                                                                                            0000600 0004000 0002000 00000004330 13444017250 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	\N	\N	\N	Kyiv                                              	Ukraine                                           	Kiev region                                       	\N	UA	2019-03-18 14:06:47.051571	2019-03-18 14:06:47.051571
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


                                                                                                                                                                                                                                                                                                        2877.dat                                                                                            0000600 0004000 0002000 00000002607 13444017250 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	61599863-4a42-4bd5-90a7-6cb79420a634	1	Administrator                           	1	3	2019-03-18 14:53:25.6479	2019-03-18 14:53:25.6479
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


                                                                                                                         2878.dat                                                                                            0000600 0004000 0002000 00000000477 13444017250 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Billing                                                                                             	2019-03-18 14:57:22.713448	2019-03-18 14:57:22.713448
2	Physical                                                                                            	2019-03-18 14:57:45.453377	2019-03-18 14:57:45.453377
\.


                                                                                                                                                                                                 2879.dat                                                                                            0000600 0004000 0002000 00000000734 13444017250 0014267 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	None                                                                                                	2019-03-18 15:00:57.553243	2019-03-18 15:00:57.553243
2	View                                                                                                	2019-03-18 15:01:19.657324	2019-03-18 15:01:19.657324
3	Edit                                                                                                	2019-03-18 15:02:34.868281	2019-03-18 15:02:34.868281
\.


                                    2880.dat                                                                                            0000600 0004000 0002000 00000003061 13444017250 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	APPLICATION_ADMINISTRATOR                                                                           	2019-03-18 15:03:21.693022	2019-03-18 15:03:21.693022
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


                                                                                                                                                                                                                                                                                                                                                                                                                                                                               2881.dat                                                                                            0000600 0004000 0002000 00000010355 13444017250 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10	5024abbf-804b-4007-b534-0edfd4f1b207	irina                                                                                               	10	Irina                                             	Alekseevna                                                                                          	\N	test                          	test                          	\N	f	t	2	uk-UA     	2019-03-18 22:37:13.207041	2019-03-18 22:37:13.207041
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


                                                                                                                                                                                                                                                                                   2882.dat                                                                                            0000600 0004000 0002000 00000001107 13444017250 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	2019-03-18 15:27:34.165981	2019-03-18 15:27:34.165981
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


                                                                                                                                                                                                                                                                                                                                                                                                                                                         restore.sql                                                                                         0000600 0004000 0002000 00000043750 13444017250 0015375 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_Account_FK";
ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_User_FK";
ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_AccountRole_FK";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_RoleType_FK";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PrivilegeType_FK";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_Account_FK";
ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_AddressType_FK";
ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_Account_FK";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_UserGuid";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_LogonName";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_AccountId";
ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_PK";
ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_pkey";
ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_UserId";
ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_AccountRoleId";
ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_pkey";
ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_PK";
ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_pkey";
ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_PK";
ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_pkey";
ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_U_AddressTypeName";
ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_PK";
ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_pkey";
ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountNumber";
ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountGuid";
ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_PK";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_pkey";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountRoleGuid";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountId";
ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PK";
ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_pkey";
ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_PK";
DROP TABLE public."UserRole";
DROP TABLE public."User";
DROP TABLE public."RoleType";
DROP TABLE public."PrivilegeType";
DROP TABLE public."AddressType";
DROP TABLE public."AccountRole";
DROP TABLE public."AccountAddress";
DROP TABLE public."Account";
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
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
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" ("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."Account" ("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2875.dat';

--
-- Data for Name: AccountAddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountAddress" ("AccountId", "AddressType", "AddressLine1", "AddressLine2", "AddressLine3", "City", "County", "StateProvince", "PostalCode", "CountryTwoLetterCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."AccountAddress" ("AccountId", "AddressType", "AddressLine1", "AddressLine2", "AddressLine3", "City", "County", "StateProvince", "PostalCode", "CountryTwoLetterCode", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2876.dat';

--
-- Data for Name: AccountRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountRole" ("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."AccountRole" ("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2877.dat';

--
-- Data for Name: AddressType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AddressType" ("AddressTypeId", "AddressTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."AddressType" ("AddressTypeId", "AddressTypeName", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2878.dat';

--
-- Data for Name: PrivilegeType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PrivilegeType" ("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."PrivilegeType" ("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2879.dat';

--
-- Data for Name: RoleType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RoleType" ("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."RoleType" ("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2880.dat';

--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CultureCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."User" ("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CultureCode", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2881.dat';

--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRole" ("UserId", "AccountRoleId", "CreatedUtc", "ModifiedUtc") FROM stdin;
\.
COPY public."UserRole" ("UserId", "AccountRoleId", "CreatedUtc", "ModifiedUtc") FROM '$$PATH$$/2882.dat';

--
-- Name: AccountAddress AccountAddress_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_PK" UNIQUE ("AccountId");


--
-- Name: AccountAddress AccountAddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_pkey" PRIMARY KEY ("AccountId");


--
-- Name: AccountRole AccountRole_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PK" UNIQUE ("AccountRoleId");


--
-- Name: AccountRole AccountRole_U_AccountId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountId" UNIQUE ("AccountId");


--
-- Name: AccountRole AccountRole_U_AccountRoleGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountRoleGuid" UNIQUE ("AccountRoleGuid");


--
-- Name: AccountRole AccountRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_pkey" PRIMARY KEY ("AccountRoleId");


--
-- Name: Account Account_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_PK" UNIQUE ("AccountId");


--
-- Name: Account Account_U_AccountGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountGuid" UNIQUE ("AccountGuid");


--
-- Name: Account Account_U_AccountNumber; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountNumber" UNIQUE ("AccountNumber");


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("AccountId");


--
-- Name: AddressType AddressType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_PK" UNIQUE ("AddressTypeId");


--
-- Name: AddressType AddressType_U_AddressTypeName; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_U_AddressTypeName" UNIQUE ("AddressTypeName");


--
-- Name: AddressType AddressType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_pkey" PRIMARY KEY ("AddressTypeId");


--
-- Name: PrivilegeType PrivilegeType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_PK" UNIQUE ("PrivilegeTypeId");


--
-- Name: PrivilegeType PrivilegeType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_pkey" PRIMARY KEY ("PrivilegeTypeId");


--
-- Name: RoleType RoleType_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_PK" UNIQUE ("RoleTypeId");


--
-- Name: RoleType RoleType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_pkey" PRIMARY KEY ("RoleTypeId");


--
-- Name: UserRole UserRole_U_AccountRoleId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_AccountRoleId" UNIQUE ("AccountRoleId");


--
-- Name: UserRole UserRole_U_UserId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_UserId" UNIQUE ("UserId");


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserId", "AccountRoleId");


--
-- Name: User User_PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_PK" UNIQUE ("UserId");


--
-- Name: User User_U_AccountId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_AccountId" UNIQUE ("AccountId");


--
-- Name: User User_U_LogonName; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_LogonName" UNIQUE ("LogonName");


--
-- Name: User User_U_UserGuid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_UserGuid" UNIQUE ("UserGuid");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserId");


--
-- Name: AccountAddress AccountAddress_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;


--
-- Name: AccountAddress AccountAddress_AddressType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_AddressType_FK" FOREIGN KEY ("AddressType") REFERENCES public."AddressType"("AddressTypeId") ON UPDATE CASCADE;


--
-- Name: AccountRole AccountRole_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;


--
-- Name: AccountRole AccountRole_PrivilegeType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PrivilegeType_FK" FOREIGN KEY ("PrivilegeType") REFERENCES public."PrivilegeType"("PrivilegeTypeId");


--
-- Name: AccountRole AccountRole_RoleType_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_RoleType_FK" FOREIGN KEY ("RoleType") REFERENCES public."RoleType"("RoleTypeId");


--
-- Name: UserRole UserRole_AccountRole_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_AccountRole_FK" FOREIGN KEY ("AccountRoleId") REFERENCES public."AccountRole"("AccountRoleId") ON UPDATE CASCADE;


--
-- Name: UserRole UserRole_User_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_User_FK" FOREIGN KEY ("UserId") REFERENCES public."User"("UserId") ON UPDATE CASCADE;


--
-- Name: User User_Account_FK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId");


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        