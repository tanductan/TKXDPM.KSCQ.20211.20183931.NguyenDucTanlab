BEGIN;
CREATE TABLE `aims`.`Media` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `category` VARCHAR(45) NOT NULL,
    `price` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `title` VARCHAR(45) NOT NULL,
    `value` INTEGER NOT NULL,
    `imageUrl` VARCHAR(45) NOT NULL
);
CREATE TABLE `aims`.`CD` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `artist` VARCHAR(45) NOT NULL,
    `recordLabel` VARCHAR(45) NOT NULL,
    `musicType` VARCHAR(45) NOT NULL,
    `releasedDate` DATE,
    CONSTRAINT `fk_CD_Media1` FOREIGN KEY (`id`)
        REFERENCES `Media` (`id`)
);
CREATE TABLE `aims`.`Book` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `author` VARCHAR(45) NOT NULL,
    `coverType` VARCHAR(45) NOT NULL,
    `publisher` VARCHAR(45) NOT NULL,
    `publishDate` DATETIME NOT NULL,
    `numOfPages` INTEGER NOT NULL,
    `language` VARCHAR(45) NOT NULL,
    `bookCategory` VARCHAR(45) NOT NULL,
    CONSTRAINT `fk_Book_Media1` FOREIGN KEY (`id`)
        REFERENCES `Media` (`id`)
);
CREATE TABLE `aims`.`DeleveryInfo` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `name` VARCHAR(45),
    `province` VARCHAR(45),
    `instructions` VARCHAR(200),
    `address` VARCHAR(100)
);
CREATE TABLE `aims`.`Card` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `cardCode` VARCHAR(15) NOT NULL,
    `owner` VARCHAR(45) NOT NULL,
    `cvvCode` VARCHAR(3) NOT NULL,
    `dateExpired` VARCHAR(4) NOT NULL
);
CREATE TABLE `aims`.`DVD` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `discType` VARCHAR(45) NOT NULL,
    `director` VARCHAR(45) NOT NULL,
    `runtime` INTEGER NOT NULL,
    `studio` VARCHAR(45) NOT NULL,
    `subtitle` VARCHAR(45) NOT NULL,
    `releasedDate` DATETIME,
    CONSTRAINT `fk_DVD_Media1` FOREIGN KEY (`id`)
        REFERENCES `Media` (`id`)
);
CREATE TABLE `aims`.`Order` (
    `id` INTEGER NOT NULL,
    `shippingFees` VARCHAR(45),
    `deleveryInfoId` INTEGER NOT NULL,
    PRIMARY KEY (`id` , `deleveryInfoId`),
    CONSTRAINT `fk_Order_DeleveryInfo1` FOREIGN KEY (`deleveryInfoId`)
        REFERENCES `DeleveryInfo` (`id`)
);
CREATE TABLE `aims`.`OrderMedia` (
    `orderID` INTEGER NOT NULL,
    `price` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `mediaId` INTEGER NOT NULL,
    PRIMARY KEY (`orderID` , `mediaId`),
    CONSTRAINT `fk_ordermedia_order` FOREIGN KEY (`orderID`)
        REFERENCES `Order` (`id`),
    CONSTRAINT `fk_OrderMedia_Media1` FOREIGN KEY (`mediaId`)
        REFERENCES `Media` (`id`)
);
CREATE TABLE `aims`.`Invoice` (
    `id` INTEGER PRIMARY KEY NOT NULL,
    `totalAmount` INTEGER NOT NULL,
    `orderId` INTEGER NOT NULL,
    CONSTRAINT `fk_Invoice_Order1` FOREIGN KEY (`orderId`)
        REFERENCES `Order` (`id`)
);
CREATE TABLE `aims`.`PaymentTransaction` (
    `id` INTEGER NOT NULL,
    `createAt` DATETIME NOT NULL,
    `content` VARCHAR(45) NOT NULL,
    `method` VARCHAR(45),
    `cardId` INTEGER NOT NULL,
    `invoiceId` INTEGER NOT NULL,
    PRIMARY KEY (`id` , `cardId` , `invoiceId`),
    CONSTRAINT `fk_PaymentTransaction_Card1` FOREIGN KEY (`cardId`)
        REFERENCES `Card` (`id`),
    CONSTRAINT `fk_PaymentTransaction_Invoice1` FOREIGN KEY (`invoiceId`)
        REFERENCES `Invoice` (`id`)
);
COMMIT;