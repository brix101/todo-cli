package task

import (
	"context"
	"database/sql"
	"time"

	"github.com/brix101/todocli/internal/db"
	"github.com/brix101/todocli/internal/pubsub"
	"github.com/google/uuid"
)

type CreateTaskParams struct {
	Title       string
	Description string
	DueDate     string
	CategoryID  string
}

type Service interface {
	pubsub.Suscriber[db.Task]
	Create(ctx context.Context, params CreateTaskParams) (db.Task, error)
	Get(ctx context.Context, id string) (db.Task, error)
	List(ctx context.Context) ([]db.Task, error)
}

type service struct {
	*pubsub.Broker[db.Task]
	q db.Querier
}

func NewService(q db.Querier) Service {
	return &service{
		Broker: pubsub.NewBroker[db.Task](),
		q:      q,
	}
}

func (s *service) Delete(ctx context.Context, id string) error {
	task, err := s.Get(ctx, id)
	if err != nil {
		return err
	}
	err = s.q.DeleteTask(ctx, task.ID)
	if err != nil {
		return err
	}
	s.Publish(pubsub.DeletedEvent, task)
	return nil
}

func (s *service) Get(ctx context.Context, id string) (db.Task, error) {
	dbTask, err := s.q.GetTask(ctx, id)
	if err != nil {
		return db.Task{}, err
	}
	return dbTask, nil
}

func (s *service) Create(ctx context.Context, params CreateTaskParams) (db.Task, error) {
	dbTask, err := s.q.CreateTask(ctx, db.CreateTaskParams{
		ID:          uuid.New().String(),
		Title:       params.Title,
		Description: sql.NullString{String: string(params.Description), Valid: true},
		DueDate: sql.NullInt64{
			Int64: time.Now().Add(24 * time.Hour).UnixMilli(),
			Valid: true,
		},
		CategoryID: sql.NullString{String: string(params.CategoryID), Valid: true},
	})
	if err != nil {
		return db.Task{}, nil
	}

	s.Publish(pubsub.CreatedEvent, dbTask)
	return dbTask, nil
}

func (s *service) List(ctx context.Context) ([]db.Task, error) {
	dbTasks, err := s.q.ListTasks(ctx)
	if err != nil {
		return nil, err
	}

	return dbTasks, nil
}
