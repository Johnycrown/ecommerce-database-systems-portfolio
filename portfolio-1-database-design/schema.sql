CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(150) UNIQUE NOT NULL,
                       role VARCHAR(20) CHECK (role IN ('customer', 'vendor', 'admin')) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
                            category_id SERIAL PRIMARY KEY,
                            category_name VARCHAR(100) UNIQUE NOT NULL,
                            parent_category_id INT REFERENCES categories(category_id)
);

CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          vendor_id INT NOT NULL REFERENCES users(user_id),
                          category_id INT NOT NULL REFERENCES categories(category_id),
                          product_name VARCHAR(200) NOT NULL,
                          unit_price DECIMAL(12, 2) CHECK (unit_price >= 0) NOT NULL,
                          stock_quantity INT CHECK (stock_quantity >= 0) NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT NOT NULL REFERENCES users(user_id),
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        total_amount DECIMAL(12, 2) CHECK (total_amount >= 0) NOT NULL,
                        order_status VARCHAR(30) CHECK (order_status IN ('pending', 'paid', 'shipped', 'delivered', 'cancelled')) NOT NULL
);

CREATE TABLE order_items (
                             order_item_id SERIAL PRIMARY KEY,
                             order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
                             product_id INT NOT NULL REFERENCES products(product_id),
                             quantity INT CHECK (quantity > 0) NOT NULL,
                             price_at_purchase DECIMAL(12, 2) NOT NULL,
                             UNIQUE (order_id, product_id)
);

CREATE TABLE payments (
                          payment_id SERIAL PRIMARY KEY,
                          order_id INT UNIQUE NOT NULL REFERENCES orders(order_id),
                          payment_method VARCHAR(50) NOT NULL,
                          amount_paid DECIMAL(12, 2) NOT NULL,
                          payment_status VARCHAR(20) CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')) NOT NULL,
                          paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE deliveries (
                            delivery_id SERIAL PRIMARY KEY,
                            order_id INT UNIQUE NOT NULL REFERENCES orders(order_id),
                            tracking_number VARCHAR(100) UNIQUE NOT NULL,
                            shipping_address TEXT NOT NULL,
                            delivery_status VARCHAR(30) CHECK (delivery_status IN ('preparing', 'in_transit', 'delivered', 'returned')) NOT NULL,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);