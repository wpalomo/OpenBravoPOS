SELECT 
    TICKETS.CUSTOMER,
    TICKETS.TICKETID,
    RECEIPTS.DATENEW,
    PRODUCTS.REFERENCE,
    PRODUCTS.NAME,
    SUM(TICKETLINES.UNITS) AS UNITS,
    SUM(TICKETLINES.UNITS * TICKETLINES.PRICE) AS TOTAL
FROM
    RECEIPTS,
    TICKETS,
    TICKETLINES
        LEFT OUTER JOIN
    PRODUCTS ON TICKETLINES.PRODUCT = PRODUCTS.ID
WHERE RECEIPTS.ID = TICKETS.ID
        AND TICKETS.ID = TICKETLINES.TICKET
        AND (RECEIPTS.DATENEW >= { ts '2018-11-16 00:00:00.000' }
        AND RECEIPTS.DATENEW <= { ts '2018-11-18 00:00:00.000' })
GROUP BY TICKETS.CUSTOMER, TICKETS.TICKETID, RECEIPTS.DATENEW, PRODUCTS.REFERENCE , PRODUCTS.NAME
ORDER BY PRODUCTS.NAME , TICKETS.CUSTOMER , RECEIPTS.DATENEW