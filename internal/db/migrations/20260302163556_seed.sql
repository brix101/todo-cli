-- +goose Up
-- +goose StatementBegin
-- Insert initial categories
INSERT INTO categories (id, name, updated_at, created_at) VALUES
    ('b3b1a1e0-0001-4c1a-9a1a-000000000001', 'Work', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0002-4c1a-9a1a-000000000002', 'Personal', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0003-4c1a-9a1a-000000000003', 'Errands', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0004-4c1a-9a1a-000000000004', 'Learning', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0005-4c1a-9a1a-000000000005', 'Fitness', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0006-4c1a-9a1a-000000000006', 'Shopping', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0007-4c1a-9a1a-000000000007', 'Travel', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0008-4c1a-9a1a-000000000008', 'Finance', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0009-4c1a-9a1a-000000000009', 'Health', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    ('b3b1a1e0-0010-4c1a-9a1a-000000000010', 'Home', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000);

    -- Insert initial tasks with millisecond timestamps
-- INSERT INTO tasks (id, title, description, is_completed, priority, due_date, category_id, updated_at, created_at) VALUES
    -- ('c1a1b1e0-0001-4c1a-9a1a-000000000001', 'Buy groceries', 'Milk, eggs, bread, and fruits', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0002-4c1a-9a1a-000000000002', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000)
    -- ('c1a1b1e0-0002-4c1a-9a1a-000000000002', 'Finish project report', 'Complete the final report for Q1 project', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0001-4c1a-9a1a-000000000001', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0003-4c1a-9a1a-000000000003', 'Call Alice', 'Discuss weekend plans', 1, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0002-4c1a-9a1a-000000000002', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0004-4c1a-9a1a-000000000004', 'Read Go book', 'Read chapters 1-3 of Go Programming', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0004-4c1a-9a1a-000000000004', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0005-4c1a-9a1a-000000000005', 'Morning run', 'Run 5km in the park', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0005-4c1a-9a1a-000000000005', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0006-4c1a-9a1a-000000000006', 'Pay electricity bill', 'Due this week', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0008-4c1a-9a1a-000000000008', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0007-4c1a-9a1a-000000000007', 'Book flight tickets', 'Vacation to Japan', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0007-4c1a-9a1a-000000000007', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0008-4c1a-9a1a-000000000008', 'Doctor appointment', 'Annual checkup', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0009-4c1a-9a1a-000000000009', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0009-4c1a-9a1a-000000000009', 'Clean kitchen', 'Deep clean the kitchen area', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0010-4c1a-9a1a-000000000010', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0010-4c1a-9a1a-000000000010', 'Yoga session', 'Attend online yoga class', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0005-4c1a-9a1a-000000000005', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0011-4c1a-9a1a-000000000011', 'Buy birthday gift', 'Gift for John', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0006-4c1a-9a1a-000000000006', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0012-4c1a-9a1a-000000000012', 'Grocery shopping', 'Weekly groceries', 1, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0006-4c1a-9a1a-000000000006', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0013-4c1a-9a1a-000000000013', 'Team meeting', 'Discuss project milestones', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0001-4c1a-9a1a-000000000001', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0014-4c1a-9a1a-000000000014', 'Dentist appointment', 'Teeth cleaning', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0009-4c1a-9a1a-000000000009', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0015-4c1a-9a1a-000000000015', 'Laundry', 'Wash and fold clothes', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0010-4c1a-9a1a-000000000010', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0016-4c1a-9a1a-000000000016', 'Budget review', 'Review monthly expenses', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0008-4c1a-9a1a-000000000008', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0017-4c1a-9a1a-000000000017', 'Renew car insurance', 'Due next month', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0008-4c1a-9a1a-000000000008', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0018-4c1a-9a1a-000000000018', 'Plan vacation', 'Research destinations', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0007-4c1a-9a1a-000000000007', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0019-4c1a-9a1a-000000000019', 'Write blog post', 'Topic: Productivity tips', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0004-4c1a-9a1a-000000000004', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0020-4c1a-9a1a-000000000020', 'Fix leaking faucet', 'Kitchen sink faucet leaking', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0010-4c1a-9a1a-000000000010', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0021-4c1a-9a1a-000000000021', 'Meditation', '10 minutes mindfulness', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0005-4c1a-9a1a-000000000005', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0022-4c1a-9a1a-000000000022', 'Update LinkedIn profile', 'Add recent project achievements', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0001-4c1a-9a1a-000000000001', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0023-4c1a-9a1a-000000000023', 'Email client feedback', 'Send summary of last meeting', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0001-4c1a-9a1a-000000000001', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0024-4c1a-9a1a-000000000024', 'Call Grandma', 'Catch up on weekly news', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0002-4c1a-9a1a-000000000002', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0025-4c1a-9a1a-000000000025', 'Organize bookshelf', 'Sort by genre and author', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0002-4c1a-9a1a-000000000002', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0026-4c1a-9a1a-000000000026', 'Pick up dry cleaning', 'Suits for the wedding', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0003-4c1a-9a1a-000000000003', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0027-4c1a-9a1a-000000000027', 'Drop off donations', 'Old clothes to the center', 0, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0003-4c1a-9a1a-000000000003', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0028-4c1a-9a1a-000000000028', 'Watch SQL tutorial', 'Window functions deep dive', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0004-4c1a-9a1a-000000000004', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0029-4c1a-9a1a-000000000029', 'Practice Spanish', '30 mins on Duolingo', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0004-4c1a-9a1a-000000000004', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0030-4c1a-9a1a-000000000030', 'Swimming session', '40 laps at the local pool', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0005-4c1a-9a1a-000000000005', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0031-4c1a-9a1a-000000000031', 'Buy new running shoes', 'Old ones are worn out', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0005-4c1a-9a1a-000000000005', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0032-4c1a-9a1a-000000000032', 'Order ergonomic chair', 'Office setup improvement', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0006-4c1a-9a1a-000000000006', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0033-4c1a-9a1a-000000000033', 'Buy coffee beans', 'Arabica medium roast', 1, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0006-4c1a-9a1a-000000000006', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0034-4c1a-9a1a-000000000034', 'Renew passport', 'Check requirements online', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0007-4c1a-9a1a-000000000007', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0035-4c1a-9a1a-000000000035', 'Buy travel adapter', 'Universal plug for Japan', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0007-4c1a-9a1a-000000000007', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0036-4c1a-9a1a-000000000036', 'Tax preparation', 'Gather all receipts for 2025', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0008-4c1a-9a1a-000000000008', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0037-4c1a-9a1a-000000000037', 'Check credit score', 'Monthly financial health check', 1, 3, strftime('%s', 'now') * 1000, 'b3b1a1e0-0008-4c1a-9a1a-000000000008', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0038-4c1a-9a1a-000000000038', 'Refill vitamin D', '3 month supply', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0009-4c1a-9a1a-000000000009', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0039-4c1a-9a1a-000000000039', 'Eye exam', 'Update glasses prescription', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0009-4c1a-9a1a-000000000009', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0040-4c1a-9a1a-000000000040', 'Water the plants', 'Indoor and balcony garden', 0, 2, strftime('%s', 'now') * 1000, 'b3b1a1e0-0010-4c1a-9a1a-000000000010', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000),
    -- ('c1a1b1e0-0041-4c1a-9a1a-000000000041', 'Replace air filters', 'HVAC maintenance', 0, 1, strftime('%s', 'now') * 1000, 'b3b1a1e0-0010-4c1a-9a1a-000000000010', strftime('%s', 'now') * 1000, strftime('%s', 'now') * 1000);
    --
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
