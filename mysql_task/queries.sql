# 1st query

SELECT product_name, product_img_url, product_url, product_price_min, product_short_description
FROM grommet_products
JOIN grommet_product_categories ON grommet_products.id = grommet_product_categories.product_id
JOIN grommet_gifts_categories ON grommet_product_categories.product_category_id = grommet_gifts_categories.id
WHERE is_sold_out = 0
AND grommet_gifts_categories.sub_category = "Jewelry";


# 2nd query

SELECT product_name, product_img_url, product_url, product_price_min, product_short_description
FROM grommet_products
JOIN grommet_product_to_keyword ON grommet_products.id = grommet_product_to_keyword.product_id
JOIN grommet_product_keywords ON grommet_product_to_keyword.keyword_id = grommet_product_keywords.id
WHERE is_sold_out = 0
AND grommet_product_keywords.keyword = "Hair accessor";


# 3rd query

SELECT DISTINCT
    p.product_name,
    p.product_img_url,
    p.product_url,
    p.product_price_min,
    p.product_short_description
FROM
grommet_products p
JOIN grommet_product_categories pc ON p.id = pc.product_id
JOIN grommet_gifts_categories gc ON pc.product_category_id = gc.id
LEFT JOIN grommet_product_to_keyword pk ON p.id = pk.product_id
LEFT JOIN grommet_product_keywords k ON pk.keyword_id = k.id
WHERE
(gc.sub_category = 'Beauty & Personal Care' OR gc.sub_category = 'Skincare'
OR k.keyword = 'Aromatherapy')
AND p.is_sold_out = 0
ORDER BY p.product_name;
