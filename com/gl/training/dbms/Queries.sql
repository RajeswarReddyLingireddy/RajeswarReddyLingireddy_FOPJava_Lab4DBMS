#Display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000.
SELECT CUS_GENDER,COUNT(*) NUMBER_OF_CUSTOMERS FROM CUSTOMER
WHERE (CUS_NAME,CUS_GENDER) IN (SELECT  DISTINCT C.CUS_NAME,C.CUS_GENDER  FROM CUSTOMER C,ORDERS O
WHERE C.CUS_ID = O.CUS_ID
AND O.ORD_AMOUNT >=3000 )
GROUP BY CUS_GENDER;

#Display all the orders along with product name ordered by a customer having Customer_Id=2
SELECT O.* ,P.PRO_NAME FROM ORDERS O,SUPPLIER_PRICING SP,PRODUCT P
WHERE O.PRICING_ID=SP.PRICING_ID
AND SP.PRO_ID = P.PRO_ID
AND O.CUS_ID=2;

#Display the Supplier details who can supply more than one product.
SELECT * FROM SUPPLIER
WHERE SUPP_ID IN (
SELECT SUPP_ID FROM SUPPLIER_PRICING
GROUP BY SUPP_ID
HAVING COUNT(SUPP_ID)>1);

#Find the least expensive product from each category and print the table with category id, name, product name and price of the product
SELECT C.CAT_ID,C.CAT_NAME,P.PRO_NAME,SP.SUPP_PRICE FROM CATEGORY C,PRODUCT P,SUPPLIER_PRICING SP,
(SELECT P.CAT_ID,MIN(SP.SUPP_PRICE) SUPP_PRICE FROM PRODUCT P,SUPPLIER_PRICING SP
WHERE P.PRO_ID=SP.PRO_ID
GROUP BY P.CAT_ID) CP
WHERE C.CAT_ID = CP.CAT_ID
AND  C.CAT_ID = P.CAT_ID
AND P.PRO_ID=SP.PRO_ID
AND CP.SUPP_PRICE = SP.SUPP_PRICE;

#Display the Id and Name of the Product ordered after “2021-10-05”.
SELECT P.PRO_ID,P.PRO_NAME FROM ORDERS O,SUPPLIER_PRICING SP,PRODUCT P
WHERE O.PRICING_ID = SP.PRICING_ID
AND SP.PRO_ID=P.PRO_ID
AND O.ORD_DATE >'2021-10-05';

#Display customer name and gender whose names start or end with character 'A'.
SELECT CUS_NAME,CUS_GENDER FROM CUSTOMER
WHERE LEFT(CUS_NAME,1) = 'A'
OR RIGHT(CUS_NAME,1)='A';


#stored procedure call
CALL displaySupplierRatings()