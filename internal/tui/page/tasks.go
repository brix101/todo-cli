package page

import (
	"context"
	"log/slog"

	"charm.land/bubbles/v2/cursor"
	"charm.land/bubbles/v2/table"
	"charm.land/bubbles/v2/textarea"
	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
	"github.com/brix101/todocli/internal/app"
	"github.com/brix101/todocli/internal/db"
	"github.com/brix101/todocli/internal/pubsub"
	"github.com/brix101/todocli/internal/task"
)

var TasksPage PageID = "tasks"

type taskPage struct {
	app *app.App

	table         table.Model
	textarea      textarea.Model
	width, height int
}

type taskCreatedMsg struct {
	task db.Task
}

func (m taskPage) Init() tea.Cmd {
	return func() tea.Msg {
		ctx, cancel := context.WithCancel(context.Background())
		defer cancel()

		ch := m.app.Tasks.Subscribe(ctx)
		for event := range ch {
			slog.Info("Received task event", "type", event.Type, "task_id", event.Payload.ID)
			if event.Type == pubsub.CreatedEvent {
				return taskCreatedMsg{task: event.Payload}
			}
		}
		return nil
	}
}

func (m taskPage) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd
	switch msg := msg.(type) {
	case taskCreatedMsg:
		completed := "No"
		if msg.task.IsCompleted.Valid && msg.task.IsCompleted.Int64 != 0 {
			completed = "Yes"
		}
		slog.Info("New task created", "id", msg.task.ID, "title", msg.task.Title)
		rows := m.table.Rows()
		rows = append(rows, table.Row{
			msg.task.ID,
			msg.task.Title,
			completed,
		})
		m.table.SetRows(rows)

	case tea.WindowSizeMsg:
		msg.Height -= 1
		m.width, m.height = msg.Width, msg.Height

	case tea.KeyPressMsg:
		switch msg.String() {
		case "esc":
			if m.table.Focused() {
				m.table.Blur()
			} else {
				m.table.Focus()
			}

		case "enter":
			title := m.textarea.Value()
			if title != "" {
				if _, err := m.app.Tasks.Create(context.Background(), task.CreateTaskParams{
					Title: title,
				}); err != nil {
					slog.Error("failed to create task", "error", err)
				}

				m.textarea.Reset()
			}

			return m, nil
		default:
			// Send all other keypresses to the textarea.
			var cmd tea.Cmd
			m.textarea, cmd = m.textarea.Update(msg)
			return m, cmd
		}
	case cursor.BlinkMsg:
		// Textarea should also process cursor blinks.
		var cmd tea.Cmd
		m.textarea, cmd = m.textarea.Update(msg)
		return m, cmd
	}

	m.table, cmd = m.table.Update(msg)
	m.textarea, _ = m.textarea.Update(msg)
	return m, cmd
}

func (m taskPage) View() tea.View {
	v := tea.NewView(
		baseStyle.Render(m.table.View()) + "\n " +
			m.table.HelpView() + "\n" +
			baseStyle.Render(m.textarea.View()) + "\n",
	)
	v.AltScreen = true

	return v
}

func NewTasksPage(app *app.App) tea.Model {
	ta := textarea.New()
	ta.Placeholder = "Add new task..."
	ta.Focus()
	ta.SetWidth(60)
	ta.SetHeight(3)

	columns := []table.Column{
		{Title: "ID", Width: 30},
		{Title: "Title", Width: 32},
		{Title: "Completed", Width: 12},
	}

	tasks, err := app.Tasks.List(context.Background())
	if err != nil {
		slog.Error(
			"Error fetching tasks",
			"error", err,
		)
		tea.Printf("Error fetching tasks: %v", err)
		return taskPage{}
	}

	rows := make([]table.Row, 0, len(tasks))
	for _, task := range tasks {
		completed := "No"
		if task.IsCompleted.Valid && task.IsCompleted.Int64 != 0 {
			completed = "Yes"
		}

		rows = append(rows, table.Row{
			task.ID,
			task.Title,
			completed,
		})
	}

	t := table.New(
		table.WithColumns(columns),
		table.WithRows(rows),
		table.WithFocused(true),
		table.WithHeight(20),
		table.WithWidth(140),
	)

	s := table.DefaultStyles()
	s.Header = s.Header.
		BorderStyle(lipgloss.NormalBorder()).
		BorderForeground(lipgloss.Color("240")).
		BorderBottom(true).
		Bold(false)
	s.Selected = s.Selected.
		Foreground(lipgloss.Color("229")).
		Background(lipgloss.Color("57")).
		Bold(false)
	t.SetStyles(s)

	return taskPage{
		app:      app,
		table:    t,
		textarea: ta,
	}
}
