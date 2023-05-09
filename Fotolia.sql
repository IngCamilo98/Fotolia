-- MySQL Script generated by MySQL Workbench
-- Sat May  6 03:34:58 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Fotolia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Fotolia` ;

-- -----------------------------------------------------
-- Schema Fotolia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Fotolia` DEFAULT CHARACTER SET utf8 ;
USE `Fotolia` ;

-- -----------------------------------------------------
-- Table `Fotolia`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Clientes` (
  `Id_Cliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Apellido` VARCHAR(50) NOT NULL,
  `Direccion` VARCHAR(50) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Correo_electronico` VARCHAR(45) NULL,
  `Edad` INT(3) NOT NULL,
  `Genero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fotolia`.`Costos_Punto_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Costos_Punto_Venta` (
  `Id_Costos_Punto_Venta` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Costo` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Costos_Punto_Venta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fotolia`.`Punto_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Punto_Venta` (
  `Id_Punto_Venta` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tipo_Punto` VARCHAR(45) NOT NULL DEFAULT 'Fisico',
  `Ubicacion` VARCHAR(45) NOT NULL,
  `Dirección` VARCHAR(45) NOT NULL,
  `Cantidad_Empleados` INT(3) NOT NULL,
  `Almacen_Disponidle` INT NOT NULL,
  `Horario` VARCHAR(45) NOT NULL,
  `Id_Costos_Punto_Venta` INT NOT NULL,
  PRIMARY KEY (`Id_Punto_Venta`),
  CONSTRAINT `Id_Costos_Punto_Ventas`
    FOREIGN KEY (`Id_Costos_Punto_Venta`)
    REFERENCES `Fotolia`.`Costos_Punto_Venta` (`Id_Costos_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Dirección_UNIQUE` ON `Fotolia`.`Punto_Venta` (`Dirección` ASC) VISIBLE;

CREATE UNIQUE INDEX `Nombre_UNIQUE` ON `Fotolia`.`Punto_Venta` (`Nombre` ASC) VISIBLE;

CREATE INDEX `Id_Costos_Punto_Venta_idx` ON `Fotolia`.`Punto_Venta` (`Id_Costos_Punto_Venta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Empleados` (
  `Id_Empleado` INT NOT NULL AUTO_INCREMENT,
  `Documento` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL DEFAULT 'Activo',
  `Id_Punto_Venta` INT NOT NULL,
  `Salario` FLOAT NOT NULL,
  `Cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Empleado`),
  CONSTRAINT `Id_Punto_de_Ventas2`
    FOREIGN KEY (`Id_Punto_Venta`)
    REFERENCES `Fotolia`.`Punto_Venta` (`Id_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Punto_de_Venta_idx` ON `Fotolia`.`Empleados` (`Id_Punto_Venta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Imagenes` (
  `Id_Imagen` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Id_Cliente` INT NOT NULL,
  PRIMARY KEY (`Id_Imagen`),
  CONSTRAINT `Id_Clientes3`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `Fotolia`.`Clientes` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Cliente_idx` ON `Fotolia`.`Imagenes` (`Id_Cliente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Diseño`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Diseño` (
  `Id_Diseño` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Id_Empleado` INT NOT NULL,
  `Fecha_Creacion` DATETIME NOT NULL,
  `Caracteristicas` VARCHAR(45) NOT NULL,
  `Id:Imagen` INT NOT NULL,
  PRIMARY KEY (`Id_Diseño`),
  CONSTRAINT `Id_Imagens`
    FOREIGN KEY (`Id:Imagen`)
    REFERENCES `Fotolia`.`Imagenes` (`Id_Imagen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Empleados3`
    FOREIGN KEY (`Id_Empleado`)
    REFERENCES `Fotolia`.`Empleados` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Imagen_idx` ON `Fotolia`.`Diseño` (`Id:Imagen` ASC) VISIBLE;

CREATE INDEX `Id_Empleado_idx` ON `Fotolia`.`Diseño` (`Id_Empleado` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Servicio` (
  `Id_Servicio` INT NOT NULL AUTO_INCREMENT,
  `Tipo` TEXT(200) NOT NULL,
  `Id_Diseño` INT NOT NULL,
  `Precio` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Servicio`),
  CONSTRAINT `Id_Diseños`
    FOREIGN KEY (`Id_Diseño`)
    REFERENCES `Fotolia`.`Diseño` (`Id_Diseño`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Diseño_idx` ON `Fotolia`.`Servicio` (`Id_Diseño` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Servicios_Punto_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Servicios_Punto_Venta` (
  `Id_Servicio_Punto_Venta` INT NOT NULL AUTO_INCREMENT,
  `Id_Servicio` INT NOT NULL,
  `Id_Punto_Venta` INT NOT NULL,
  `Servicios_Disponibles` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Servicio_Punto_Venta`),
  CONSTRAINT `Id_Servicio90`
    FOREIGN KEY (`Id_Servicio`)
    REFERENCES `Fotolia`.`Servicio` (`Id_Servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Punto_Ventass4`
    FOREIGN KEY (`Id_Punto_Venta`)
    REFERENCES `Fotolia`.`Punto_Venta` (`Id_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Inventario de los productos o servicios por cada punto de venta';

CREATE INDEX `Id_Punto_Venta_idx` ON `Fotolia`.`Servicios_Punto_Venta` (`Id_Punto_Venta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Ventas` (
  `Id_Ventas` INT NOT NULL AUTO_INCREMENT,
  `Id_Servicio_Punto_Venta` INT NOT NULL,
  `Id_Cliente` INT NOT NULL,
  `Id_Empleados` INT NOT NULL,
  `Id_Ingreso_Venta` INT NOT NULL,
  PRIMARY KEY (`Id_Ventas`),
  CONSTRAINT `Id_Productos_Punto_Ventas`
    FOREIGN KEY (`Id_Servicio_Punto_Venta`)
    REFERENCES `Fotolia`.`Servicios_Punto_Venta` (`Id_Servicio_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Clientess1`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `Fotolia`.`Clientes` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Empleadoss4`
    FOREIGN KEY (`Id_Empleados`)
    REFERENCES `Fotolia`.`Empleados` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  CONSTRAINT `Id_Ingreso_Venta0`
    FOREIGN KEY (`Id_Ingreso_Venta`)
    REFERENCES `Fotolia`.`Ingreso_Venta` (`Id_Ingreso_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Productos_Punto_Venta_idx` ON `Fotolia`.`Ventas` (`Id_Servicio_Punto_Venta` ASC) VISIBLE;

CREATE INDEX `Id_Clientes_idx` ON `Fotolia`.`Ventas` (`Id_Cliente` ASC) VISIBLE;

CREATE INDEX `id_Empleados_idx` ON `Fotolia`.`Ventas` (`Id_Empleados` ASC) VISIBLE;

CREATE INDEX `Id_Ingreso_Venta_idx` ON `Fotolia`.`Ventas` (`Id_Ingreso_Venta` ASC) VISIBLE;

-- -----------------------------------------------------
-- Table `Fotolia`.`Ingreso_Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Ingreso_Venta` (
  `Id_Ingreso_Venta` INT NOT NULL AUTO_INCREMENT,
  `Id_Cliente` INT NOT NULL,
  `Tipo_Ingreso` VARCHAR(45) NOT NULL,
  `Monto` FLOAT NOT NULL,
  `Comision_Ingreso` FLOAT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  PRIMARY KEY (`Id_Ingreso_Venta`),
  CONSTRAINT `Id_Clientes23`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `Fotolia`.`Clientes` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Cliente_idx` ON `Fotolia`.`Ingreso_Venta` (`Id_Cliente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Costo_Produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Costo_Produccion` (
  `Id_Costo_Produccion` INT NOT NULL AUTO_INCREMENT,
  `Id_Servicio` INT NOT NULL,
  `Costo` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Costo_Produccion`),
  CONSTRAINT `Id_Servicios`
    FOREIGN KEY (`Id_Servicio`)
    REFERENCES `Fotolia`.`Servicio` (`Id_Servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Servicio_idx` ON `Fotolia`.`Costo_Produccion` (`Id_Servicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Proveedores` (
  `Id_Proveedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tipo_Servicio` VARCHAR(45) NOT NULL,
  `NIT` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Correo_Electronico` VARCHAR(45) NOT NULL,
  `Cuenta_Bancaria` VARCHAR(45) NOT NULL,
  `Horario_Atencion` VARCHAR(45) NOT NULL,
  `Id_Costo_Produccion` INT NOT NULL,
  PRIMARY KEY (`Id_Proveedor`),
  CONSTRAINT `Id_Costo_Produccions`
    FOREIGN KEY (`Id_Costo_Produccion`)
    REFERENCES `Fotolia`.`Costo_Produccion` (`Id_Costo_Produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Costo_Produccion_idx` ON `Fotolia`.`Proveedores` (`Id_Costo_Produccion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Orden_Produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Orden_Produccion` (
  `Id_Orden_Produccion` INT NOT NULL AUTO_INCREMENT,
  `Id_Ventas` INT NOT NULL,
  `Id_Proveedor` INT NOT NULL,
  `Fecha_Inicio` DATETIME NOT NULL,
  `Fecha_Finalizacion` DATETIME NOT NULL,
  `Costo_Fabricacion` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Orden_Produccion`),
  CONSTRAINT `Id_Vantass`
    FOREIGN KEY (`Id_Ventas`)
    REFERENCES `Fotolia`.`Ventas` (`Id_Ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Proveedors`
    FOREIGN KEY (`Id_Proveedor`)
    REFERENCES `Fotolia`.`Proveedores` (`Id_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Vantas_idx` ON `Fotolia`.`Orden_Produccion` (`Id_Ventas` ASC) VISIBLE;

CREATE INDEX `Id_Proveedor_idx` ON `Fotolia`.`Orden_Produccion` (`Id_Proveedor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Orden_Envio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Orden_Envio` (
  `Id_Orden_Envio` INT NOT NULL AUTO_INCREMENT,
  `Id_Orden_Produccion` INT NOT NULL,
  `Fecha_Entrega` DATETIME NOT NULL,
  PRIMARY KEY (`Id_Orden_Envio`),
  CONSTRAINT `Id_Orden_Produccions`
    FOREIGN KEY (`Id_Orden_Produccion`)
    REFERENCES `Fotolia`.`Orden_Produccion` (`Id_Orden_Produccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Orden_Produccion_idx` ON `Fotolia`.`Orden_Envio` (`Id_Orden_Produccion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Costo_Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Costo_Transporte` (
  `Id_Costo_Transporte` INT NOT NULL AUTO_INCREMENT,
  `Id_Servicio` INT NOT NULL,
  `Costo` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Costo_Transporte`),
  CONSTRAINT `Id_Servicioss`
    FOREIGN KEY (`Id_Servicio`)
    REFERENCES `Fotolia`.`Servicio` (`Id_Servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Servicio_idx` ON `Fotolia`.`Costo_Transporte` (`Id_Servicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Mensajeria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Mensajeria` (
  `Id_Mensajeria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Horarios de Atencion` VARCHAR(45) NOT NULL,
  `Id_Costo_Transporte` INT NOT NULL,
  `Historial_Entrega` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Mensajeria`),
  CONSTRAINT `Id_Costo_Transportes`
    FOREIGN KEY (`Id_Costo_Transporte`)
    REFERENCES `Fotolia`.`Costo_Transporte` (`Id_Costo_Transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Costo_Envio_idx` ON `Fotolia`.`Mensajeria` (`Id_Costo_Transporte` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Envio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Envio` (
  `Id_Envio` INT NOT NULL,
  `Id_Orden_Envio` INT NOT NULL,
  `Id_Mensajeria` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL DEFAULT 'Por_Entregar',
  PRIMARY KEY (`Id_Envio`),
  CONSTRAINT `Id_Orden_Envios`
    FOREIGN KEY (`Id_Orden_Envio`)
    REFERENCES `Fotolia`.`Orden_Envio` (`Id_Orden_Envio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Mensajerias`
    FOREIGN KEY (`Id_Mensajeria`)
    REFERENCES `Fotolia`.`Mensajeria` (`Id_Mensajeria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Orden_Envio_idx` ON `Fotolia`.`Envio` (`Id_Orden_Envio` ASC) VISIBLE;

CREATE INDEX `Id_Mensajeria_idx` ON `Fotolia`.`Envio` (`Id_Mensajeria` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Almacen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Almacen` (
  `Id_Almacen` INT NOT NULL AUTO_INCREMENT,
  `Id_Envio` INT NOT NULL,
  `Id_Punto_Venta` INT NOT NULL,
  PRIMARY KEY (`Id_Almacen`),
  CONSTRAINT `Id_Envios`
    FOREIGN KEY (`Id_Envio`)
    REFERENCES `Fotolia`.`Envio` (`Id_Envio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Punto_Ventas5`
    FOREIGN KEY (`Id_Punto_Venta`)
    REFERENCES `Fotolia`.`Punto_Venta` (`Id_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Envio_idx` ON `Fotolia`.`Almacen` (`Id_Envio` ASC) VISIBLE;

CREATE INDEX `Id_Punto_Venta_idx` ON `Fotolia`.`Almacen` (`Id_Punto_Venta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Campañas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Campañas` (
  `Id_Campaña` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Publico_Objetivo` VARCHAR(45) NOT NULL,
  `Canal_Comunicacion` VARCHAR(45) NOT NULL,
  `Alcance` INT NOT NULL,
  `Costo` FLOAT NOT NULL,
  `Efectividad` VARCHAR(45) NOT NULL,
  `Fecha_Inicio` DATETIME NOT NULL,
  `Fecha_Finalizacion` DATETIME NOT NULL,
  PRIMARY KEY (`Id_Campaña`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Fotolia`.`Contenido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Contenido` (
  `Id_Contenido` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Caracteristicas` VARCHAR(45) NOT NULL,
  `Contenido` VARCHAR(45) NOT NULL,
  `Id_Campaña` INT NOT NULL,
  PRIMARY KEY (`Id_Contenido`),
  CONSTRAINT `Id_Campañas`
    FOREIGN KEY (`Id_Campaña`)
    REFERENCES `Fotolia`.`Campañas` (`Id_Campaña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Campaña_idx` ON `Fotolia`.`Contenido` (`Id_Campaña` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Trabajo_Campaña`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Trabajo_Campaña` (
  `Id_Trabajo_Campaña` INT NOT NULL AUTO_INCREMENT,
  `Id_Empleado` INT NOT NULL,
  `Id_Campaña` INT NOT NULL,
  `Fecha_Inicio` DATETIME NULL,
  `Fecha_Finalizacion` DATETIME NULL,
  PRIMARY KEY (`Id_Trabajo_Campaña`),
  CONSTRAINT `Id_Campañas1`
    FOREIGN KEY (`Id_Campaña`)
    REFERENCES `Fotolia`.`Campañas` (`Id_Campaña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Empleados1`
    FOREIGN KEY (`Id_Empleado`)
    REFERENCES `Fotolia`.`Empleados` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Campaña_idx` ON `Fotolia`.`Trabajo_Campaña` (`Id_Campaña` ASC) VISIBLE;

CREATE INDEX `Id_Empleado_idx` ON `Fotolia`.`Trabajo_Campaña` (`Id_Empleado` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Agenda_Estudio_Fotografico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Agenda_Estudio_Fotografico` (
  `Id_Agenda_Fotografica` INT NOT NULL AUTO_INCREMENT,
  `Id_Empleado` INT NOT NULL,
  `Fecha_Hora` DATETIME NOT NULL,
  `Id_Cliente` INT NOT NULL,
  `Estado_Agendamiento` VARCHAR(45) NOT NULL DEFAULT 'Pendiente',
  `Id_Punto_Venta` INT NOT NULL,
  PRIMARY KEY (`Id_Agenda_Fotografica`),
  CONSTRAINT `Id_Empleados2`
    FOREIGN KEY (`Id_Empleado`)
    REFERENCES `Fotolia`.`Empleados` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Clientes2`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `Fotolia`.`Clientes` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Punto_Ventas1`
    FOREIGN KEY (`Id_Punto_Venta`)
    REFERENCES `Fotolia`.`Punto_Venta` (`Id_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Empleado_idx` ON `Fotolia`.`Agenda_Estudio_Fotografico` (`Id_Empleado` ASC) VISIBLE;

CREATE INDEX `Id_Cliente_idx` ON `Fotolia`.`Agenda_Estudio_Fotografico` (`Id_Cliente` ASC) VISIBLE;

CREATE INDEX `Id_Punto_Venta_idx` ON `Fotolia`.`Agenda_Estudio_Fotografico` (`Id_Punto_Venta` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Comision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Comision` (
  `Id_Comisiones` INT NOT NULL AUTO_INCREMENT,
  `Id_Ventas` INT NOT NULL,
  `Fecha` DATETIME NOT NULL,
  `Valor_Comision` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Comisiones`),
  CONSTRAINT `Id_Ventass34`
    FOREIGN KEY (`Id_Ventas`)
    REFERENCES `Fotolia`.`Ventas` (`Id_Ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Ventas_idx` ON `Fotolia`.`Comision` (`Id_Ventas` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Costo_Pasarela_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Costo_Pasarela_Pago` (
  `Id_Costo_Pasarela_Pago` INT NOT NULL AUTO_INCREMENT,
  `Id_Servicio` INT NOT NULL,
  `Costo` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Costo_Pasarela_Pago`),
  CONSTRAINT `Id_Servicioss22`
    FOREIGN KEY (`Id_Servicio`)
    REFERENCES `Fotolia`.`Servicio` (`Id_Servicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Servicio_idx` ON `Fotolia`.`Costo_Pasarela_Pago` (`Id_Servicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Contabilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Contabilidad` (
  `id_Contabilidad` INT NOT NULL AUTO_INCREMENT,
  `Id_Comisiones` INT NOT NULL,
  `Id_Costos_Punto_Venta` INT NOT NULL,
  `Id_Costos_Pasarela_Pago` INT NOT NULL,
  `Id_Costo_Transporte` INT NOT NULL,
  `Id_Campaña` INT NOT NULL,
  PRIMARY KEY (`id_Contabilidad`),
  CONSTRAINT `Id_Comisioness23`
    FOREIGN KEY (`Id_Comisiones`)
    REFERENCES `Fotolia`.`Comision` (`Id_Comisiones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Costos_Punto_Ventas24`
    FOREIGN KEY (`Id_Costos_Punto_Venta`)
    REFERENCES `Fotolia`.`Costos_Punto_Venta` (`Id_Costos_Punto_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Costos_Pasarela_Pagos25`
    FOREIGN KEY (`Id_Costos_Pasarela_Pago`)
    REFERENCES `Fotolia`.`Costo_Pasarela_Pago` (`Id_Costo_Pasarela_Pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Costo_Transportes26`
    FOREIGN KEY (`Id_Costo_Transporte`)
    REFERENCES `Fotolia`.`Costo_Transporte` (`Id_Costo_Transporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Campañas27`
    FOREIGN KEY (`Id_Campaña`)
    REFERENCES `Fotolia`.`Campañas` (`Id_Campaña`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Comisiones_idx` ON `Fotolia`.`Contabilidad` (`Id_Comisiones` ASC) VISIBLE;

CREATE INDEX `Id_Costos_Punto_Venta_idx` ON `Fotolia`.`Contabilidad` (`Id_Costos_Punto_Venta` ASC) VISIBLE;

CREATE INDEX `Id_Costos_Pasarela_Pago_idx` ON `Fotolia`.`Contabilidad` (`Id_Costos_Pasarela_Pago` ASC) VISIBLE;

CREATE INDEX `Id_Costo_Transporte_idx` ON `Fotolia`.`Contabilidad` (`Id_Costo_Transporte` ASC) VISIBLE;

CREATE INDEX `Id_Campaña_idx` ON `Fotolia`.`Contabilidad` (`Id_Campaña` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Fotolia`.`Pasarela_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Fotolia`.`Pasarela_Pago` (
  `Id_Pasarela_Pago` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Id_Ingreso_Venta` INT NOT NULL,
  PRIMARY KEY (`Id_Pasarela_Pago`),
  CONSTRAINT `Id_Costo_Pasarela_Pagos28`
    FOREIGN KEY (`Id_Ingreso_Venta`)
    REFERENCES `Fotolia`.`Costo_Pasarela_Pago` (`Id_Costo_Pasarela_Pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Id_Ingreso_Ventas29`
    FOREIGN KEY (`Id_Ingreso_Venta`)
    REFERENCES `Fotolia`.`Ingreso_Venta` (`Id_Ingreso_Venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `Id_Costo_Pasarela_Pago_idx` ON `Fotolia`.`Pasarela_Pago` (`Id_Ingreso_Venta` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;