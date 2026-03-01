-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    updated_at INTEGER NOT NULL, -- Unix timestamp in milliseconds
    created_at INTEGER NOT NULL -- Unix timestamp in milliseconds
);

CREATE TRIGGER IF NOT EXISTS update_categories_updated_at
AFTER UPDATE ON categories
BEGIN
    UPDATE categories SET updated_at = strftime('%s', 'now')
    WHERE id = new.id;
END;

CREATE TABLE IF NOT EXISTS tasks (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    is_completed INTEGER DEFAULT 0,
    priority INTEGER DEFAULT 2,
    due_date INTEGER, -- Unix timestamp in milliseconds
    category_id TEXT,
    updated_at INTEGER NOT NULL, -- Unix timestamp in milliseconds
    created_at INTEGER NOT NULL, -- Unix timestamp in milliseconds
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_tasks_category ON tasks(category_id);
CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(is_completed);

CREATE TRIGGER IF NOT EXISTS update_tasks_updated_at
AFTER UPDATE ON tasks
BEGIN
    UPDATE tasks SET updated_at = strftime('%s', 'now')
    WHERE id = new.id;
END;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP INDEX IF EXISTS idx_tasks_status;
DROP INDEX IF EXISTS idx_tasks_category;

DROP TRIGGER IF EXISTS update_tasks_updated_at;

DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS categories;
-- +goose StatementEnd
