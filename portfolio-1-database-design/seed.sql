INSERT INTO customers(email, first_name, last_name, phone)
VALUES
    ('ada@example.com', 'Ada', 'Okafor', '08030000001'),
    ('tunde@example.com', 'Tunde', 'Bello', '08030000002'),
    ('zainab@example.com', 'Zainab', 'Yusuf', '08030000003')
    ON CONFLICT (email) DO NOTHING;

INSERT INTO customer_addresses(
    customer_id, recipient_name, phone, street, city, state
)
SELECT
    customer_id,
    first_name || ' ' || last_name,
    COALESCE(phone, '08000000000'),
    '12 Example Street',
    'Lagos',
    'Lagos'
FROM customers
WHERE email IN (
                'ada@example.com',
                'tunde@example.com',
                'zainab@example.com'
    )
  AND NOT EXISTS (
    SELECT 1
    FROM customer_addresses a
    WHERE a.customer_id = customers.customer_id
);

INSERT INTO vendors(business_name, email)
VALUES
    ('Lagos Gadgets Ltd', 'sales@lagosgadgets.example'),
    ('Naija Home Store', 'hello@naijahome.example')
    ON CONFLICT (email) DO NOTHING;

INSERT INTO categories(category_name)
VALUES
    ('Electronics'),
    ('Home Appliances'),
    ('Fashion')
    ON CONFLICT (category_name) DO NOTHING;

INSERT INTO products(
    vendor_id, category_id, sku, product_name,
    description, unit_price, attributes
)
SELECT
    v.vendor_id,
    c.category_id,
    'GAD-PHN-001',
    'Android Smartphone',
    '128GB smartphone',
    285000,
    '{"brand":"ExampleTech","storage_gb":128,"colour":"black"}'
FROM vendors v
         CROSS JOIN categories c
WHERE v.email = 'sales@lagosgadgets.example'
  AND c.category_name = 'Electronics'
    ON CONFLICT (sku) DO NOTHING;

INSERT INTO products(
    vendor_id, category_id, sku, product_name,
    description, unit_price, attributes
)
SELECT
    v.vendor_id,
    c.category_id,
    'HOME-BLD-001',
    'Blender',
    'Five-speed kitchen blender',
    65000,
    '{"brand":"KitchenPro","power_watts":600,"capacity_litres":1.5}'
FROM vendors v
         CROSS JOIN categories c
WHERE v.email = 'hello@naijahome.example'
  AND c.category_name = 'Home Appliances'
    ON CONFLICT (sku) DO NOTHING;

INSERT INTO inventory(product_id, quantity_on_hand)
SELECT
    product_id,
    CASE sku
        WHEN 'GAD-PHN-001' THEN 12
        ELSE 25
        END
FROM products
WHERE sku IN ('GAD-PHN-001', 'HOME-BLD-001')
    ON CONFLICT (product_id) DO NOTHING;

INSERT INTO orders(
    order_number, customer_id, subtotal,
    delivery_fee, total_amount, order_status
)
SELECT
    'SS-2026-0001',
    customer_id,
    285000,
    2500,
    287500,
    'PAID'
FROM customers
WHERE email = 'ada@example.com'
    ON CONFLICT (order_number) DO NOTHING;

INSERT INTO order_items(
    order_id, product_id, product_name_snapshot,
    sku_snapshot, unit_price_snapshot, quantity, line_total
)
SELECT
    o.order_id,
    p.product_id,
    p.product_name,
    p.sku,
    p.unit_price,
    1,
    p.unit_price
FROM orders o
         CROSS JOIN products p
WHERE o.order_number = 'SS-2026-0001'
  AND p.sku = 'GAD-PHN-001'
  AND NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.order_id = o.order_id
);

INSERT INTO payments(
    order_id, provider_reference, payment_provider,
    amount, payment_status, paid_at
)
SELECT
    order_id,
    'PAY-SIM-0001',
    'PAYSTACK',
    287500,
    'SUCCESS',
    NOW()
FROM orders
WHERE order_number = 'SS-2026-0001'
    ON CONFLICT (provider_reference) DO NOTHING;

INSERT INTO reviews(customer_id, product_id, rating, review_text)
SELECT
    c.customer_id,
    p.product_id,
    5,
    'Good product and fast delivery.'
FROM customers c
         CROSS JOIN products p
WHERE c.email = 'ada@example.com'
  AND p.sku = 'GAD-PHN-001'
    ON CONFLICT (customer_id, product_id) DO NOTHING;