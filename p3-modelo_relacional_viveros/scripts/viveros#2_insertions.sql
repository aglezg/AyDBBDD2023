/**
 * INSERTIONS
 **/

-- Table 'vivero'----------------------------------------------------------------------------------
SELECT * FROM vivero;
INSERT INTO vivero (latitud, longitud) VALUES (38.90472222222222, -77.016388888888);
INSERT INTO vivero (latitud, longitud) VALUES (48.85333333333333, 2.3488888888888889);
INSERT INTO vivero (latitud, longitud) VALUES (40.416388888888889, 3.7025);
INSERT INTO vivero (latitud, longitud) VALUES (41.891666666666667, 12.4941666666667);
INSERT INTO vivero (latitud, longitud) VALUES (19.4283333333333333, 99.1275);
SELECT * FROM vivero;

-- Table 'zona'------------------------------------------------------------------------------------
SELECT * FROM zona;
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (1, 'Almacen', 38.91, -77.0163888888);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (1, 'Jardin', 38.92, -77.0199);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (2, 'Herbolario', 48.80, 2.341);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (2, 'Almacen', 48.6, 2.3333);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (3, 'Tienda', 40.45, 4.000000001);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (3, 'Almacen', 40.418, 3.7000001);
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (4, 'Almacen', 41.8916666666666, 12.494166667);
SELECT * FROM zona;
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (6, 'Almacen', 3.0, 2.1); -- ERR: intentamos agregar un 'id' que no existe en la tabla viveros
INSERT INTO zona (id_vivero, nombre, latitud, longitud) VALUES (1, 'Almacen', 3.0, 2.1); -- ERR: intentamos agregar una clave primaria (id, nombre) ya existente
SELECT * FROM zona;

-- Table 'producto'--------------------------------------------------------------------------------
SELECT * FROM producto;
INSERT INTO producto (nombre, tipo) VALUES ('Margarita', 'planta');
INSERT INTO producto (nombre, tipo) VALUES ('Amapola', 'planta');
INSERT INTO producto (nombre, tipo) VALUES ('Tijeras', 'jardineria');
INSERT INTO producto (nombre, tipo) VALUES ('Envoltorio', 'decoracion');
INSERT INTO producto (nombre, tipo) VALUES ('Rosa', 'planta');
INSERT INTO producto (nombre, tipo) VALUES ('Maceta', 'jardineria');
INSERT INTO producto (nombre, tipo) VALUES ('Cuchilla', 'jardineria');
INSERT INTO producto (nombre, tipo) VALUES ('Estanteria', 'decoracion');
SELECT * FROM producto;
INSERT INTO producto (nombre, tipo) VALUES ('Cualquier cosa', 'err'); -- ERR: intentamos introducir un tipo de producto incorrecto
SELECT * FROM producto;

-- Table 'almacenamiento'--------------------------------------------------------------------------
SELECT * FROM almacenamiento;
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Almacen', 6, 250);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Jardin', 1, 78);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Jardin', 2, 40);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (2, 'Herbolario', 5, 5);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (2, 'Herbolario', 1, 90);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (2, 'Almacen', 8, 80);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (3, 'Tienda', 3, 650);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (3, 'Tienda', 7, 60);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (3, 'Almacen', 6, 41);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (4, 'Almacen', 3, 41);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (4, 'Almacen', 4, 90);
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (4, 'Almacen', 7, 101);
SELECT * FROM almacenamiento;
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Almacen', 6, 251); -- ERR: repetimos clave primaria (vivero, zona, producto)
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (4, 'Almacen', 1, -3); -- ERR: check "stock no puede ser negativo"
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Inventado', 7, 251); -- ERR: agregamos una zona no existente
INSERT INTO almacenamiento (id_vivero, nombre_zona, id_producto, stock) VALUES (1, 'Almacen', 90, 3); -- ERR: agregamos un producto no existente
SELECT * FROM almacenamiento;

-- Table 'empleado'--------------------------------------------------------------------------------
SELECT * FROM empleado;
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1, apellido_2) VALUES ('43491148B', '2001-06-19', 0, 'Adrian', 'Gonzalez', 'Galvan');
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1, apellido_2) VALUES ('73451948X', '2001-06-30', 7, 'Jose', 'Lorenzo', 'Estevez');
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1, apellido_2) VALUES ('93485517J', '1997-01-21', 7, 'Marcos', 'Sanchez', 'Diaz');
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1) VALUES ('28491109U', '1993-12-05', 190, 'Erik', 'Briggitte');
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1) VALUES ('01954988T', '2004-01-01', 6, 'Claudia', 'Fragance');
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1, apellido_2) VALUES ('92341185P', '1990-06-11', 301, 'Estefania', 'Suarez', 'Hernandez');
SELECT * FROM empleado;
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1) VALUES ('92341185P', '1991-05-18', 31, 'Nombre', 'Inventado'); -- Error: dni ya existente
INSERT INTO empleado (dni, fecha_nac, ventas, nombre) VALUES ('12326985P', '1991-01-18', 3, 'Nombre'); -- Error: El apellido_1 no puede ser nulo
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1) VALUES ('12326985P', '1899-01-18', 31, 'Nombre', 'Inventado'); -- Error: fecha antes de 01-01-1900
INSERT INTO empleado (dni, fecha_nac, ventas, nombre, apellido_1) VALUES ('12326985P', '1991-01-18', -3, 'Nombre', 'Inventado'); -- Error: ventas no puede ser negativo
SELECT * FROM empleado;

-- Table 'trabajo'---------------------------------------------------------------------------------
SELECT * FROM trabajo;
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('43491148B', 1, 'Almacen', '2022-12-30', '2023-01-31');
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('93485517J', 2, 'Herbolario', '2012-01-07', '2012-01-30');
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('28491109U', 1, 'Jardin', '2012-01-07', '2012-01-30');
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('28491109U', 1, 'Almacen', '2018-07-11', '2019-12-30');
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('92341185P', 4, 'Almacen', '2022-07-11', '2023-03-03');
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('01954988T', 3, 'Tienda', '2021-09-19', '2022-10-19');
SELECT * FROM trabajo;
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('43491148B', 7, 'Herbolario', '2021-09-19', '2022-09-21'); -- Error: "ID vivero no existente"
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('43491148B', 1, 'No existe', '2021-09-19', '2022-09-21'); -- Error: "nombre zona no existente"
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('93485517J', 1, 'Almacen', '2012-01-07', '2012-01-01'); -- Error: (fech inicio > fech fin)
INSERT INTO trabajo (dni_empleado, id_vivero, nombre_zona, fech_inicio, fech_fin) VALUES ('01954988T', 3, 'Herbolario', '2021-09-19', '2022-09-21'); -- Error: "mismo periodo"
SELECT * FROM trabajo;

-- Table 'cliente_plus'----------------------------------------------------------------------------
SELECT * FROM cliente_plus;
INSERT INTO cliente_plus (dni, nombre, apellido_1, apellido_2, total_mensual) VALUES ('12345678A', 'Adrian', 'Estevez', 'Galvan', 50);
INSERT INTO cliente_plus (dni, nombre, apellido_1, apellido_2, total_mensual) VALUES ('02223387P', 'Maria', 'Galvan', 'Galvan', 100);
INSERT INTO cliente_plus (dni, nombre, apellido_1, total_mensual) VALUES ('11223344O', 'Pedro', 'Cardenas', 91);
INSERT INTO cliente_plus (dni, nombre, apellido_1, apellido_2, total_mensual) VALUES ('94768100T', 'Marta', 'Llanos', 'Aridane', 1000);
INSERT INTO cliente_plus (dni, nombre, apellido_1, apellido_2, total_mensual) VALUES ('01493875K', 'Emmanuel', 'Sanchez', 'Fuentes', 113);
SELECT * FROM cliente_plus;
INSERT INTO cliente_plus (dni, nombre, apellido_1, total_mensual) VALUES ('01493875K', 'Pedro', 'Sanchez', 113); -- ERR: dni ya existente
INSERT INTO cliente_plus (dni, nombre, apellido_1, total_mensual) VALUES ('01493875o', 'Pedro', 'Sanchez', -11); -- ERR: total_mensual > 0

-- Table 'cliente_noplus'--------------------------------------------------------------------------
SELECT * FROM cliente_noplus;
INSERT INTO cliente_noplus VALUES (DEFAULT);
INSERT INTO cliente_noplus VALUES (DEFAULT);
INSERT INTO cliente_noplus VALUES (DEFAULT);
INSERT INTO cliente_noplus VALUES (DEFAULT);
INSERT INTO cliente_noplus VALUES (DEFAULT);
SELECT * FROM cliente_noplus;

-- Table 'phone'-----------------------------------------------------------------------------------
SELECT * FROM phone;
INSERT INTO phone (dni_empleado, phone_number) VALUES('43491148B', '123456789');
INSERT INTO phone (dni_empleado, phone_number) VALUES('43491148B', '693756989');
INSERT INTO phone (dni_empleado, phone_number) VALUES('01954988T', '693756988');
INSERT INTO phone (dni_empleado, phone_number) VALUES('01954988T', '111222333');
INSERT INTO phone (id_clienteplus, phone_number) VALUES(2, '693756988');
INSERT INTO phone (id_clienteplus, phone_number) VALUES(2, '693756988');
SELECT * FROM phone;
INSERT INTO phone(dni_empleado, phone_number) VALUES('98765432H', '123456709'); -- ERR: no existe el dni del empleado
INSERT INTO phone (id_clienteplus, phone_number) VALUES(99, '888654190'); -- ERR: no existe el identificador de cliente
INSERT INTO phone(phone_number) VALUES ('615633406'); -- ERR: Debe haber un dni de empleado o un identificador de cliente asociado
INSERT INTO phone(dni_empleado, id_clienteplus, phone_number) VALUES('43491148B', 2, '000111222'); -- ERR: una fila no puede contener un dni de empleado y un identificador de cliente a la vez

-- Table 'email'-----------------------------------------------------------------------------------
SELECT * FROM email;
INSERT INTO email (dni_empleado, email_address) VALUES('43491148B', 'alu0101321219@ull.edu.es');
INSERT INTO email (dni_empleado, email_address) VALUES('43491148B', 'glezgalvan.adrian@gmail.com');
INSERT INTO email (dni_empleado, email_address) VALUES('01954988T', 'correoejemplo@gmail.com');
INSERT INTO email (dni_empleado, email_address) VALUES('01954988T', 'correoejemplo2@gmail.com');
INSERT INTO email (id_clienteplus, email_address) VALUES(2, 'correoCLIENTE@email.com');
INSERT INTO email (id_clienteplus, email_address) VALUES(2, 'correoCLIENTE2@email.es');
SELECT * FROM email;
INSERT INTO email (dni_empleado, email_address) VALUES('98765432H', 'error@gmail.com'); -- ERR: no existe el dni del empleado
INSERT INTO email (id_clienteplus, email_address) VALUES(99, 'error@gmail.com'); -- ERR: no existe el identificador de cliente
INSERT INTO email (email_address) VALUES ('error@email.es'); -- ERR: Debe haber un dni de empleado o un identificador de cliente asociado
INSERT INTO email (dni_empleado, id_clienteplus, email_address) VALUES('43491148B', 2, 'err@err.err'); -- ERR: una fila no puede contener un dni de empleado y un identificador de cliente a la vez

-- Table 'pedido'----------------------------------------------------------------------------------
INSERT INTO pedido (dni_empleado, id_producto, id_clienteplus, fecha, cantidad) VALUES ('43491148B', 1, 2, '2015-07-18', 9);
INSERT INTO pedido (dni_empleado, id_producto, id_clienteplus, fecha, cantidad) VALUES ('43491148B', 5, 3, '2013-11-21', 51);
INSERT INTO pedido (dni_empleado, id_producto, id_clienteplus, fecha, cantidad) VALUES ('93485517J', 3, 2, '2020-08-20', 11);
INSERT INTO pedido (dni_empleado, id_producto, id_clienteplus, fecha, cantidad) VALUES ('92341185P', 5, 4, '2003-04-04', 1);
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 7, 5, '2010-01-13', 99);
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 2, 5, '2010-01-13', 1);
SELECT * FROM pedido;
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('00000000y', 2, 5, '2010-01-13', 1); -- ERR: No existe el id del empleado
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 99, 5, '2010-01-13', 99); -- ERR: No existe el id del producto
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 7, 99, '2010-01-13', 99); -- ERR: No existe el id del cliente
INSERT INTO pedido (dni_empleado, id_producto, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 7, 5, '2010-01-13', -1); -- ERR: Cantidad no puede ser negativa
INSERT INTO pedido (dni_empleado, id_producto, fecha, cantidad) VALUES ('28491109U', 2, '2010-01-13', 1); -- ERR: There must be one cliente id
INSERT INTO pedido (dni_empleado, id_producto, id_clienteplus, id_clientenoplus, fecha, cantidad) VALUES ('28491109U', 2, 1, 5, '2010-01-13', 1); -- ERROR: One cliente id must be null
SELECT * FROM pedido;