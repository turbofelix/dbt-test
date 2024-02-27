import os
import pandas as pd
from sqlalchemy import create_engine, Column, Integer, Text, TIMESTAMP, MetaData, Table
from sqlalchemy.exc import ProgrammingError
from sqlalchemy.schema import CreateSchema
from dotenv import load_dotenv

load_dotenv()


host = "db"
port = 5432
db = os.getenv("POSTGRES_DB")
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')


def create_tables(engine, connection):

    metadata = MetaData()

    try:
        connection.execute(CreateSchema('stg'))
        # connection.execute("COMMIT;")
    except ProgrammingError:
        print("Schema already exists.")


    listings = Table('listings', metadata,
                    Column('id', Integer),
                    Column('listing_url', Text),
                    Column('name', Text),
                    Column('room_type', Text),
                    Column('minimum_nights', Integer),
                    Column('host_id', Integer),
                    Column('price', Text),
                    Column('created_at', TIMESTAMP),
                    Column('updated_at', TIMESTAMP),
                    schema='stg')

    reviews = Table('reviews', metadata,
                    Column('listing_id', Integer),
                    Column('date', TIMESTAMP),
                    Column('reviewer_name', Text),
                    Column('comments', Text),
                    Column('sentiment', Text),
                    schema='stg')

    hosts = Table('hosts', metadata,
                Column('id', Integer),
                Column('name', Text),
                Column('is_superhost', Text),
                Column('created_at', TIMESTAMP),
                Column('updated_at', TIMESTAMP),
                schema='stg')

    metadata.create_all(engine)


def insert_data_from_csv(engine, csv_path, table_name):

    df = pd.read_csv(csv_path)

    df.to_sql(table_name, engine, schema='stg', if_exists='replace', index=False)



def main():

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    connection = engine.connect()
    connection.execution_options(isolation_level="AUTOCOMMIT")

    create_tables(engine, connection)
    print("Created tables.")

    insert_data_from_csv(engine, './raw/listings.csv', 'listings')
    insert_data_from_csv(engine, './raw/reviews.csv', 'reviews')
    insert_data_from_csv(engine, './raw/hosts.csv', 'hosts')
    print("Inserted data.")    

    connection.close()

if __name__ == '__main__':
    main()