USE `essentialmode`;

CREATE TABLE `lottery_drawings` (
	`uniqueID` VARCHAR(255) NOT NULL,
	`id` INT(11) NOT NULL,
	`date` VARCHAR(50) NOT NULL,
	`numbers` VARCHAR(50) NULL DEFAULT NULL
);

CREATE TABLE `lottery_tickets` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(50) NOT NULL,
	`drawingUniqueID` VARCHAR(255) NOT NULL,
	`drawingID` INT(11) NOT NULL,
	`numbers` VARCHAR(50) NOT NULL,
	`isDrawn` TINYINT(1) NOT NULL DEFAULT '0',
	`prize` INT(11) NOT NULL DEFAULT '-1',
	PRIMARY KEY (`id`)
);

INSERT INTO lottery_drawings (uniqueID, id, date) VALUES ('daily_lotto', 0, '8\/29\/2019');
INSERT INTO lottery_drawings (uniqueID, id, date) VALUES ('monday_lotto', 0, '9\/2\/2019');
INSERT INTO lottery_drawings (uniqueID, id, date) VALUES ('friday_lotto', 0, '8\/30\/2019');