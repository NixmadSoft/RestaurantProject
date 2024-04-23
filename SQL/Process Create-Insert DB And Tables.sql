CREATE DATABASE `Restaurant`;

USE `Restaurant`;
DROP procedure IF EXISTS `Add_Tables`;

DELIMITER $$
USE `Restaurant`$$
CREATE PROCEDURE `Add_Tables` ()
BEGIN
 CREATE TABLE Stock (
        `ID` BIGINT NOT NULL AUTO_INCREMENT,
        `Producto` VARCHAR(50) NOT NULL,
        `Costo` BIGINT(9) NULL,
        `UCosto` BIGINT(9) NULL,
        `Precio` BIGINT(9) NULL,
        PRIMARY KEY (ID, Producto),
        INDEX (Producto)
    );

    CREATE TABLE `Roles` (
        `ID` INT(11) NOT NULL AUTO_INCREMENT,
        `Rol` VARCHAR(50) NOT NULL,
        PRIMARY KEY (ID),
        INDEX (Rol)
    );

    CREATE TABLE `TypeDocument` (
        `ID` INT(11) NOT NULL AUTO_INCREMENT,
        `Documento` VARCHAR(4) NOT NULL,
        PRIMARY KEY (ID),
        INDEX (Documento)
    );

    CREATE TABLE `Employee` (
        `ID` BIGINT NOT NULL AUTO_INCREMENT,
        `NDocumento` VARCHAR(50) NOT NULL,
        `Contraseña` VARCHAR(50) NOT NULL,
        `Rol` INT(11) NOT NULL,
        `PrimerNombre` VARCHAR(50) NOT NULL,
        `SegundoNombre` VARCHAR(50) NOT NULL,
        `PrimerApellido` VARCHAR(50) NOT NULL,
        `SegundoApellido` VARCHAR(50) NOT NULL,
        `Documento` VARCHAR(4) NOT NULL,
        PRIMARY KEY (ID),
        INDEX (NDocumento),
        FOREIGN KEY (Rol) REFERENCES Roles(ID),
        FOREIGN KEY (Documento) REFERENCES TypeDocument(Documento)
    );

    CREATE TABLE `Customers` (
        `ID` BIGINT NOT NULL AUTO_INCREMENT,
        `NDocumento` VARCHAR(50) NOT NULL,
        `Rol` INT(11) NOT NULL,
        `PrimerNombre` VARCHAR(50) NOT NULL,
        `SegundoNombre` VARCHAR(50) NOT NULL,
        `PrimerApellido` VARCHAR(50) NOT NULL,
        `SegundoApellido` VARCHAR(50) NOT NULL,
        `Documento` VARCHAR(4) NOT NULL,
        `Telefono` VARCHAR(10) NOT NULL,
        PRIMARY KEY (ID),
        INDEX (NDocumento),
        FOREIGN KEY (Rol) REFERENCES Roles(ID),
        FOREIGN KEY (Documento) REFERENCES TypeDocument(Documento)
    );

    CREATE TABLE `Sales` (
        `ID` BIGINT NOT NULL AUTO_INCREMENT,
        `NumeroInvoice` VARCHAR(50) NOT NULL,
        `NDocumentoEmpleado` VARCHAR(50) NOT NULL,
        `NDocumentoCliente` VARCHAR(50) NOT NULL,
        `Fecha` DATE NOT NULL,
        `Total` BIGINT(9),
        `Estado` VARCHAR(50) NULL,
        PRIMARY KEY (ID),
        INDEX (NumeroInvoice),
        FOREIGN KEY (NDocumentoEmpleado) REFERENCES Employee(NDocumento),
        FOREIGN KEY (NDocumentoCliente) REFERENCES Customers(NDocumento)
    );

    CREATE TABLE `DetailSales` (
        `ID` BIGINT NOT NULL AUTO_INCREMENT,
        `IDProducto` BIGINT NOT NULL,
        `NumeroInvoice` VARCHAR(50) NOT NULL,
        `Cantidad` INT NOT NULL,
        `PrecioUnd` BIGINT(9) NOT NULL,
        `PrecioTot` BIGINT(9) NOT NULL,
        `Pago` VARCHAR(50) NOT NULL,
        `Descuento` BIGINT(9) NOT NULL,
        PRIMARY KEY (ID),
        INDEX (IDProducto),
        FOREIGN KEY (NumeroInvoice) REFERENCES Sales(NumeroInvoice),
        FOREIGN KEY (IDProducto) REFERENCES Stock(ID)
    );
END$$

DELIMITER ;

CALL Add_tables;


INSERT INTO Roles (Rol) VALUES ("Admin");
INSERT INTO Roles (Rol) VALUES ("Waiter");
INSERT INTO Roles (Rol) VALUES ("Cook");
INSERT INTO Roles (Rol) VALUES ("ATM");
INSERT INTO Roles (Rol) VALUES ("App Customer");
INSERT INTO Roles (Rol) VALUES ("Local Customer");
INSERT INTO TypeDocument (Documento) VALUES ("C.C");
INSERT INTO TypeDocument (Documento) VALUES ("C.E");