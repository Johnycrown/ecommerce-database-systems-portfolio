BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Lock the inventory row.

SELECT
    product_id,
    quantity_on_hand,
    quantity_reserved
FROM inventory
WHERE product_id = (
    SELECT product_id
    FROM products
    WHERE sku = 'GAD-PHN-001'
)
    FOR UPDATE;


-- Reduce available stock only if enough is available.

UPDATE inventory
SET
    quantity_on_hand = quantity_on_hand - 1,
    quantity_reserved = quantity_reserved + 1,
    updated_at = NOW()
WHERE product_id = (
    SELECT product_id
    FROM products
    WHERE sku = 'GAD-PHN-001'
)
  AND quantity_on_hand - quantity_reserved >= 1
    RETURNING product_id, quantity_on_hand, quantity_reserved;


-- Create a demonstration order.

INSERT INTO orders (
    order_number,
    customer_id,
    subtotal,
    delivery_fee,
    total_amount,
    order_status
)
SELECT
    'SS-DEMO-' ||
    TO_CHAR(CLOCK_TIMESTAMP(), 'YYYYMMDDHH24MISSMS'),
    customer_id,
    285000,
    2500,
    287500,
    'PENDING'
FROM customers
WHERE email = 'tunde@example.com'
    RETURNING order_id;


-- Roll back this teaching example.
-- In a real application, insert the order item and payment
-- intent, check the stock update row count, then COMMIT.

ROLLBACK;