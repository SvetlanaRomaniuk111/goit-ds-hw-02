from faker import Faker
import random

from connect import create_connection, database

fake = Faker()


def seed_users(conn, n=10):
    users = [(fake.name(), fake.unique.email()) for _ in range(n)]
    sql = "INSERT INTO users (fullname, email) VALUES (?, ?)"
    conn.executemany(sql, users)
    conn.commit()


def seed_status(conn):
    statuses = [('new',), ('in progress',), ('completed',)]
    sql = "INSERT OR IGNORE INTO status (name) VALUES (?)"
    conn.executemany(sql, statuses)
    conn.commit()


def seed_tasks(conn, n=20):
    # Отримати всі user_id та status_id
    user_ids = [
        row[0] for row in conn.execute("SELECT id FROM users").fetchall()
    ]
    status_ids = [
        row[0] for row in conn.execute("SELECT id FROM status").fetchall()
    ]
    tasks = []
    for _ in range(n):
        title = fake.sentence(nb_words=6)
        description = fake.text(max_nb_chars=200)
        status_id = random.choice(status_ids)
        user_id = random.choice(user_ids)
        tasks.append((title, description, status_id, user_id))
    sql = (
        "INSERT INTO tasks (title, description, status_id, user_id) "
        "VALUES (?, ?, ?, ?)"
    )
    conn.executemany(sql, tasks)
    conn.commit()


if __name__ == "__main__":
    with create_connection(database) as conn:
        seed_users(conn, 10)
        seed_status(conn)
        seed_tasks(conn, 20)
