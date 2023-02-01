USE funbillDB;

DELETE FROM Account WHERE account_Id = 000000004;
UPDATE Account SET userName = "NewUserName" WHERE account_Id = 000000003;
SELECT * FROM Account;

DELETE FROM registeredUser WHERE registeredUser_id = 000000006;
UPDATE registeredUser SET Account = "300000000" WHERE registeredUser_id = 000000007;
SELECT * FROM registeredUser;

DELETE FROM funBillTransaction WHERE funBillTransaction_id = 200000000;
UPDATE funBillTransaction SET Title =  "Rent Due" WHERE Category = 000000018;
SELECT * FROM funBillTransaction;

DELETE FROM Categories WHERE categories_id = 000000024;
UPDATE Categories SET categoryType = "RENT" WHERE categories_id = 000000017;
SELECT * FROM Categories;

DELETE FROM funBillTransactionStorage WHERE funBillTransactionStorage_id = 000000008;
UPDATE funBillTransactionStorage SET numLogs = 20 WHERE funBillTransactionStorage_id = 000000009;
SELECT * FROM funBillTransactionStorage;

DELETE FROM funBillTransactionLog WHERE funBillTransactionLog_id = 000000011;
UPDATE funBillTransactionLog SET FunBillTransactionStorage = 000000010 WHERE funBillTransactionLog_id = 000000012;
SELECT * FROM funBillTransactionLog;
