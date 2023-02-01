-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS funbillDB;
CREATE DATABASE IF NOT EXISTS funbillDB;
USE funbillDB;
-- -----------------------------------------------------
-- Table `Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Account` ;

CREATE TABLE IF NOT EXISTS `Account` (
  `account_Id` INT(9) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `userName` VARCHAR(15) NOT NULL,
  `userPassword` VARCHAR(8) NOT NULL,
  `numTransactions` INT ZEROFILL NULL,
  `birthday` DATE NULL,
  PRIMARY KEY (`account_Id`, `email`, `userName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `generalUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `generalUser` ;

CREATE TABLE IF NOT EXISTS `generalUser` (
  `generalUser_id` INT NOT NULL,
  PRIMARY KEY (`generalUser_id`),
  CONSTRAINT `FK_account_genUser`
    FOREIGN KEY (`generalUser_id`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Search`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Search` ;

CREATE TABLE IF NOT EXISTS `Search` (
  `search_id` INT(9) NOT NULL,
  `searchText` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`search_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registeredUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `registeredUser` ;

CREATE TABLE IF NOT EXISTS `registeredUser` (
  `registeredUser_id` INT(9) NOT NULL,
  `Account` INT NOT NULL,
  `registeredUsercol` INT NULL,
  PRIMARY KEY (`registeredUser_id`, `Account`),
  INDEX `account_registerUser_idx` (`Account` ASC) VISIBLE,
  CONSTRAINT `FK_account_registerUser`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Admin` ;

CREATE TABLE IF NOT EXISTS `Admin` (
  `admin_id(9)` INT NOT NULL,
  `Account(9)` INT NOT NULL,
  PRIMARY KEY (`admin_id(9)`, `Account(9)`),
  INDEX `account_admin_idx` (`Account(9)` ASC) VISIBLE,
  CONSTRAINT `FK_account_admin`
    FOREIGN KEY (`Account(9)`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `searchPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `searchPermissions` ;

CREATE TABLE IF NOT EXISTS `searchPermissions` (
  `searchPermissions_id` INT(9) NOT NULL,
  `Search` INT(9) NOT NULL,
  `Registered User` INT(9) NOT NULL,
  PRIMARY KEY (`searchPermissions_id`),
  INDEX `search_searchPermissions_idx` (`Search` ASC) VISIBLE,
  INDEX `registeredUser_searchPermissions_idx` (`Registered User` ASC) VISIBLE,
  CONSTRAINT `FK_search_searchPermissions`
    FOREIGN KEY (`Search`)
    REFERENCES `Search` (`search_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_registeredUser_searchPermissions`
    FOREIGN KEY (`Registered User`)
    REFERENCES `registeredUser` (`registeredUser_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funBillTransactionStorage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funBillTransactionStorage` ;

CREATE TABLE IF NOT EXISTS `funBillTransactionStorage` (
  `funbillTransactionStorage_id` INT(9) NOT NULL,
  `owner` INT(9) NOT NULL,
  `numLogs` INT ZEROFILL NULL,
  PRIMARY KEY (`funbillTransactionStorage_id`),
  INDEX `FK_Account_FunbillTransactionStorage_idx` (`owner` ASC) VISIBLE,
  CONSTRAINT `FK_Account_FunbillTransactionStorage`
    FOREIGN KEY (`owner`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transactionStoragePermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transactionStoragePermissions` ;

CREATE TABLE IF NOT EXISTS `transactionStoragePermissions` (
  `transactionStoragePermissions_id` INT(9) NOT NULL,
  `FunBillTransactionStorage` INT(9) NOT NULL,
  `Search` INT(9) NOT NULL,
  PRIMARY KEY (`transactionStoragePermissions_id`),
  INDEX `Search_TransactionStoragePermission_idx` (`Search` ASC) VISIBLE,
  INDEX `FunBillTransactionStorage_TransactionStoragePermissions_idx` (`FunBillTransactionStorage` ASC) VISIBLE,
  CONSTRAINT `FK_Search_TransactionStoragePermission`
    FOREIGN KEY (`Search`)
    REFERENCES `Search` (`search_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_FunBillTransactionStorage_TransactionStoragePermissions`
    FOREIGN KEY (`FunBillTransactionStorage`)
    REFERENCES `funBillTransactionStorage` (`funbillTransactionStorage_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Categories` ;

CREATE TABLE IF NOT EXISTS `Categories` (
  `categories_id` INT(9) NOT NULL,
  `categoryType` ENUM("Events", "Outings", "Shopping", "Gas", "Food", "Rent", "Other", "None") NOT NULL DEFAULT 'None',
  PRIMARY KEY (`categories_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currencyType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currencyType` ;

CREATE TABLE IF NOT EXISTS `currencyType` (
  `currencyType_id` INT NOT NULL,
  `type` ENUM("USD", "Pound", "Yen", "Canadian", "Pesos", "Other") NOT NULL DEFAULT 'Other',
  PRIMARY KEY (`currencyType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currenciesSupported`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currenciesSupported` ;

CREATE TABLE IF NOT EXISTS `currenciesSupported` (
  `currenciesSupported_id` INT NOT NULL,
  `CurrencyType` INT NOT NULL,
  PRIMARY KEY (`currenciesSupported_id`),
  INDEX `FK_CurrecnyType_CurrencySupported_idx` (`CurrencyType` ASC) VISIBLE,
  CONSTRAINT `FK_CurrecnyType_CurrencySupported`
    FOREIGN KEY (`CurrencyType`)
    REFERENCES `currencyType` (`currencyType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funBillTransaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funBillTransaction` ;

CREATE TABLE IF NOT EXISTS `funBillTransaction` (
  `funBillTransaction_id` INT(9) NOT NULL,
  `Category` INT(9) NULL,
  `CurrecySupported` INT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Completed` TINYINT NOT NULL DEFAULT 0,
  `dateCreated` DATE NOT NULL,
  `totalAmountDue` INT ZEROFILL NULL,
  `individualAmount` INT ZEROFILL NULL,
  PRIMARY KEY (`funBillTransaction_id`),
  INDEX `FK_Category_FunBillTransaction_idx` (`Category` ASC) VISIBLE,
  INDEX `FK_currenciesSupported_funTransaction_idx` (`CurrecySupported` ASC) VISIBLE,
  CONSTRAINT `FK_Category_FunBillTransaction`
    FOREIGN KEY (`Category`)
    REFERENCES `Categories` (`categories_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_currenciesSupported_funTransaction`
    FOREIGN KEY (`CurrecySupported`)
    REFERENCES `currenciesSupported` (`currenciesSupported_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funBillTransactionLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funBillTransactionLog` ;

CREATE TABLE IF NOT EXISTS `funBillTransactionLog` (
  `funBillTransactionLog_id` INT(9) NOT NULL,
  `FunBillTransactionStorage` INT(9) NOT NULL,
  `FunBillTransaction` INT(9) NOT NULL,
  PRIMARY KEY (`funBillTransactionLog_id`, `FunBillTransactionStorage`, `FunBillTransaction`),
  INDEX `FK_FunBillTransactionStorage_FunBillTransactionLog_idx` (`FunBillTransactionStorage` ASC) VISIBLE,
  INDEX `FK_FunBillTransaction_FunBillTransactionLogs_idx` (`FunBillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunBillTransactionStorage_FunBillTransactionLog`
    FOREIGN KEY (`FunBillTransactionStorage`)
    REFERENCES `funBillTransactionStorage` (`funbillTransactionStorage_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_FunBillTransaction_FunBillTransactionLogs`
    FOREIGN KEY (`FunBillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categoriesPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categoriesPermissions` ;

CREATE TABLE IF NOT EXISTS `categoriesPermissions` (
  `categoriesPermissions_id` INT(9) NOT NULL,
  `Categories` INT(9) NOT NULL,
  `Search` INT(9) NOT NULL,
  PRIMARY KEY (`categoriesPermissions_id`),
  INDEX `Search_CategoriesPerimission_FK_idx` (`Search` ASC) VISIBLE,
  INDEX `Categories_CategoriesPermissions_FK_idx` (`Categories` ASC) VISIBLE,
  CONSTRAINT `Search_CategoriesPerimission_FK`
    FOREIGN KEY (`Search`)
    REFERENCES `Search` (`search_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Categories_CategoriesPermissions_FK`
    FOREIGN KEY (`Categories`)
    REFERENCES `Categories` (`categories_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pin` ;

CREATE TABLE IF NOT EXISTS `Pin` (
  `pin_id` INT NOT NULL,
  `FunBillTransaction` INT NOT NULL,
  `pinValue` INT(5) NOT NULL,
  PRIMARY KEY (`pin_id`, `FunBillTransaction`),
  INDEX `FK_FunBilltransaction_Pin_idx` (`FunBillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunBilltransaction_Pin`
    FOREIGN KEY (`FunBillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transactionPaymentRequestDescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transactionPaymentRequestDescription` ;

CREATE TABLE IF NOT EXISTS `transactionPaymentRequestDescription` (
  `transactionPaymentRequestDescription_id` INT NOT NULL,
  `FunBillTransaction` INT NOT NULL,
  `description` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`transactionPaymentRequestDescription_id`, `FunBillTransaction`),
  INDEX `FK_FunBillTransaction_TransactionPaymentRequestDescription_idx` (`FunBillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunBillTransaction_TransactionPaymentRequestDescription`
    FOREIGN KEY (`FunBillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentType` ;

CREATE TABLE IF NOT EXISTS `paymentType` (
  `paymentType_id` INT NOT NULL,
  PRIMARY KEY (`paymentType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transactionPayment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transactionPayment` ;

CREATE TABLE IF NOT EXISTS `transactionPayment` (
  `transactionPayment_id` INT NOT NULL,
  `PaymentType` INT NOT NULL,
  `FunBillTransaction` INT NOT NULL,
  `payingAmount` INT NOT NULL,
  PRIMARY KEY (`transactionPayment_id`, `FunBillTransaction`, `PaymentType`),
  INDEX `FK_paymentType_TransactionPayment_idx` (`PaymentType` ASC) VISIBLE,
  INDEX `FK_funbillTransaction_transactionPayment_idx` (`FunBillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_paymentType_TransactionPayment`
    FOREIGN KEY (`PaymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_funbillTransaction_transactionPayment`
    FOREIGN KEY (`FunBillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `creditCard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `creditCard` ;

CREATE TABLE IF NOT EXISTS `creditCard` (
  `creditCard_id` INT NOT NULL,
  `zipcode` INT(5) NOT NULL,
  `PaymentType` INT NOT NULL,
  PRIMARY KEY (`creditCard_id`, `PaymentType`),
  INDEX `FK_PaymentType_CreditCard_idx` (`PaymentType` ASC) VISIBLE,
  CONSTRAINT `FK_PaymentType_CreditCard`
    FOREIGN KEY (`PaymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cash`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Cash` ;

CREATE TABLE IF NOT EXISTS `Cash` (
  `cash_id` INT NOT NULL,
  `cashTotalValue` INT NOT NULL,
  `PaymentType` INT NOT NULL,
  PRIMARY KEY (`cash_id`, `PaymentType`),
  INDEX `FK_PaymentType_Cash_idx` (`PaymentType` ASC) VISIBLE,
  CONSTRAINT `FK_PaymentType_Cash`
    FOREIGN KEY (`PaymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankAccount` ;

CREATE TABLE IF NOT EXISTS `bankAccount` (
  `Account_Num` INT NOT NULL,
  `PaymentType` INT NOT NULL,
  PRIMARY KEY (`Account_Num`, `PaymentType`),
  INDEX `FK_PaymentType_BankAccount_idx` (`PaymentType` ASC) VISIBLE,
  CONSTRAINT `FK_PaymentType_BankAccount`
    FOREIGN KEY (`PaymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `debitCard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `debitCard` ;

CREATE TABLE IF NOT EXISTS `debitCard` (
  `debitCard_id` INT NOT NULL,
  `BankAccount` INT NOT NULL,
  `Pin` INT NOT NULL,
  PRIMARY KEY (`debitCard_id`, `BankAccount`),
  INDEX `FK_BankAccount_DebitCard_idx` (`BankAccount` ASC) VISIBLE,
  CONSTRAINT `FK_BankAccount_DebitCard`
    FOREIGN KEY (`BankAccount`)
    REFERENCES `bankAccount` (`Account_Num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payRequest` ;

CREATE TABLE IF NOT EXISTS `payRequest` (
  `payRequest_id` INT NOT NULL,
  `payAmount` INT NOT NULL,
  `FunbillTransaction` INT NOT NULL,
  PRIMARY KEY (`payRequest_id`),
  INDEX `FK_FunbillTransaction_PayRequest_idx` (`FunbillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunbillTransaction_PayRequest`
    FOREIGN KEY (`FunbillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birthdayList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `birthdayList` ;

CREATE TABLE IF NOT EXISTS `birthdayList` (
  `birthdayList_id` INT NOT NULL,
  `Account` INT NOT NULL,
  `FunbillTransaction` INT NOT NULL,
  `birthDate` DATE NOT NULL,
  PRIMARY KEY (`birthdayList_id`),
  INDEX `FK_FunbillTransaction_BirthdayList_idx` (`FunbillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunbillTransaction_BirthdayList`
    FOREIGN KEY (`FunbillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `homeFeed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `homeFeed` ;

CREATE TABLE IF NOT EXISTS `homeFeed` (
  `homeFeed_id` INT NOT NULL,
  `RegisteredUser` INT NOT NULL,
  PRIMARY KEY (`homeFeed_id`),
  INDEX `FK_RegisteredUser_HomeFeed_idx` (`RegisteredUser` ASC) VISIBLE,
  CONSTRAINT `FK_RegisteredUser_HomeFeed`
    FOREIGN KEY (`RegisteredUser`)
    REFERENCES `registeredUser` (`registeredUser_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chat` ;

CREATE TABLE IF NOT EXISTS `chat` (
  `chat_id` INT NOT NULL,
  `numNewMessage` INT ZEROFILL NOT NULL,
  PRIMARY KEY (`chat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Groups` ;

CREATE TABLE IF NOT EXISTS `Groups` (
  `Groups_id` INT NOT NULL,
  `GroupTitle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Groups_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Singles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Singles` ;

CREATE TABLE IF NOT EXISTS `Singles` (
  `Singles_id` INT NOT NULL,
  `member` INT NOT NULL,
  PRIMARY KEY (`Singles_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `scanReceipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `scanReceipt` ;

CREATE TABLE IF NOT EXISTS `scanReceipt` (
  `scanReceipt_id` INT NOT NULL,
  `PayRequest` INT NOT NULL,
  `recieptImageLink` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`scanReceipt_id`),
  INDEX `FK_payRequest_scanReceipt_idx` (`PayRequest` ASC) VISIBLE,
  CONSTRAINT `FK_payRequest_scanReceipt`
    FOREIGN KEY (`PayRequest`)
    REFERENCES `payRequest` (`payRequest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chatPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chatPermissions` ;

CREATE TABLE IF NOT EXISTS `chatPermissions` (
  `chatPermissions_id` INT NOT NULL,
  `Account` INT NOT NULL,
  `Chat` INT NULL,
  PRIMARY KEY (`chatPermissions_id`),
  INDEX `FK_Account_ChatPermissions_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_Chat_ChatPermissions_idx` (`Chat` ASC) VISIBLE,
  CONSTRAINT `FK_Account_ChatPermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Chat_ChatPermissions`
    FOREIGN KEY (`Chat`)
    REFERENCES `chat` (`chat_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `individualReceipts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `individualReceipts` ;

CREATE TABLE IF NOT EXISTS `individualReceipts` (
  `individualReceipts_id` INT NOT NULL,
  `datePaid` DATE NOT NULL,
  `totalPaid` INT NOT NULL,
  `Transaction Payment` INT NULL,
  PRIMARY KEY (`individualReceipts_id`),
  INDEX `FK_TransactionPayment_IndividualReceipts_idx` (`Transaction Payment` ASC) VISIBLE,
  CONSTRAINT `FK_TransactionPayment_IndividualReceipts`
    FOREIGN KEY (`Transaction Payment`)
    REFERENCES `transactionPayment` (`transactionPayment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentPermissions` ;

CREATE TABLE IF NOT EXISTS `paymentPermissions` (
  `paymentPermissions_id` INT NOT NULL,
  `Account` INT NOT NULL,
  `PaymentType` INT NOT NULL,
  PRIMARY KEY (`paymentPermissions_id`),
  INDEX `FK_Account_PaymentPermissions_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_PaymentType_PaymentPermissions_idx` (`PaymentType` ASC) VISIBLE,
  CONSTRAINT `FK_Account_PaymentPermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PaymentType_PaymentPermissions`
    FOREIGN KEY (`PaymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adminPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `adminPermissions` ;

CREATE TABLE IF NOT EXISTS `adminPermissions` (
  `adminPermissions_id` INT NOT NULL,
  `Admin` INT NOT NULL,
  `Account` INT NOT NULL,
  PRIMARY KEY (`adminPermissions_id`),
  INDEX `FK_Account_adminPermissions_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_Admin_adminPermissions_idx` (`Admin` ASC) VISIBLE,
  CONSTRAINT `FK_Account_adminPermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Admin_adminPermissions`
    FOREIGN KEY (`Admin`)
    REFERENCES `Admin` (`admin_id(9)`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currencySupportedPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currencySupportedPermissions` ;

CREATE TABLE IF NOT EXISTS `currencySupportedPermissions` (
  `currencySupportedPermissions_id` INT NOT NULL,
  `TransactionPayment` INT NOT NULL,
  `CurrencySupported` INT NOT NULL,
  PRIMARY KEY (`currencySupportedPermissions_id`),
  INDEX `FK_TransactionPayment_currencySupportedPermissions_idx` (`TransactionPayment` ASC) VISIBLE,
  INDEX `FK_CurrencySupported_currencySupportedPermissions_idx` (`CurrencySupported` ASC) VISIBLE,
  CONSTRAINT `FK_TransactionPayment_currencySupportedPermissions`
    FOREIGN KEY (`TransactionPayment`)
    REFERENCES `transactionPayment` (`transactionPayment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CurrencySupported_currencySupportedPermissions`
    FOREIGN KEY (`CurrencySupported`)
    REFERENCES `currenciesSupported` (`currenciesSupported_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Reminders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Reminders` ;

CREATE TABLE IF NOT EXISTS `Reminders` (
  `Reminders_id` INT NOT NULL,
  `FunbillTransaction` INT NOT NULL,
  `deadlineDate` DATE NOT NULL,
  PRIMARY KEY (`Reminders_id`),
  INDEX `FK_FunbillTransaction_Reminder_idx` (`FunbillTransaction` ASC) VISIBLE,
  CONSTRAINT `FK_FunbillTransaction_Reminder`
    FOREIGN KEY (`FunbillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `groupPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `groupPermissions` ;

CREATE TABLE IF NOT EXISTS `groupPermissions` (
  `groupPermissions_id` INT NOT NULL,
  `Account` INT NOT NULL,
  `Groups` INT NULL,
  PRIMARY KEY (`groupPermissions_id`),
  INDEX `FK_Account_GroupPermissions_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_Group_GroupPermissions_idx` (`Groups` ASC) VISIBLE,
  CONSTRAINT `FK_Account_GroupPermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Group_GroupPermissions`
    FOREIGN KEY (`Groups`)
    REFERENCES `Groups` (`Groups_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `singlesPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `singlesPermissions` ;

CREATE TABLE IF NOT EXISTS `singlesPermissions` (
  `singlesPermissions_id` INT NOT NULL,
  `Account` INT NOT NULL,
  `Singles` INT NULL,
  PRIMARY KEY (`singlesPermissions_id`),
  INDEX `FK_Account_SinglePermissions_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_Singles_SinglesPermissions_idx` (`Singles` ASC) VISIBLE,
  CONSTRAINT `FK_Account_SinglePermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Singles_SinglesPermissions`
    FOREIGN KEY (`Singles`)
    REFERENCES `Singles` (`Singles_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `birthdayLisPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `birthdayLisPermissions` ;

CREATE TABLE IF NOT EXISTS `birthdayLisPermissions` (
  `birthdayListPermissions_id` INT NOT NULL,
  `BirthdayList` INT NOT NULL,
  `Account` INT NULL,
  PRIMARY KEY (`birthdayListPermissions_id`),
  INDEX `FK_Account_BirthdayList_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_BirthdayList_BirthdayListPermissions_idx` (`BirthdayList` ASC) VISIBLE,
  CONSTRAINT `FK_Account_BirthdayList`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_BirthdayList_BirthdayListPermissions`
    FOREIGN KEY (`BirthdayList`)
    REFERENCES `birthdayList` (`birthdayList_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reminderPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reminderPermissions` ;

CREATE TABLE IF NOT EXISTS `reminderPermissions` (
  `reminderPermissions_id` INT NOT NULL,
  `Reminder` INT NOT NULL,
  `Singles` INT NULL,
  `Groups` INT NULL,
  PRIMARY KEY (`reminderPermissions_id`, `Reminder`),
  INDEX `FK_Groups_ReminderPermissions_idx` (`Groups` ASC) VISIBLE,
  INDEX `FK_Singles_ReminderPermissions_idx` (`Singles` ASC) VISIBLE,
  INDEX `FK_Reminders_ReminderPermissions_idx` (`Reminder` ASC) VISIBLE,
  CONSTRAINT `FK_Groups_ReminderPermissions`
    FOREIGN KEY (`Groups`)
    REFERENCES `Groups` (`Groups_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Singles_ReminderPermissions`
    FOREIGN KEY (`Singles`)
    REFERENCES `Singles` (`Singles_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Reminders_ReminderPermissions`
    FOREIGN KEY (`Reminder`)
    REFERENCES `Reminders` (`Reminders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payRequestPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payRequestPermissions` ;

CREATE TABLE IF NOT EXISTS `payRequestPermissions` (
  `payRequestPermissions_id` INT NOT NULL,
  `PayRequest` INT NOT NULL,
  `Groups` INT NULL,
  `Singles` INT NULL,
  PRIMARY KEY (`payRequestPermissions_id`),
  INDEX `FK_PayRequest_PayRequestPermissions_idx` (`PayRequest` ASC) VISIBLE,
  INDEX `FK_Groups_PayRequestPermissions_idx` (`Groups` ASC) VISIBLE,
  INDEX `FK_Singles_PayRequestPermissions_idx` (`Singles` ASC) VISIBLE,
  CONSTRAINT `FK_Groups_PayRequestPermissions`
    FOREIGN KEY (`Groups`)
    REFERENCES `Groups` (`Groups_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Singles_PayRequestPermissions`
    FOREIGN KEY (`Singles`)
    REFERENCES `Singles` (`Singles_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PayRequest_PayRequestPermissions`
    FOREIGN KEY (`PayRequest`)
    REFERENCES `payRequest` (`payRequest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `groupsScanReceipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `groupsScanReceipt` ;

CREATE TABLE IF NOT EXISTS `groupsScanReceipt` (
  `idgroupsScanReceipt` INT NOT NULL,
  `ScanReceipt` INT NOT NULL,
  `Groups` INT NOT NULL,
  PRIMARY KEY (`idgroupsScanReceipt`),
  INDEX `FK_Groups_GroupsScanReceipt_idx` (`Groups` ASC) VISIBLE,
  INDEX `FK_ScanReceipt_GroupsScanReceipt_idx` (`ScanReceipt` ASC) VISIBLE,
  CONSTRAINT `FK_Groups_GroupsScanReceipt`
    FOREIGN KEY (`Groups`)
    REFERENCES `Groups` (`Groups_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ScanReceipt_GroupsScanReceipt`
    FOREIGN KEY (`ScanReceipt`)
    REFERENCES `scanReceipt` (`scanReceipt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `singlesScanReceipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `singlesScanReceipt` ;

CREATE TABLE IF NOT EXISTS `singlesScanReceipt` (
  `singlesScanReceipt_id` INT NOT NULL,
  `ScanReceipts` INT NOT NULL,
  PRIMARY KEY (`singlesScanReceipt_id`),
  INDEX `FK_ScanReceipt_SinglesScanReceipt_idx` (`ScanReceipts` ASC) VISIBLE,
  CONSTRAINT `FK_Singles_SinglesScanReceipt`
    FOREIGN KEY (`singlesScanReceipt_id`)
    REFERENCES `Singles` (`Singles_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ScanReceipt_SinglesScanReceipt`
    FOREIGN KEY (`ScanReceipts`)
    REFERENCES `scanReceipt` (`scanReceipt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `transactionPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transactionPermissions` ;

CREATE TABLE IF NOT EXISTS `transactionPermissions` (
  `transactionPermissions_id` INT NOT NULL,
  `GeneralUser` INT NULL,
  `Account` INT NULL,
  `FunbillTransaction` INT NOT NULL,
  PRIMARY KEY (`transactionPermissions_id`),
  INDEX `FK_Account_FunbillTransaction_idx` (`Account` ASC) VISIBLE,
  INDEX `FK_FunbillTransaction_TransactionPermissions_idx` (`FunbillTransaction` ASC) VISIBLE,
  INDEX `FK_GeneralUser_TransactionPermissions_idx` (`GeneralUser` ASC) VISIBLE,
  CONSTRAINT `FK_Account_TransactionPermissions`
    FOREIGN KEY (`Account`)
    REFERENCES `Account` (`account_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_FunbillTransaction_TransactionPermissions`
    FOREIGN KEY (`FunbillTransaction`)
    REFERENCES `funBillTransaction` (`funBillTransaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_GeneralUser_TransactionPermissions`
    FOREIGN KEY (`GeneralUser`)
    REFERENCES `generalUser` (`generalUser_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
