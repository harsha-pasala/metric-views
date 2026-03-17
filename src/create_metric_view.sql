USE CATALOG identifier(:catalog);
USE SCHEMA identifier(:schema);

CREATE OR REPLACE VIEW billing_usage_metrics
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing usage metrics for tracking DBU consumption across SKUs and clouds"
  source: system.billing.usage
  filter: record_type = 'ORIGINAL'

  dimensions:
    - name: Usage Date
      expr: usage_date
      comment: "Date of the usage record"
    - name: SKU Name
      expr: sku_name
      comment: "Name of the billing SKU"
    - name: Cloud
      expr: cloud
      comment: "Cloud provider — AWS, AZURE, or GCP"

  measures:
    - name: Total DBU Usage
      expr: SUM(usage_quantity)
      comment: "Total units consumed"
    - name: Record Count
      expr: COUNT(1)
      comment: "Number of usage records"
$$;
