--
-- TOC entry 2878 (class 0 OID 16443)
-- Dependencies: 199
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