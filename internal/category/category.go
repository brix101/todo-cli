package category

import (
	"context"

	"github.com/brix101/todocli/internal/db"
	"github.com/brix101/todocli/internal/pubsub"
	"github.com/google/uuid"
)

type Service interface {
	pubsub.Suscriber[db.Category]
	Create(ctx context.Context, name string) (db.Category, error)
	List(ctx context.Context) ([]db.Category, error)
}

type service struct {
	*pubsub.Broker[db.Category]
	q db.Querier
}

func NewService(q db.Querier) Service {
	return &service{
		Broker: pubsub.NewBroker[db.Category](),
		q:      q,
	}
}

func (s *service) Create(ctx context.Context, name string) (db.Category, error) {
	dbCategory, err := s.q.CreateCategory(ctx, db.CreateCategoryParams{
		ID:   uuid.New().String(),
		Name: name,
	})
	if err != nil {
		return db.Category{}, nil
	}

	s.Publish(pubsub.CreatedEvent, dbCategory)

	return dbCategory, nil
}

func (s *service) List(ctx context.Context) ([]db.Category, error) {
	dbCategories, err := s.q.ListCategories(ctx)
	if err != nil {
		return nil, err
	}

	return dbCategories, nil
}
