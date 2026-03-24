package tui

import (
	"github.com/brix101/todocli/internal/app"
	"github.com/brix101/todocli/internal/tui/page"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

type appModel struct {
	width, height int
	app           *app.App
	currentPage   page.PageID
	pages         map[page.PageID]tea.Model
}

func (a appModel) Init() tea.Cmd {
	return nil
}

func (a appModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmds []tea.Cmd
	var cmd tea.Cmd
	switch msg := msg.(type) {
	case tea.KeyPressMsg:
		switch msg.String() {
		// case "q", "ctrl+c":
		case "ctrl+c":
			return a, tea.Quit
		}

		a.pages[a.currentPage], cmd = a.pages[a.currentPage].Update(msg)
		cmds = append(cmds, cmd)
	}
	return a, tea.Batch(cmds...)
}

func (a appModel) View() tea.View {
	components := a.pages[a.currentPage]

	appView := lipgloss.JoinVertical(
		lipgloss.Top, components.View().Content,
	)

	v := tea.NewView(appView)
	return v
}

func New(app *app.App) tea.Model {
	startPage := page.TasksPage

	model := &appModel{
		app:         app,
		currentPage: startPage,
		pages: map[page.PageID]tea.Model{
			page.TasksPage: page.NewTasksPage(app),
			// page.CategoriesPage: page.NewCategoriesPage(),
		},
	}

	return model
}
