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
-- Table `funBillTransaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funBillTransaction` ;

CREATE TABLE IF NOT EXISTS `funBillTransaction` (
  `funBillTransaction_id` INT(9) NOT NULL,
  `Category` INT(9) NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Completed` TINYINT NOT NULL DEFAULT 0,
  `totalAmountDue` INT ZEROFILL NULL,
  `individualAmount` INT ZEROFILL NULL,
  PRIMARY KEY (`funBillTransaction_id`),
  INDEX `FK_Category_FunBillTransaction_idx` (`Category` ASC) VISIBLE,
  CONSTRAINT `FK_Category_FunBillTransaction`
    FOREIGN KEY (`Category`)
    REFERENCES `Categories` (`categories_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
