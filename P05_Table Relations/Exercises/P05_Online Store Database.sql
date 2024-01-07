CREATE TABLE `items` (
    `item_id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `item_type_id` INT(11)
);

CREATE TABLE `item_types` (
    `item_type_id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

ALTER TABLE `items`
ADD CONSTRAINT fk_items_types
FOREIGN KEY (`item_type_id`)
REFERENCES `item_types` (`item_type_id`);

CREATE TABLE `customers` (
    `customer_id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `birthday` DATE,
    `city_id` INT(11)
);

CREATE TABLE `cities` (
    `city_id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

ALTER TABLE `customers`
ADD CONSTRAINT fk_customers_cities
FOREIGN KEY (`city_id`)
REFERENCES `cities` (`city_id`);

CREATE TABLE `orders` (
    `order_id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT(11)
);

ALTER TABLE `orders`
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (`customer_id`)
REFERENCES `customers` (`customer_id`);

CREATE TABLE `order_items` (
    `order_id` INT(11),
    `item_id` INT(11),
    CONSTRAINT pk PRIMARY KEY (`order_id` , `item_id`)
);

ALTER TABLE `order_items`
ADD CONSTRAINT fk_order
FOREIGN KEY (`order_id`)
REFERENCES `orders` (`order_id`),
ADD CONSTRAINT fk_items
FOREIGN KEY (`item_id`)
REFERENCES `items` (`item_id`);