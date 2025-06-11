-- 1. Отримати всі завдання певного користувача
-- Використайте SELECT для отримання завдань конкретного користувача за його user_id.
SELECT * FROM tasks WHERE user_id = 2;

-- 2. Вибрати завдання за певним статусом. 
-- Використайте підзапит для вибору завдань з конкретним статусом, наприклад, 'new'.
SELECT id, title, description, status_id, user_id
FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);

-- 3. Оновити статус конкретного завдання.
-- Змініть статус конкретного завдання на 'in progress' або інший статус.
UPDATE tasks
SET status_id = (SELECT id FROM status WHERE name = 'in progress')
WHERE id = 5;

--4. Отримати список користувачів, які не мають жодного завдання. 
-- Використайте комбінацію SELECT, WHERE NOT IN і підзапит.
SELECT id, fullname 
FROM users
WHERE id NOT IN (SELECT user_id FROM tasks);

-- 5. Додати нове завдання для конкретного користувача. 
-- Використайте INSERT для додавання нового завдання.
INSERT INTO tasks (title, description, status_id, user_id)
VALUES (
    'Prepare quarterly financial report.',
    '',
    (SELECT id FROM status WHERE name = 'new'),
    3
);

-- 6. Отримати всі завдання, які ще не завершено. 
-- Виберіть завдання, чий статус не є 'завершено'.
SELECT id, title, description, status_id, user_id
FROM tasks
WHERE status_id IN (
    SELECT id FROM status WHERE name != 'completed' 
);

-- 7. Видалити конкретне завдання. 
-- Використайте DELETE для видалення завдання за його id.
DELETE FROM tasks WHERE id = 23;

-- 8. Знайти користувачів з певною електронною поштою. 
-- Використайте SELECT із умовою LIKE для фільтрації за електронною поштою.
SELECT *
FROM users
WHERE email LIKE "%@example.org";

-- 9. Оновити ім'я користувача. 
-- Змініть ім'я користувача за допомогою UPDATE.
UPDATE users SET fullname = 'Marco Tapia' WHERE id = 7;

-- 10. Отримати кількість завдань для кожного статусу. 
-- Використайте SELECT, COUNT, GROUP BY для групування завдань за статусами.
SELECT s.name AS status, COUNT(t.id) AS total
FROM tasks t
JOIN status s ON t.status_id = s.id
GROUP BY s.name;

-- 11. Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. 
-- Використайте SELECT з умовою LIKE в поєднанні з JOIN, щоб вибрати завдання, 
--призначені користувачам, чия електронна пошта містить певний домен (наприклад, '%@example.com').
SELECT t.id, t.title, t.description, t.status_id, t.user_id, u.email
FROM tasks t
JOIN users u ON t.user_id = u.id
WHERE u.email LIKE '%@example.com';

-- 12. Отримати список завдань, що не мають опису. 
-- Виберіть завдання, у яких відсутній опис.
SELECT *
FROM tasks
WHERE description IS NULL OR description = '';

-- 13. Вибрати користувачів та їхні завдання, які є у статусі 'in progress'. 
-- Використайте INNER JOIN для отримання списку користувачів та їхніх завдань із певним статусом.
SELECT u.id AS user_id, u.fullname, t.id AS task_id, t.title, t.description, s.name AS status
FROM users u
INNER JOIN tasks t ON u.id = t.user_id
INNER JOIN status s ON t.status_id = s.id
WHERE s.name = 'in progress';

-- 14. Отримати користувачів та кількість їхніх завдань. 
-- Використайте LEFT JOIN та GROUP BY для вибору користувачів та підрахунку їхніх завдань.
SELECT u.id, u.fullname, u.email, COUNT(t.id) AS task_count
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id, u.fullname, u.email
ORDER BY u.id;