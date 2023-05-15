DROP SCHEMA IF EXISTS `Prueba_Inner` ;

-- -----------------------------------------------------
-- Schema Prueba_Inner
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Prueba_Inner` DEFAULT CHARACTER SET utf8 ;
USE `Prueba_Inner` ;

-- -----------------------------------------------------
-- Table `Fotolia`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prueba_Inner`.`Estados` (
  `Id_Estados` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id_Estados`))
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prueba_Inner`.`Ciudades` (
  `Id_Ciudades` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Id_Estados` INT NOT NULL,
  PRIMARY KEY (`Id_Ciudades`),
  CONSTRAINT `Id_Ciudades`
    FOREIGN KEY (`Id_Estados`)
    REFERENCES `Prueba_Inner`.`Estados` (`Id_Estados`)  
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO Estados (Nombre) VALUES 
('Nuevo León'),
('Jalisco'),
('Baja California'),
('Quintana Roo'),
('Sinaloa');

select * from Estados;

INSERT INTO Ciudades (Nombre, Id_Estados) VALUES 
('Monterrey', 1),
('Guadalajara', 1),
('Mexicali', 2),
('Chetumal', 3);

select * from Ciudades;
-- -----------------------------
-- drop schema Prueba_Inner;

select * from Estados 
inner join Ciudades on
Ciudades.Id_Estados = Estados.Id_Estados;