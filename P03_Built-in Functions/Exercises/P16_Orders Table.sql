SELECT `product_name`, `order_date`,
#DATE_ADD(`order_date`, interval 3 day) AS 'pay_due'
ADDDATE(`order_date`, interval(3) day) AS 'pay_due',
adddate(`order_date`, interval(1) month) AS 'delivery_due'
FROM `orders`;