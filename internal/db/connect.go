package db

import (
	"database/sql"
	"fmt"
	"log/slog"
	"os"
	"path/filepath"

	_ "github.com/ncruces/go-sqlite3/driver"
	_ "github.com/ncruces/go-sqlite3/embed"

	"github.com/pressly/goose/v3"
)

func Connect() (*sql.DB, error) {
	dataDir := ".todocli" // TODO: make this configurable
	if dataDir == "" {
		return nil, fmt.Errorf("data directory is not set")
	}

	if err := os.MkdirAll(dataDir, 0o700); err != nil {
		return nil, fmt.Errorf("failed to create data directory: %w", err)
	}

	dbPath := filepath.Join(dataDir, "todocli.db")

	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return nil, fmt.Errorf("failed to open database: %w", err)
	}

	if err = db.Ping(); err != nil {
		db.Close()
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}

	// Set pragmas for better performance
	pragmas := []string{
		"PRAGMA foreign_keys = ON;",
		"PRAGMA journal_mode = WAL;",
		"PRAGMA page_size = 4096;",
		"PRAGMA cache_size = -8000;",
		"PRAGMA synchronous = NORMAL;",
	}

	for _, pragma := range pragmas {
		if _, err = db.Exec(pragma); err != nil {
			slog.Error("Failed to set pragma",
				"pragma", pragma,
				"error", err,
			)
		} else {
			slog.Info("Set pragma",
				"pragma", pragma,
			)
		}
	}

	goose.SetBaseFS(FS)

	if err := goose.SetDialect("sqlite3"); err != nil {
		slog.Error("Failed to set dialect: %v\n", "error", err)
		return nil, fmt.Errorf("failed to set dialect: %w", err)
	}

	if err := goose.Up(db, "migrations"); err != nil {
		slog.Error("Failed to apply migrations: %v\n", "error", err)
		return nil, fmt.Errorf("failed to apply migrations: %w", err)
	}

	return db, nil
}
