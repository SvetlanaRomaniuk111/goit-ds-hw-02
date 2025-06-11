# 1. Отримати всі завдання певного користувача
import sqlite3


def all_task_user_id(sql: str) -> list:
    with sqlite3.connect('todo.db') as con:
        cur = con.cursor()
        cur.execute(sql)
        return cur.fetchall()


sql = """
SELECT * FROM tasks WHERE user_id = 2;
"""

result = all_task_user_id(sql)
for row in result:
    print(row)
# print(all_task_user_id(sql))

"""
(2, 'Identify pretty with particular company old collection.',
 'Pick resource rise third half force my. Magazine husband interview society '
 'grow benefit.\n'
 'Fill behavior face work ready. Citizen discussion deal least western give.',
 1, 2)
(20, 'Away foot ahead majority artist support beautiful.',
 'Again up author themselves official who various.\n'
 'Responsibility clear stay middle protect sometimes. Save seem bank. '
 'Into whatever billion. Admit however partner animal consider fill recent.',
 1, 2)
"""
