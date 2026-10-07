
CREATE TABLE public.sales_products (
	product_id varchar(50) NOT NULL,
	product_name varchar(255) NULL,
	category varchar(100) NULL,
	revenue_rub numeric(15, 2) NULL,
	margin_rub numeric(15, 2) NULL,
	sales_qty int4 NULL,
	stock_on_hand int4 NULL,
	CONSTRAINT sales_products_pkey PRIMARY KEY (product_id)
);

CREATE TABLE public.supplier_orders (
	order_id serial4 NOT NULL,
	supplier_name varchar(255) NULL,
	planned_delivery date NULL,
	actual_delivery date NULL,
	ordered_qty int4 NULL,
	received_qty int4 NULL,
	product_id varchar(50) NULL,
	CONSTRAINT supplier_orders_pkey PRIMARY KEY (order_id)
);
