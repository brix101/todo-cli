package page

import (
	"charm.land/bubbles/v2/table"
	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

var CategoriesPage PageID = "categories"

type categoriesPage struct {
	table table.Model
}

func (m categoriesPage) Init() tea.Cmd { return nil }

func (m categoriesPage) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd
	switch msg := msg.(type) {
	case tea.KeyPressMsg:
		switch msg.String() {
		case "esc":
			if m.table.Focused() {
				m.table.Blur()
			} else {
				m.table.Focus()
			}
		case "q", "ctrl+c":
			return m, tea.Quit
		case "enter":
			return m, tea.Batch(
				tea.Printf("Let's go to %s!", m.table.SelectedRow()[1]),
			)
		}
	}
	m.table, cmd = m.table.Update(msg)
	return m, cmd
}

func (m categoriesPage) View() tea.View {
	return tea.NewView(baseStyle.Render(m.table.View()) + "\n  " + m.table.HelpView() + "\n")
}

func NewCategoriesPage() tea.Model {
	columns := []table.Column{
		{Title: "ID", Width: 4},
		{Title: "Title", Width: 20},
		{Title: "Status", Width: 10},
	}

	// Example category items. Replace with real data source as needed.
	rows := []table.Row{
		{"1", "Work", "Active"},
		{"2", "Personal", "Active"},
		{"3", "Hobbies", "Inactive"},
		{"4", "Fitness", "Active"},
	}

	t := table.New(
		table.WithColumns(columns),
		table.WithRows(rows),
		table.WithFocused(true),
		table.WithHeight(7),
		table.WithWidth(42),
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

	return categoriesPage{t}
}
