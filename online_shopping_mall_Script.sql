-- MySQL Workbench Synchronization
-- Generated: 2021-10-07 22:34
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: corn

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `online_shopping_mall`.`billing` 
DROP FOREIGN KEY `fk_billing_Customer1`;

ALTER TABLE `online_shopping_mall`.`cart` 
DROP FOREIGN KEY `fk_cart_Customer1`;

ALTER TABLE `online_shopping_mall`.`Customer` 
ADD COLUMN `cart_cart_id` INT(11) NULL DEFAULT NULL AFTER `password`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`customer_id`, `cart_cart_id`),
ADD INDEX `fk_Customer_cart1_idx` (`cart_cart_id` ASC) VISIBLE;
;

ALTER TABLE `online_shopping_mall`.`billing` 
DROP COLUMN `Customer_customer_id`,
DROP COLUMN `csv`,
ADD COLUMN `csv` VARCHAR(3) NOT NULL AFTER `Expire_date`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`billing_id`),
DROP INDEX `fk_billing_Customer1_idx` ;
;

ALTER TABLE `online_shopping_mall`.`cart` 
DROP COLUMN `Customer_customer_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`cart_id`),
DROP INDEX `fk_cart_Customer1_idx` ;
;

ALTER TABLE `online_shopping_mall`.`Order` 
ADD COLUMN `billing_billing_id` INT(11) NOT NULL AFTER `Customer_customer_id`,
ADD INDEX `fk_Order_billing1_idx` (`billing_billing_id` ASC) VISIBLE;
;

ALTER TABLE `online_shopping_mall`.`Customer` 
ADD CONSTRAINT `fk_Customer_cart1`
  FOREIGN KEY (`cart_cart_id`)
  REFERENCES `online_shopping_mall`.`cart` (`cart_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `online_shopping_mall`.`Order` 
ADD CONSTRAINT `fk_Order_billing1`
  FOREIGN KEY (`billing_billing_id`)
  REFERENCES `online_shopping_mall`.`billing` (`billing_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
