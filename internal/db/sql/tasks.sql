-- name: GetTask :one
SELECT *
FROM tasks
WHERE id = ? LIMIT 1;

-- name: ListTasks :many
SELECT * from tasks
order by created_at desc;

-- name: CreateTask :one
INSERT INTO tasks(
  id,
  title,
  description,
  is_completed,
  priority,
  due_date,
  updated_at,
  created_at
) VALUES (
  ?,
  ?,
  ?,
  ?,
  ?,
  ?,
  strftime('%s', 'now'),
  strftime('%s', 'now')
) RETURNING *;

-- name: UpdateTask :one
UPDATE tasks
SET
    title = ?,
    description = ?,
    is_completed = ?,
    priority = ?,
    due_date = ?
WHERE id = ?
RETURNING *;

-- name: DeleteTask :exec
DELETE FROM tasks
WHERE id = ?;
