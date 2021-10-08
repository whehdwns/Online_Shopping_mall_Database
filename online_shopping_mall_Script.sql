-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema online_shopping_mall
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema online_shopping_mall
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `online_shopping_mall` DEFAULT CHARACTER SET utf8 ;
USE `online_shopping_mall` ;

-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product_category` (
  `product_category_id` INT NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product` (
  `product_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `Color` CHAR(15) NOT NULL,
  `in_stock` INT NOT NULL,
  `description` TINYTEXT NOT NULL,
  `product_category_product_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_product_category1_idx` (`product_category_product_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_product_category1`
    FOREIGN KEY (`product_category_product_category_id`)
    REFERENCES `online_shopping_mall`.`product_category` (`product_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`cart` (
  `cart_id` INT NOT NULL,
  `product_quantity` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`cart_id`),
  INDEX `fk_cart_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `online_shopping_mall`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`Customer` (
  `customer_id` INT NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `fname` VARCHAR(255) NOT NULL,
  `lname` VARCHAR(255) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `cart_cart_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `cart_cart_id`),
  INDEX `fk_Customer_cart1_idx` (`cart_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_cart1`
    FOREIGN KEY (`cart_cart_id`)
    REFERENCES `online_shopping_mall`.`cart` (`cart_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`personal_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`personal_information` (
  `personal_info_id` INT NOT NULL,
  `Street` VARCHAR(255) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `Postal_code` VARCHAR(50) NOT NULL,
  `Country` VARCHAR(50) NOT NULL,
  `Phone_number` VARCHAR(15) NOT NULL,
  `Birth_date` DATE NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`personal_info_id`, `Customer_customer_id`),
  INDEX `fk_personal_information_Customer_idx` (`Customer_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_personal_information_Customer`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `online_shopping_mall`.`Customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`billing` (
  `billing_id` INT NOT NULL,
  `Card_type` VARCHAR(255) NOT NULL,
  `Card_number` VARCHAR(16) NOT NULL,
  `Expire_date` DATE NOT NULL,
  `csv` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`billing_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product_review` (
  `review_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `rating` DECIMAL(3,2) NOT NULL,
  `photo` BLOB NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_product_review_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_review_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `online_shopping_mall`.`Customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product_thumbnail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product_thumbnail` (
  `thumbnail_id` INT NOT NULL,
  `thumbnail` BLOB NOT NULL,
  PRIMARY KEY (`thumbnail_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product_question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product_question` (
  `question_id` INT NOT NULL,
  `question_category` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `date` VARCHAR(45) NOT NULL,
  `reply_state` VARCHAR(45) NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  PRIMARY KEY (`question_id`),
  INDEX `fk_product_question_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_question_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `online_shopping_mall`.`Customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`product_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`product_detail` (
  `detail_id` INT NOT NULL,
  `product_thumbnail_thumbnail_id` INT NOT NULL,
  `product_question_question_id` INT NOT NULL,
  `product_review_review_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  PRIMARY KEY (`detail_id`),
  INDEX `fk_product_detail_product_thumbnail1_idx` (`product_thumbnail_thumbnail_id` ASC) VISIBLE,
  INDEX `fk_product_detail_product_question1_idx` (`product_question_question_id` ASC) VISIBLE,
  INDEX `fk_product_detail_product_review1_idx` (`product_review_review_id` ASC) VISIBLE,
  INDEX `fk_product_detail_product1_idx` (`product_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_detail_product_thumbnail1`
    FOREIGN KEY (`product_thumbnail_thumbnail_id`)
    REFERENCES `online_shopping_mall`.`product_thumbnail` (`thumbnail_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_detail_product_question1`
    FOREIGN KEY (`product_question_question_id`)
    REFERENCES `online_shopping_mall`.`product_question` (`question_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_detail_product_review1`
    FOREIGN KEY (`product_review_review_id`)
    REFERENCES `online_shopping_mall`.`product_review` (`review_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_detail_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `online_shopping_mall`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`Order` (
  `order_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  `billing_billing_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Order_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Order_billing1_idx` (`billing_billing_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `online_shopping_mall`.`Customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_billing1`
    FOREIGN KEY (`billing_billing_id`)
    REFERENCES `online_shopping_mall`.`billing` (`billing_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`Order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`Order_detail` (
  `order_detail_id` INT NOT NULL,
  `product_count` INT NOT NULL,
  `product_price` DECIMAL(10,2) NOT NULL,
  `product_product_id` INT NOT NULL,
  `Customer_customer_id` INT NOT NULL,
  `Order_order_id` INT NOT NULL,
  PRIMARY KEY (`order_detail_id`, `product_product_id`),
  INDEX `fk_Order_detail_product1_idx` (`product_product_id` ASC) VISIBLE,
  INDEX `fk_Order_detail_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Order_detail_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_detail_product1`
    FOREIGN KEY (`product_product_id`)
    REFERENCES `online_shopping_mall`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_detail_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `online_shopping_mall`.`Customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_detail_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `online_shopping_mall`.`Order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `online_shopping_mall`.`Carrier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `online_shopping_mall`.`Carrier` (
  `carrier_id` INT NOT NULL,
  `company_name` VARCHAR(255) NOT NULL,
  `phone_number` CHAR(15) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `Order_order_id` INT NOT NULL,
  PRIMARY KEY (`carrier_id`),
  INDEX `fk_Carrier_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Carrier_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `online_shopping_mall`.`Order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
