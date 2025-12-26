CREATE OR REPLACE TABLE `kimia-farma-analysis-482113.kimia_farma.kf_analisa` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,

  t.discount_percentage,
  c.rating AS rating_cabang,
  t.rating AS rating_transaksi,

  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS percentage_gross_laba,

  t.price * (1 - t.discount_percentage) AS nett_sales,

  (t.price * (1 - t.discount_percentage)) *
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit

FROM `kimia-farma-analysis-482113.kimia_farma.kf_final_transaction` t
LEFT JOIN `kimia-farma-analysis-482113.kimia_farma.kf_kantor_cabang` c
  ON t.branch_id = c.branch_id
LEFT JOIN `kimia-farma-analysis-482113.kimia_farma.kf_product` p
  ON t.product_id = p.product_id;
