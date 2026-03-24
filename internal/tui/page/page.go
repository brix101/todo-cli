package page

import "charm.land/lipgloss/v2"

type PageID string

// PageChangeMsg is used to change the current page
type PageChangeMsg struct {
	ID PageID
}

var baseStyle = lipgloss.NewStyle().
	BorderStyle(lipgloss.NormalBorder()).
	BorderForeground(lipgloss.Color("240"))
