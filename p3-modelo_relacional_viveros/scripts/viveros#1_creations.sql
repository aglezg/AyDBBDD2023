/**
 * TABLES CREATIONS 
 **/

-- Table 'vivero'----------------------------------------------------------------------------------
CREATE TABLE vivero ( 
  id serial PRIMARY KEY,
  latitud DOUBLE PRECISION NOT NULL,
  longitud DOUBLE PRECISION NOT NULL
);
SELECT * FROM vivero; -- VIEW

-- Table 'zona'------------------------------------------------------------------------------------
CREATE TABLE zona ( 
  id_vivero INT REFERENCES vivero(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  nombre VARCHAR(50) NOT NULL,
  latitud DOUBLE PRECISION NOT NULL,
  longitud DOUBLE PRECISION NOT NULL,
  PRIMARY KEY (id_vivero, nombre)
);
SELECT * FROM zona; -- VIEW

-- Table 'producto'--------------------------------------------------------------------------------
CREATE TABLE producto ( 
  id serial PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  tipo VARCHAR(10),
  CHECK (tipo IN ('planta', 'jardineria', 'decoracion'))
);
SELECT * FROM producto; -- VIEW

-- TABLE 'almacenamiento'--------------------------------------------------------------------------
CREATE TABLE almacenamiento (
  id_vivero INT,
  nombre_zona VARCHAR(50),
  id_producto INT REFERENCES producto(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  stock INT CHECK(stock > 0),
  FOREIGN KEY (id_vivero, nombre_zona) REFERENCES zona(id_vivero, nombre) ON DELETE RESTRICT ON UPDATE CASCADE,
  PRIMARY KEY (id_vivero, nombre_zona, id_producto)
);
SELECT * FROM almacenamiento; -- VIEW

-- TABLE 'empleado'--------------------------------------------------------------------------------
CREATE TABLE empleado ( 
  dni CHAR(9) CHECK (dni ~ '\d{8}[A-Za-z]$') PRIMARY KEY,
  fecha_nac DATE NOT NULL CHECK (fecha_nac > '1900-01-01'),
  edad SMALLINT,
  ventas INT NOT NULL CHECK (ventas >= 0),
  nombre VARCHAR(50) NOT NULL,
  apellido_1 VARCHAR(50) NOT NULL,
  apellido_2 VARCHAR(50)
);
SELECT * FROM empleado; -- VIEW

-- CREATE FUNCTION 'actualiza_columna_edad()'
CREATE OR REPLACE FUNCTION actualiza_columna_edad() RETURNS TRIGGER AS $$
  BEGIN
    NEW.edad = DATE_PART('year', AGE(CURRENT_DATE, NEW.fecha_nac));
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'calcula_edad()'
CREATE TRIGGER calcula_edad
BEFORE INSERT OR UPDATE
ON empleado
FOR EACH ROW
EXECUTE FUNCTION actualiza_columna_edad();

-- Table 'trabajo'---------------------------------------------------------------------------------
CREATE TABLE trabajo ( 
  dni_empleado CHAR(9) REFERENCES empleado(dni) ON DELETE SET NULL ON UPDATE CASCADE,
  id_vivero INT,
  nombre_zona VARCHAR(50),
  FOREIGN KEY (id_vivero, nombre_zona) REFERENCES zona(id_vivero, nombre) ON UPDATE CASCADE ON DELETE SET NULL,
  fech_inicio DATE NOT NULL,
  fech_fin DATE NOT NULL,
  CHECK (fech_inicio <= fech_fin)
);
SELECT * FROM trabajo; -- VIEW

-- CREATE FUNCTION 'check_work_period_overlap()'
CREATE OR REPLACE FUNCTION check_work_period_overlap()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM trabajo
        WHERE dni_empleado = NEW.dni_empleado
        AND (NEW.fech_inicio, NEW.fech_fin) OVERLAPS (fech_inicio, fech_fin)
    ) THEN
        RAISE EXCEPTION 'El nuevo periodo de trabajo se solapa con uno existente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'check_work_period_overlap()'
CREATE TRIGGER check_work_period_overlap BEFORE INSERT ON trabajo
FOR EACH ROW EXECUTE PROCEDURE check_work_period_overlap();

-- Table 'cliente_plus'----------------------------------------------------------------------------
CREATE TABLE cliente_plus ( 
  id serial PRIMARY KEY,
  dni CHAR(9) UNIQUE NOT NULL CHECK (dni ~ '^\d{8}[A-Za-z]$'),
  nombre VARCHAR(50) NOT NULL,
  apellido_1 VARCHAR(50) NOT NULL,
  apellido_2 VARCHAR(50),
  total_mensual INT NOT NULL CHECK (total_mensual > 0),
  bonificaciones FLOAT GENERATED ALWAYS AS (5 * CAST(total_mensual AS FLOAT) / 100) STORED
);
SELECT * FROM cliente_plus; -- VIEW

-- Table 'cliente_noplus'--------------------------------------------------------------------------
CREATE TABLE cliente_noplus ( 
  id serial PRIMARY KEY
);
SELECT * FROM cliente_noplus; -- VIEW

-- Table 'phone'-----------------------------------------------------------------------------------
CREATE TABLE phone ( 
  dni_empleado CHAR(9) REFERENCES empleado(dni) ON DELETE CASCADE ON UPDATE CASCADE,
  id_clienteplus INT REFERENCES cliente_plus(id) ON DELETE CASCADE ON UPDATE CASCADE,
  phone_number CHAR(9) NOT NULL CHECK (phone_number ~ '^[0-9]+$')
);
SELECT * FROM phone; -- VIEW

-- CREATE FUNCTION 'one_of_both_must_be_not_null()'
CREATE OR REPLACE FUNCTION one_of_both_must_be_not_null() RETURNS TRIGGER AS $one_of_both_must_be_not_null$
  DECLARE
  BEGIN
    IF NEW.id_clienteplus IS NULL AND NEW.dni_empleado IS NULL THEN
      RAISE EXCEPTION 'id_clienteplus OR dni_empleado ONE MUST HAVE A VALUE';
    END IF;
    IF NEW.id_clienteplus IS NOT NULL AND NEW.dni_empleado IS NOT NULL THEN
      RAISE EXCEPTION 'id_cliente plus OR dni_empleado ONE MUST HAVE A NULL VALUE';
    END IF;
    RETURN NEW;
  END;
$one_of_both_must_be_not_null$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'phone_not_both_null'
CREATE TRIGGER phone_not_both_null BEFORE INSERT OR UPDATE ON phone
FOR EACH ROW EXECUTE PROCEDURE one_of_both_must_be_not_null();

-- Table 'email'-----------------------------------------------------------------------------------
CREATE TABLE email ( 
  dni_empleado CHAR(9) REFERENCES empleado(dni) ON DELETE CASCADE ON UPDATE CASCADE,
  id_clienteplus INT REFERENCES cliente_plus(id) ON DELETE CASCADE ON UPDATE CASCADE,
  email_address VARCHAR(100) NOT NULL
);
SELECT * FROM email; -- VIEW

-- CREATE TRIGGER 'email_not_both_null'
CREATE TRIGGER email_not_both_null BEFORE INSERT OR UPDATE ON email
FOR EACH ROW EXECUTE PROCEDURE one_of_both_must_be_not_null();

-- Table 'pedido'----------------------------------------------------------------------------------
CREATE TABLE pedido (
  dni_empleado CHAR(9) REFERENCES empleado(dni) ON UPDATE CASCADE ON DELETE SET NULL,
  id_producto INT REFERENCES producto(id) ON UPDATE CASCADE ON DELETE SET NULL,
  id_clienteplus INT REFERENCES cliente_plus(id) ON UPDATE CASCADE ON DELETE SET NULL,
  id_clienteNoplus INT REFERENCES cliente_noplus(id) ON UPDATE CASCADE ON DELETE SET NULL,
  fecha DATE NOT NULL CHECK (fecha > '2000-01-01'),
  cantidad INT NOT NULL CHECK (cantidad > 0)
);
SELECT * FROM pedido;

-- CREATE FUNCTION 'one_id_not_null()'
CREATE OR REPLACE FUNCTION one_id_not_null() RETURNS TRIGGER AS $one_id_not_null$
  DECLARE
  BEGIN
    IF NEW.id_clienteplus IS NULL AND NEW.id_clientenoplus IS NULL THEN
      RAISE EXCEPTION 'id_clienteplus OR id_clientenoplus ONE MUST HAVE A VALUE';
    END IF;
    IF NEW.id_clienteplus IS NOT NULL AND NEW.id_clientenoplus IS NOT NULL THEN
      RAISE EXCEPTION 'id_cliente plus OR id_clientenoplus ONE MUST HAVE A NULL VALUE';
    END IF;
    RETURN NEW;
  END;
$one_id_not_null$ LANGUAGE plpgsql;

-- CREATE TRIGGER 'one_id_not_null()'
CREATE TRIGGER one_id_not_null BEFORE INSERT ON pedido
FOR EACH ROW EXECUTE PROCEDURE one_id_not_null();