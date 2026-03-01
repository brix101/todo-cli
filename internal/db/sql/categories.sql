-- name: CreateCategory :one
INSERT INTO categories(
  id,
  name,
  updated_at,
  created_at
) VALUES (
  ?,
  ?,
  strftime('%s', 'now'),
  strftime('%s', 'now')
) RETURNING *;

-- name: ListCategories :many
SELECT *
FROM categories
ORDER BY name ASC;
