package tui

import (
	"fmt"

	"github.com/brix101/todocli/internal/app"

	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

var (
	keywordStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("204")).Background(lipgloss.Color("235"))
	helpStyle    = lipgloss.NewStyle().Foreground(lipgloss.Color("241"))
)

type appModel struct {
	app        *app.App
	altscreen  bool
	quitting   bool
	suspending bool
}

func (m appModel) Init() tea.Cmd {
	return nil
}

func (m appModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.ResumeMsg:
		m.suspending = false
		return m, nil
	case tea.KeyPressMsg:
		switch msg.String() {
		case "q", "ctrl+c", "esc":
			m.quitting = true
			return m, tea.Quit
		case "ctrl+z":
			m.suspending = true
			return m, tea.Suspend
		case "space":
			var cmd tea.Cmd
			m.altscreen = !m.altscreen
			return m, cmd
		}
	}
	return m, nil
}

func (m appModel) View() tea.View {
	if m.suspending {
		v := tea.NewView("")
		v.AltScreen = m.altscreen
		return v
	}

	if m.quitting {
		v := tea.NewView("Bye!\n")
		v.AltScreen = m.altscreen
		return v
	}

	const (
		altscreenMode = " altscreen mode "
		inlineMode    = " inline mode "
	)

	var mode string
	if m.altscreen {
		mode = altscreenMode
	} else {
		mode = inlineMode
	}

	v := tea.NewView(fmt.Sprintf("\n\n  You're in %s\n\n\n", keywordStyle.Render(mode)) +
		helpStyle.Render("  space: switch modes • ctrl-z: suspend • q: exit\n"))
	v.AltScreen = m.altscreen
	return v
}

func New(app *app.App) tea.Model {
	model := &appModel{
		app: app,
	}
	return model
}
