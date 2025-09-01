-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TP_Base_de_Datos_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TP_Base_de_Datos_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TP_Base_de_Datos_1` DEFAULT CHARACTER SET utf8 ;
USE `TP_Base_de_Datos_1` ;

-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`provedor` (
  `idProvedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`idProvedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`linea_de_montaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`linea_de_montaje` (
  `idlinea_de_montaje` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idlinea_de_montaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`modelo` (
  `idmodelo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `año` INT NOT NULL,
  `linea_de_montaje_idlinea_de_montaje` INT NOT NULL,
  PRIMARY KEY (`idmodelo`),
  INDEX `fk_modelo_linea_de_montaje1_idx` (`linea_de_montaje_idlinea_de_montaje` ASC) VISIBLE,
  CONSTRAINT `fk_modelo_linea_de_montaje1`
    FOREIGN KEY (`linea_de_montaje_idlinea_de_montaje`)
    REFERENCES `TP_Base_de_Datos_1`.`linea_de_montaje` (`idlinea_de_montaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`automovil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`automovil` (
  `num_chasis` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `fecha_finalizacion` DATE NULL,
  `hora_de_ingreso` VARCHAR(45) NOT NULL,
  `hora_de_finalizacion` TIME NULL,
  `modelo_idmodelo` INT NOT NULL,
  PRIMARY KEY (`num_chasis`, `modelo_idmodelo`),
  INDEX `fk_automovil_modelo1_idx` (`modelo_idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_automovil_modelo1`
    FOREIGN KEY (`modelo_idmodelo`)
    REFERENCES `TP_Base_de_Datos_1`.`modelo` (`idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`estacion_de_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`estacion_de_trabajo` (
  `idestacion_de_trabajo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `tarea` VARCHAR(45) NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_finalizacion` TIME NOT NULL,
  `linea_de_montaje_idlinea_de_montaje` INT NOT NULL,
  `automovil_num_chasis` INT NOT NULL,
  `automovil_modelo_idmodelo` INT NOT NULL,
  PRIMARY KEY (`idestacion_de_trabajo`, `linea_de_montaje_idlinea_de_montaje`, `automovil_num_chasis`, `automovil_modelo_idmodelo`),
  INDEX `fk_estacion_de_trabajo_linea_de_montaje1_idx` (`linea_de_montaje_idlinea_de_montaje` ASC) VISIBLE,
  INDEX `fk_estacion_de_trabajo_automovil1_idx` (`automovil_num_chasis` ASC, `automovil_modelo_idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_estacion_de_trabajo_linea_de_montaje1`
    FOREIGN KEY (`linea_de_montaje_idlinea_de_montaje`)
    REFERENCES `TP_Base_de_Datos_1`.`linea_de_montaje` (`idlinea_de_montaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estacion_de_trabajo_automovil1`
    FOREIGN KEY (`automovil_num_chasis` , `automovil_modelo_idmodelo`)
    REFERENCES `TP_Base_de_Datos_1`.`automovil` (`num_chasis` , `modelo_idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`empleado` (
  `idempleado` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `sueldo` VARCHAR(45) NOT NULL,
  `inicio_turno` TIME NOT NULL,
  `final_turno` TIME NOT NULL,
  `estacion_de_trabajo_idestacion_de_trabajo` INT NOT NULL,
  `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje` INT NOT NULL,
  PRIMARY KEY (`idempleado`, `estacion_de_trabajo_idestacion_de_trabajo`, `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje`),
  INDEX `fk_empleado_estacion_de_trabajo1_idx` (`estacion_de_trabajo_idestacion_de_trabajo` ASC, `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_estacion_de_trabajo1`
    FOREIGN KEY (`estacion_de_trabajo_idestacion_de_trabajo` , `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje`)
    REFERENCES `TP_Base_de_Datos_1`.`estacion_de_trabajo` (`idestacion_de_trabajo` , `linea_de_montaje_idlinea_de_montaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`insumos` (
  `idinsumos` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `medidas` INT NULL,
  `stock` INT NOT NULL,
  `precio` INT NULL,
  PRIMARY KEY (`idinsumos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`concesionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`concesionarios` (
  `idconcesionarios` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `stock` INT NULL,
  `ventas` INT NULL,
  PRIMARY KEY (`idconcesionarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`estacion_de_trabajo_has_insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`estacion_de_trabajo_has_insumos` (
  `estacion_de_trabajo_idestacion_de_trabajo` INT NOT NULL,
  `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje` INT NOT NULL,
  `insumos_idautopartes` INT NOT NULL,
  PRIMARY KEY (`estacion_de_trabajo_idestacion_de_trabajo`, `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje`, `insumos_idautopartes`),
  INDEX `fk_estacion_de_trabajo_has_insumos_insumos1_idx` (`insumos_idautopartes` ASC) VISIBLE,
  INDEX `fk_estacion_de_trabajo_has_insumos_estacion_de_trabajo1_idx` (`estacion_de_trabajo_idestacion_de_trabajo` ASC, `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje` ASC) VISIBLE,
  CONSTRAINT `fk_estacion_de_trabajo_has_insumos_estacion_de_trabajo1`
    FOREIGN KEY (`estacion_de_trabajo_idestacion_de_trabajo` , `estacion_de_trabajo_linea_de_montaje_idlinea_de_montaje`)
    REFERENCES `TP_Base_de_Datos_1`.`estacion_de_trabajo` (`idestacion_de_trabajo` , `linea_de_montaje_idlinea_de_montaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estacion_de_trabajo_has_insumos_insumos1`
    FOREIGN KEY (`insumos_idautopartes`)
    REFERENCES `TP_Base_de_Datos_1`.`insumos` (`idinsumos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`pedidos` (
  `concesionarios_idconcesionarios` INT NOT NULL,
  `modelo_idmodelo` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`concesionarios_idconcesionarios`, `modelo_idmodelo`),
  INDEX `fk_concesionarios_has_modelo_concesionarios1_idx` (`concesionarios_idconcesionarios` ASC) VISIBLE,
  INDEX `fk_pedidos_modelo1_idx` (`modelo_idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_concesionarios_has_modelo_concesionarios1`
    FOREIGN KEY (`concesionarios_idconcesionarios`)
    REFERENCES `TP_Base_de_Datos_1`.`concesionarios` (`idconcesionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_modelo1`
    FOREIGN KEY (`modelo_idmodelo`)
    REFERENCES `TP_Base_de_Datos_1`.`modelo` (`idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`Pedidos` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`provedor_has_insumos_autopartes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`provedor_has_insumos_autopartes` (
  `provedor_idProvedor` INT NOT NULL,
  `insumos_autopartes_idautopartes` INT NOT NULL,
  PRIMARY KEY (`provedor_idProvedor`, `insumos_autopartes_idautopartes`),
  INDEX `fk_provedor_has_insumos_autopartes_insumos_autopartes1_idx` (`insumos_autopartes_idautopartes` ASC) VISIBLE,
  INDEX `fk_provedor_has_insumos_autopartes_provedor1_idx` (`provedor_idProvedor` ASC) VISIBLE,
  CONSTRAINT `fk_provedor_has_insumos_autopartes_provedor1`
    FOREIGN KEY (`provedor_idProvedor`)
    REFERENCES `TP_Base_de_Datos_1`.`provedor` (`idProvedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provedor_has_insumos_autopartes_insumos_autopartes1`
    FOREIGN KEY (`insumos_autopartes_idautopartes`)
    REFERENCES `TP_Base_de_Datos_1`.`insumos` (`idinsumos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`autopartes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`autopartes` (
  `idautopartes` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `medidas` INT NULL,
  `stock` INT NOT NULL,
  `precio` INT NULL,
  `automovil_num_chasis` INT NOT NULL,
  `automovil_modelo_idmodelo` INT NOT NULL,
  PRIMARY KEY (`idautopartes`, `automovil_num_chasis`, `automovil_modelo_idmodelo`),
  INDEX `fk_autopartes_automovil1_idx` (`automovil_num_chasis` ASC, `automovil_modelo_idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_autopartes_automovil1`
    FOREIGN KEY (`automovil_num_chasis` , `automovil_modelo_idmodelo`)
    REFERENCES `TP_Base_de_Datos_1`.`automovil` (`num_chasis` , `modelo_idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TP_Base_de_Datos_1`.`autopartes_has_provedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TP_Base_de_Datos_1`.`autopartes_has_provedor` (
  `autopartes_idautopartes` INT NOT NULL,
  `autopartes_automovil_num_chasis` INT NOT NULL,
  `autopartes_automovil_modelo_idmodelo` INT NOT NULL,
  `provedor_idProvedor` INT NOT NULL,
  PRIMARY KEY (`autopartes_idautopartes`, `autopartes_automovil_num_chasis`, `autopartes_automovil_modelo_idmodelo`, `provedor_idProvedor`),
  INDEX `fk_autopartes_has_provedor_provedor1_idx` (`provedor_idProvedor` ASC) VISIBLE,
  INDEX `fk_autopartes_has_provedor_autopartes1_idx` (`autopartes_idautopartes` ASC, `autopartes_automovil_num_chasis` ASC, `autopartes_automovil_modelo_idmodelo` ASC) VISIBLE,
  CONSTRAINT `fk_autopartes_has_provedor_autopartes1`
    FOREIGN KEY (`autopartes_idautopartes` , `autopartes_automovil_num_chasis` , `autopartes_automovil_modelo_idmodelo`)
    REFERENCES `TP_Base_de_Datos_1`.`autopartes` (`idautopartes` , `automovil_num_chasis` , `automovil_modelo_idmodelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autopartes_has_provedor_provedor1`
    FOREIGN KEY (`provedor_idProvedor`)
    REFERENCES `TP_Base_de_Datos_1`.`provedor` (`idProvedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
