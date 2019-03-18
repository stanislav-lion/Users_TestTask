PGDMP         ,                w            UsersNew    10.6    10.6 9    E           0    0    ENCODING    ENCODING     #   SET client_encoding = 'SQL_ASCII';
                       false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            H           1262    16416    UsersNew    DATABASE     �   CREATE DATABASE "UsersNew" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "UsersNew";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            I           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            J           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16430    Account    TABLE     �  CREATE TABLE public."Account" (
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
       public         postgres    false    3            �            1259    16435    AccountAddress    TABLE       CREATE TABLE public."AccountAddress" (
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
       public         postgres    false    3            �            1259    16443    AccountRole    TABLE     g  CREATE TABLE public."AccountRole" (
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
       public         postgres    false    3            �            1259    16448    AddressType    TABLE     �   CREATE TABLE public."AddressType" (
    "AddressTypeId" integer NOT NULL,
    "AddressTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
 !   DROP TABLE public."AddressType";
       public         postgres    false    3            �            1259    16453    PrivilegeType    TABLE     �   CREATE TABLE public."PrivilegeType" (
    "PrivilegeTypeId" integer NOT NULL,
    "PrivilegeTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
 #   DROP TABLE public."PrivilegeType";
       public         postgres    false    3            �            1259    16425    RoleType    TABLE     �   CREATE TABLE public."RoleType" (
    "RoleTypeId" integer NOT NULL,
    "RoleTypeName" character(100) NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
    DROP TABLE public."RoleType";
       public         postgres    false    3            �            1259    16458    User    TABLE     u  CREATE TABLE public."User" (
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
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
    DROP TABLE public."User";
       public         postgres    false    3            �            1259    16463    UserRole    TABLE     �   CREATE TABLE public."UserRole" (
    "UserId" integer NOT NULL,
    "AccountRoleId" integer NOT NULL,
    "CreatedUtc" timestamp without time zone NOT NULL,
    "ModifiedUtc" timestamp without time zone NOT NULL
);
    DROP TABLE public."UserRole";
       public         postgres    false    3            <          0    16430    Account 
   TABLE DATA               �   COPY public."Account" ("AccountId", "AccountGuid", "AccountNumber", "AccountName", "IsEnabled", "TimeZone", "PasswordExpirationPeriodInDays", "DataStorageTimeHrs", "NumberOfCodeManagementApps", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    197   rM       =          0    16435    AccountAddress 
   TABLE DATA               �   COPY public."AccountAddress" ("AccountId", "AddressType", "AddressLine1", "AddressLine2", "AddressLine3", "City", "County", "StateProvince", "PostalCode", "CountryTwoLetterCode", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    198   �O       >          0    16443    AccountRole 
   TABLE DATA               �   COPY public."AccountRole" ("AccountRoleId", "AccountRoleGuid", "AccountId", "RoleName", "RoleType", "PrivilegeType", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    199   �P       ?          0    16448    AddressType 
   TABLE DATA               h   COPY public."AddressType" ("AddressTypeId", "AddressTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    200   �R       @          0    16453    PrivilegeType 
   TABLE DATA               n   COPY public."PrivilegeType" ("PrivilegeTypeId", "PrivilegeTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    201   9S       ;          0    16425    RoleType 
   TABLE DATA               _   COPY public."RoleType" ("RoleTypeId", "RoleTypeName", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    196   �S       A          0    16458    User 
   TABLE DATA                  COPY public."User" ("UserId", "UserGuid", "LogonName", "AccountId", "FirstName", "LastName", "MiddleName", "PasswordSalt", "PasswordHash", "PasswordChangeUtc", "PasswordMustBeChanged", "IsLogonEnabled", "TimeZone", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    202   �T       B          0    16463    UserRole 
   TABLE DATA               \   COPY public."UserRole" ("UserId", "AccountRoleId", "CreatedUtc", "ModifiedUtc") FROM stdin;
    public       postgres    false    203   �W       �
           2606    16475     AccountAddress AccountAddress_PK 
   CONSTRAINT     f   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_PK" UNIQUE ("AccountId");
 N   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_PK";
       public         postgres    false    198            �
           2606    16439 "   AccountAddress AccountAddress_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_pkey" PRIMARY KEY ("AccountId");
 P   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_pkey";
       public         postgres    false    198            �
           2606    16483    AccountRole AccountRole_PK 
   CONSTRAINT     d   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PK" UNIQUE ("AccountRoleId");
 H   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PK";
       public         postgres    false    199            �
           2606    16485 #   AccountRole AccountRole_U_AccountId 
   CONSTRAINT     i   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountId" UNIQUE ("AccountId");
 Q   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountId";
       public         postgres    false    199            �
           2606    16487 )   AccountRole AccountRole_U_AccountRoleGuid 
   CONSTRAINT     u   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_U_AccountRoleGuid" UNIQUE ("AccountRoleGuid");
 W   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_U_AccountRoleGuid";
       public         postgres    false    199            �
           2606    16447    AccountRole AccountRole_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_pkey" PRIMARY KEY ("AccountRoleId");
 J   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_pkey";
       public         postgres    false    199            �
           2606    16477    Account Account_PK 
   CONSTRAINT     X   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_PK" UNIQUE ("AccountId");
 @   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_PK";
       public         postgres    false    197            �
           2606    16479    Account Account_U_AccountGuid 
   CONSTRAINT     e   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountGuid" UNIQUE ("AccountGuid");
 K   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountGuid";
       public         postgres    false    197            �
           2606    16481    Account Account_U_AccountNumber 
   CONSTRAINT     i   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_U_AccountNumber" UNIQUE ("AccountNumber");
 M   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_U_AccountNumber";
       public         postgres    false    197            �
           2606    16434    Account Account_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("AccountId");
 B   ALTER TABLE ONLY public."Account" DROP CONSTRAINT "Account_pkey";
       public         postgres    false    197            �
           2606    16550    AddressType AddressType_PK 
   CONSTRAINT     d   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_PK" UNIQUE ("AddressTypeId");
 H   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_PK";
       public         postgres    false    200            �
           2606    16552 )   AddressType AddressType_U_AddressTypeName 
   CONSTRAINT     u   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_U_AddressTypeName" UNIQUE ("AddressTypeName");
 W   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_U_AddressTypeName";
       public         postgres    false    200            �
           2606    16452    AddressType AddressType_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public."AddressType"
    ADD CONSTRAINT "AddressType_pkey" PRIMARY KEY ("AddressTypeId");
 J   ALTER TABLE ONLY public."AddressType" DROP CONSTRAINT "AddressType_pkey";
       public         postgres    false    200            �
           2606    16493    PrivilegeType PrivilegeType_PK 
   CONSTRAINT     j   ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_PK" UNIQUE ("PrivilegeTypeId");
 L   ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_PK";
       public         postgres    false    201            �
           2606    16457     PrivilegeType PrivilegeType_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public."PrivilegeType"
    ADD CONSTRAINT "PrivilegeType_pkey" PRIMARY KEY ("PrivilegeTypeId");
 N   ALTER TABLE ONLY public."PrivilegeType" DROP CONSTRAINT "PrivilegeType_pkey";
       public         postgres    false    201            �
           2606    16648    RoleType RoleType_PK 
   CONSTRAINT     [   ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_PK" UNIQUE ("RoleTypeId");
 B   ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_PK";
       public         postgres    false    196            �
           2606    16429    RoleType RoleType_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public."RoleType"
    ADD CONSTRAINT "RoleType_pkey" PRIMARY KEY ("RoleTypeId");
 D   ALTER TABLE ONLY public."RoleType" DROP CONSTRAINT "RoleType_pkey";
       public         postgres    false    196            �
           2606    16631 !   UserRole UserRole_U_AccountRoleId 
   CONSTRAINT     k   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_AccountRoleId" UNIQUE ("AccountRoleId");
 O   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_AccountRoleId";
       public         postgres    false    203            �
           2606    16505    UserRole UserRole_U_UserId 
   CONSTRAINT     ]   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_U_UserId" UNIQUE ("UserId");
 H   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_U_UserId";
       public         postgres    false    203            �
           2606    16467    UserRole UserRole_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserId", "AccountRoleId");
 D   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_pkey";
       public         postgres    false    203    203            �
           2606    16497    User User_PK 
   CONSTRAINT     O   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_PK" UNIQUE ("UserId");
 :   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_PK";
       public         postgres    false    202            �
           2606    16499    User User_U_AccountId 
   CONSTRAINT     [   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_AccountId" UNIQUE ("AccountId");
 C   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_AccountId";
       public         postgres    false    202            �
           2606    16501    User User_U_LogonName 
   CONSTRAINT     [   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_LogonName" UNIQUE ("LogonName");
 C   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_LogonName";
       public         postgres    false    202            �
           2606    16503    User User_U_UserGuid 
   CONSTRAINT     Y   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_U_UserGuid" UNIQUE ("UserGuid");
 B   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_U_UserGuid";
       public         postgres    false    202            �
           2606    16462    User User_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserId");
 <   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_pkey";
       public         postgres    false    202            �
           2606    16679 (   AccountAddress AccountAddress_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;
 V   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_Account_FK";
       public       postgres    false    2707    197    198            �
           2606    16649 ,   AccountAddress AccountAddress_AddressType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountAddress"
    ADD CONSTRAINT "AccountAddress_AddressType_FK" FOREIGN KEY ("AddressType") REFERENCES public."AddressType"("AddressTypeId") ON UPDATE CASCADE;
 Z   ALTER TABLE ONLY public."AccountAddress" DROP CONSTRAINT "AccountAddress_AddressType_FK";
       public       postgres    false    2725    200    198            �
           2606    16684 "   AccountRole AccountRole_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId") ON UPDATE CASCADE;
 P   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_Account_FK";
       public       postgres    false    2707    199    197            �
           2606    16659 (   AccountRole AccountRole_PrivilegeType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_PrivilegeType_FK" FOREIGN KEY ("PrivilegeType") REFERENCES public."PrivilegeType"("PrivilegeTypeId");
 V   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_PrivilegeType_FK";
       public       postgres    false    2729    199    201            �
           2606    16654 #   AccountRole AccountRole_RoleType_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."AccountRole"
    ADD CONSTRAINT "AccountRole_RoleType_FK" FOREIGN KEY ("RoleType") REFERENCES public."RoleType"("RoleTypeId");
 Q   ALTER TABLE ONLY public."AccountRole" DROP CONSTRAINT "AccountRole_RoleType_FK";
       public       postgres    false    2699    199    196            �
           2606    16664     UserRole UserRole_AccountRole_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_AccountRole_FK" FOREIGN KEY ("AccountRoleId") REFERENCES public."AccountRole"("AccountRoleId") ON UPDATE CASCADE;
 N   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_AccountRole_FK";
       public       postgres    false    199    2719    203            �
           2606    16669    UserRole UserRole_User_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_User_FK" FOREIGN KEY ("UserId") REFERENCES public."User"("UserId") ON UPDATE CASCADE;
 G   ALTER TABLE ONLY public."UserRole" DROP CONSTRAINT "UserRole_User_FK";
       public       postgres    false    203    2739    202            �
           2606    16674    User User_Account_FK    FK CONSTRAINT     �   ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_Account_FK" FOREIGN KEY ("AccountId") REFERENCES public."Account"("AccountId");
 B   ALTER TABLE ONLY public."User" DROP CONSTRAINT "User_Account_FK";
       public       postgres    false    202    197    2707            <   
  x����j\1�k�)��E���ΥIp�6�H�����I�>2���&K��k>Μ#4�]�ptP�I �^�gNZ+a1wO߫q1_Nr�|��妵O���gN�2�4�aG�yA�o!��#� �cꔜ@sӌ}�PZ��F*�I)���ss�G��ς;�in�i-	�dٴ���.�z��59�Sr�٣D�gG���K]������>��>�d��8)�
<�j�}Č�Qj�lH��z����"nW�\�A6��{�ܼt'�+6�ы+��s�,�kwis�F�.���+d���{Ʌ�SP`��g/�O���D�,&.��S�t~�����&�#|�RC�J:�Zr�����ƴ�Or�?\e���ŕ�n�l��֫�\Ls��PG�T۬l����g�z��cx�n���f2��-F5F��!��2��Pe~?��x��K�b������r��u���o_!��$�F���=��J��&bQ�%J�|���^{�}ɐ�9U�����Z���Yv      =   +  x�Փ�J�@F׹O��0����\JE��E�&�`�j1|{�V��2$2��0|s��������B�O:�f��.�<Y�����)4��'��67qt+.Vhs��k/�
���h���#&LI�d�B;4���9�U�:2��v?I�"�C�x���s����I�y4��2�^	f����b�{�r�H&�xJ�����ϔ�{8h(ɐ[I�0F`����+~����$��Q�&����Pס{��x��O�h���I3g�j�@�<.q[��y	�u���W�LE�eҐ;��_; �X�!      >     x����n1Ek�+����tA�T��ti��`��k���7)��ػ;� W�x/I.���c �� m(�	bo�c�A��������r�/�ӧ�?;#� �?��V�%J*
�]ǂ#�ȳ��P��-BO[ms
Ȏ���7yeYC^��=�䃛q��>!�B��k�朒6��������ٳ�5Ђ�(�+��k��@ئ�S$C! �f�f)-X����{���.L�Ӯ1�W'-!!�2�S*�>3d"�#Q��Äw\ʫʢ���W$]�c�u��H�l:`K<EQ���{x}z:�^n�߱����b#�I>�8����iBnrJ�6��ѩq�}�����q�yGp%^��^�|��lE*PG>�d��`�j���=�}9O��xå�0�>5VRʂ$iכK���ʸA���63*W1�[�����4��������y�)IwI;��:jI9��;`��H��[U�м9;��u�B�Ǔ����7UyŰH��;���X�� E"�      ?   P   x�3�t�����KW�%�420��50�5�P04�25�22�37461��#�e��QY����C_Ǚ�Ꙙ�������� �U3      @   `   x���+�0 Q���h�I��<�BRQ��'��k�Y��:��9`O�z��i��jr��A�[o��9�T\��-��߳�Jp9f�4 �"�aI      ;     x���͊� ��>E_���7�Rd�٥������-$��t��ˏqdȏ�-_Sɫ�)��N�����A@�=S~f�Ĥ��#�r
�IP(����0�N8�Dj��t�2�w�^�E� �Y��L��>�8����D3+�fqO	s@>�����gU���Pۦ��ݼ�c��]�t\P���$����O����g=���V�坄A��K5�����W��ӎYb�6|����%���w
q�������O ��h�;	f]�x��3�Qƶ��I��`�� ��      A   �  x��W�j�0}��������+]�0e��m�d�K�gC�dk�~
c,kYVCeL^��s�O��5B��)t^(��0�xĈe���4��0n�!��i��r ��o����nzZ��}���D�p�<�/\���@{P�$z!�@�BZ)\)j%�5tj �L� /;a�c��E�bB��%�0�]��������z1�;N�qӭ󸝪MV�%^IY�֘r����`�[˲��J)L�(XyU�RVi��Jg���k��g�%E��b�4�ixc�>l�MV�%\�n�u��տ��@�4eW��cq�4��M/���G�� �G�S޽�-�#���b�8�wS�«�)n�h�bwjl��cJ�w�#������6��,as��FgRnӔ,�ӷ�˯�-?�Dō�ɐ��3���T�0*6��%W>�&'���1ؑ��!��W�L����4%K�$�ǚ��sɮ�j5;$� 5\�9G���ҧ��/Y�Yx+5{ɲt l�n3V�	|XLwS���d�\r+�[-��w5X�8׹N�a�S��rqH�5=e�U�!���Ha�]L�üe��hU=�x��uɿ���x�8���Q8LN�e���
=��:�c�1����r���n1M��pxZ�U+��K�b��^��`�a-�dJۙ��`��p�r`糃M��+��n�����|�|��ZD-�f|�y�P��6M�����      B   �   x�}���@�3T���u`jI�u�'�1�%n�|\�Ѝ�þd.5���7B��\>��:������|!4��.$�����������a@t� I�j+O�Z��h�E� N�	-�\��Vf7C��<(�f��y�.�xP��b?~	�mQ     