package layout

import (
	tea "charm.land/bubbletea/v2"
	"charm.land/lipgloss/v2"
)

type Container interface {
	tea.Model
	Sizeable
	Bindings
}
type container struct {
	width  int
	height int

	content tea.Model

	// Style options
	paddingTop    int
	paddingRight  int
	paddingBottom int
	paddingLeft   int

	borderTop    bool
	borderRight  bool
	borderBottom bool
	borderLeft   bool
	borderStyle  lipgloss.Border
}
