from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryCheckOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
}

with DAG(
    'test_bigquery_connection',
    default_args=default_args,
    start_date=days_ago(1),
    schedule_interval='@once',
    catchup=False,
) as dag:

    bigquery_test = BigQueryCheckOperator(
        task_id='bigquery_test',
        sql="SELECT 1",
        use_legacy_sql=False,
        gcp_conn_id='google_cloud_default',
    )
