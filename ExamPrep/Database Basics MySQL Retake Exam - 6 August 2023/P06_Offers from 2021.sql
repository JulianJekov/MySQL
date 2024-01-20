SELECT *
FROM `property_offers`
WHERE YEAR(`offer_datetime`) = 2021
ORDER BY `price`
LIMIT 10;