package app

import (
	"context"
	"database/sql"
	"sync"

	"github.com/brix101/todocli/internal/category"
	"github.com/brix101/todocli/internal/db"
	"github.com/brix101/todocli/internal/task"
)

type App struct {
	Categories category.Service
	Tasks      task.Service

	watcherCancelFuncs []context.CancelFunc
	cancelFuncsMutex   sync.Mutex
	watcherWG          sync.WaitGroup
}

func New(ctx context.Context, conn *sql.DB) (*App, error) {
	q := db.New(conn)
	categories := category.NewService(q)
	tasks := task.NewService(q)

	app := &App{
		Categories: categories,
		Tasks:      tasks,
	}

	return app, nil
}

// Shutdown performs a clean shutdown of the application
func (app *App) Shutdown() {
	// Cancel all watcher goroutines
	app.cancelFuncsMutex.Lock()
	for _, cancel := range app.watcherCancelFuncs {
		cancel()
	}
	app.cancelFuncsMutex.Unlock()
	app.watcherWG.Wait()
}
