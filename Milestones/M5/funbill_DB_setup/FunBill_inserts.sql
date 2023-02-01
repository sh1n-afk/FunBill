USE funbillDB;

-- Accounts -- 
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (000000001, "test@mail.com", "PaytoPlay", 12345678, 0, STR_TO_DATE('15-01-1997', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (000000002, "totallyreal@mail.com", "PaymePlz", 87654321, 5, STR_TO_DATE('19-05-1999', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (000000003, "notRealAtAll@mail.com", "Broke", 000000, 100, STR_TO_DATE('23-09-1990', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (000000004, "admin@mail.com", "admin", 100000, 0, STR_TO_DATE('23-10-1980', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (0000000026, "toby@gmail.com", "tobey", 111111, 0, STR_TO_DATE('25-01-1999', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (0000000027, "kevin@mail.com", "kevin", 87654321, 5, STR_TO_DATE('19-05-2000', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (0000000028, "poornank@mail.com", "poornank", 222222, 100, STR_TO_DATE('23-09-1999', '%d-%m-%Y'));
INSERT INTO Account (account_Id, email, userName, userPassword, numTransactions, birthday) VALUES (0000000029, "denyse@mail.com", "densye", 333333, 0, STR_TO_DATE('23-10-2000', '%d-%m-%Y'));
SELECT * FROM Account;

-- Registered User -- 
INSERT INTO registeredUser (registeredUser_id, Account) VALUES (000000005 ,000000003);
INSERT INTO registeredUser (registeredUser_id, Account) VALUES (000000006 ,000000002);
INSERT INTO registeredUser (registeredUser_id, Account) VALUES (000000007 ,000000001);
SELECT * FROM registeredUser;

-- FUNBILL Transaction Storage -- 
INSERT INTO funBillTransactionStorage (funbillTransactionStorage_id, owner, numLogs) VALUES (000000008 ,000000001, 1);
INSERT INTO funBillTransactionStorage (funbillTransactionStorage_id, owner, numLogs) VALUES (000000009 ,000000002, 2);
INSERT INTO funBillTransactionStorage (funbillTransactionStorage_id, owner, numLogs) VALUES (000000010 ,000000003, 0);
SELECT * FROM funBillTransactionStorage;

-- Category --
INSERT INTO Categories (categories_id, categoryType) VALUES (000000017 ,"Other");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000018 ,"Rent");
INSERT INTO Categories (categories_id) VALUES (000000019);
INSERT INTO Categories (categories_id, categoryType) VALUES (000000020 ,"Food");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000021 ,"Gas");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000022, "Outings");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000023, "Shopping");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000024, "None");
INSERT INTO Categories (categories_id, categoryType) VALUES (000000025, "Events");
SELECT * FROM Categories;

-- funBillTransaction -- 
INSERT INTO funBillTransaction (funBillTransaction_id, Category, Title, Completed, dateCreated, totalAmountDue, individualAmount) VALUES (000000014 ,000000017, "First Payment", 1, STR_TO_DATE('23-10-2022', '%d-%m-%Y'), 0, 10);
INSERT INTO funBillTransaction (funBillTransaction_id, Category, Title, Completed, dateCreated,  totalAmountDue, individualAmount) VALUES (000000015 ,000000018, "New Payment", 0, STR_TO_DATE('23-10-2022', '%d-%m-%Y'), 100, 50);
INSERT INTO funBillTransaction (funBillTransaction_id, Category, Title, Completed, dateCreated, totalAmountDue, individualAmount) VALUES (000000016 ,000000019, "Rent for this month", STR_TO_DATE('23-10-2022', '%d-%m-%Y'), 0, 100, 100);
INSERT INTO funBillTransaction (funBillTransaction_id, Title, Completed, dateCreated, totalAmountDue, individualAmount) VALUES (100000000 , "Test Payment", 0, STR_TO_DATE('31-10-2022', '%d-%m-%Y'), 100, 50);
INSERT INTO funBillTransaction (funBillTransaction_id, Category, Title, Completed, dateCreated, totalAmountDue, individualAmount) VALUES (200000000 , 19,"Test Payment 2", 0, STR_TO_DATE('28-10-2022', '%d-%m-%Y'), 100, 50);
SELECT * FROM funBillTransaction;

-- funBillTransactionLog -- 
INSERT INTO funBillTransactionLog (funBillTransactionLog_id, FunBillTransactionStorage, FunBillTransaction) VALUES (000000011 ,000000008, 000000014);
INSERT INTO funBillTransactionLog (funBillTransactionLog_id, FunBillTransactionStorage, FunBillTransaction) VALUES (000000012 ,000000009, 000000015);
INSERT INTO funBillTransactionLog (funBillTransactionLog_id, FunBillTransactionStorage, FunBillTransaction) VALUES (000000013 ,000000009, 000000016);
SELECT * FROM funBillTransactionLog;

-- Singles --
INSERT INTO Singles(Singles_id, member) VALUES (000000033, 0000000029);
INSERT INTO Singles(Singles_id, member) VALUES (000000034, 0000000026);
INSERT INTO Singles(Singles_id, member) VALUES (000000035, 0000000002);

-- Pay Request --


-- PERMISSIONS --

	-- transactionPermissions --
	INSERT INTO transactionPermissions(transactionPermissions_id, Account, FunbillTransaction) VALUES (000000030, 0000000029, 000000014);
    INSERT INTO transactionPermissions(transactionPermissions_id, Account, FunbillTransaction) VALUES (000000031, 0000000028, 000000015);
    INSERT INTO transactionPermissions(transactionPermissions_id, Account, FunbillTransaction) VALUES (000000032, 0000000027, 000000016);
    
    -- Singles Permissions -- 
    INSERT INTO singlesPermissions(singlesPermissions_id, Account, Singles) VALUES (000000036, 0000000003, 000000033);
    INSERT INTO singlesPermissions(singlesPermissions_id, Account, Singles) VALUES (000000037, 0000000028, 000000034);
    INSERT INTO singlesPermissions(singlesPermissions_id, Account, Singles) VALUES (000000038, 0000000027, 000000035);
