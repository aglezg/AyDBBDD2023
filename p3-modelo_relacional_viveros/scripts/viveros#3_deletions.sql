/**
 * DELETIONS
 **/

-- Borrado de un 'vivero'
SELECT * FROM vivero;
DELETE FROM vivero WHERE id = 3; -- ERR: borramos un vivero referenciado en 'zona'.

SELECT * FROM zona;
DELETE FROM zona WHERE id_vivero = 3; -- ERR: borramos un vivero referenciado en 'almacenamiento'

SELECT * FROM almacenamiento;
DELETE FROM almacenamiento WHERE id_vivero=3; -- Eliminamos el vivero de la tabla 'almacenamiento'
SELECT * FROM almacenamiento;

SELECT * FROM trabajo;
DELETE FROM zona WHERE id_vivero = 3; -- Eliminamos el vivero de la tabla 'zona'
SELECT * FROM trabajo;                -- La tabla 'trabajo' también ha sido alterada
SELECT * FROM zona;

DELETE FROM vivero WHERE id = 3; -- Eliminamos el vivero de la tabla 'vivero'
SELECT * FROM vivero;

-- Borrado de una 'zona'
SELECT * FROM zona;
DELETE FROM zona WHERE id_vivero = 1 AND nombre='Almacen'; -- ERR: borramos una zona referenciada en 'almacenamiento'
DELETE FROM almacenamiento WHERE id_vivero=1 AND nombre_zona='Almacen';
DELETE FROM zona WHERE id_vivero = 1 AND nombre='Almacen';

-- Borrado de un 'producto'
DELETE FROM producto WHERE id=7; -- ERR: No podemos eliminar el producto, pues de nuevo se referencia en 'almacenamiento'
                                 -- En este caso no lo borramos

-- Borrado de un 'empleado'
SELECT * FROM empleado;
SELECT * FROM phone;
SELECT * FROM email;
SELECT * FROM pedido;
DELETE FROM empleado WHERE nombre='Adrian'; -- Borrar un empleado eliminará las entradas de 'phone' e 'email' de sus respectivas tablas.
SELECT * FROM empleado;
SELECT * FROM phone;
SELECT * FROM email;
SELECT * FROM pedido; -- Se ha establecido como 'NULL' el valor 'dni' de los pedidos de ese empleado

-- Borrado de un 'cliente_plus'
SELECT * FROM pedido;
DELETE FROM cliente_plus WHERE id=2; -- Realizará también cambios en la tabla 'pedido'.
SELECT * FROM pedido;