package main

import (
	"log/slog"
	"os"

	"github.com/brix101/todocli/cmd"
)

func main() {
	log, err := os.Create("output.log")
	if err != nil {
		panic(err)
	}
	defer log.Close()
	slog.SetDefault(slog.New(slog.NewTextHandler(log, &slog.HandlerOptions{})))

	cmd.Execute()
}
