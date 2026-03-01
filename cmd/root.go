package cmd

import (
	"context"
	"fmt"
	"log/slog"
	"os"

	tea "charm.land/bubbletea/v2"
	"github.com/brix101/todocli/internal/app"
	"github.com/brix101/todocli/internal/db"
	"github.com/brix101/todocli/internal/tui"
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:     "todocli",
	Short:   "",
	Long:    "",
	Example: "",
	RunE: func(cmd *cobra.Command, args []string) error {
		// Connect DB, this will also run migrations
		conn, err := db.Connect()
		if err != nil {
			return err
		}

		// Create main context for the application
		ctx, cancel := context.WithCancel(context.Background())
		defer cancel()

		app, err := app.New(ctx, conn)
		if err != nil {
			slog.Error("Failed to create app: %v", "error", err)
			return err
		}

		program := tea.NewProgram(
			tui.New(app),
		)

		cleanUp := func() {
			app.Shutdown()
		}

		result, err := program.Run()
		cleanUp()

		if err != nil {

			slog.Error("TUI error: %v", "error", err)
			return fmt.Errorf("TUI error: %v", err)
		}

		slog.Info("TUI exited with result: %v", "error", result)
		return nil
	},
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
