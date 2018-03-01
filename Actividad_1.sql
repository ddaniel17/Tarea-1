/* Formatted on 2/14/2018 7:33:07 PM (QP5 v5.300) */
--Fecha y total de las compras mas recientes del cliente

  SELECT ot.customerid, ot.first_name, SUM (ot.ORDER_ID)
    FROM (  SELECT ord.ORDER_ID,
                   SUM (op.QUANTITY * prod.list_price) order_totals,
                   cus.CUSTOMER_ID,
                   cus.FIRST_NAME
              FROM DANIELYN.ORDER_ID ord
                   INNER JOIN DANIELYN.ORDERS_PRODUCTS op
                       ON ord.ORDER_ID = op.ORDER_ID
                   INNER JOIN DANIELYN.SALES_PRODUCTS prod
                       ON op.PRODUCT_ID = prod.PRODUCT_ID
                   INNER JOIN DANIELYN.CUSTOMERS_TEST cus
                       ON ord.CUSTOMER_ID = cus.CUSTOMER_ID
          GROUP BY ord.ORDER_ID, cus.CUSTOMER_ID, cus.FIRST_NAME) ot
GROUP BY ot.CUSTOMER_ID, ot.FIRST_NAME
ORDER BY ot.CUSTOMER_ID;

-- Clientes cuyos contenga la letra H o Apellido empieza con Z.

SELECT orders.ORDER_ID, cus.FIRST_NAME, cus.LAST_NAME
  FROM DANIELYN.ORDER_ID  orders
       INNER JOIN DANIELYN.CUSTOMERS_TEST cus
           ON orders.CUSTOMERS_ID = cus.CUSTOMER_ID
       INNER JOIN DANIELYN.ORDERS_PRODUCTS op
           ON orders.ordersid = op.order_id
 WHERE cus.FIRST_NAME LIKE 'H%' OR cus.LAST_NAME LIKE 'Z%' AND cus.FIRST_NAME LIKE 'h%' OR cus.LAST_NAME LIKE 'Z%';

 -- Mostrar detalles y calculas del costo del envio de cada orden


 -- productos con un costo mayor a 100

SELECT *
  FROM DANIELYN.ORDERS_PRODUCTS
 WHERE list_price > 100;

 -- promediar el costo de todos los productos y obtener el mayor costo

  SELECT AVG (total)
    FROM (  SELECT ord.ORDER_ID,
                   ord.SUBTOTAL,
                   SUM (op.QUANTITY * prod.list_price) AS total
              FROM DANIELYN.ORDER_ID ord
                   INNER JOIN DANIELYN.ORDERS_PRODUCTS op
                       ON ord.ORDER_ID = op.ORDER_ID
                   INNER JOIN DANIELYN.SALES_PRODUCTS prod
                       ON op.PRODUCT_ID = prod.PRODUCT_ID
          GROUP BY ord.ORDER_ID)
ORDER BY total;