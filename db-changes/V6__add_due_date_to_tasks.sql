-- Migration V6: add due_date column to tasks
-- Adds column if not exists, fills NULLs with NOW(), and sets NOT NULL

ALTER TABLE tasks ADD COLUMN IF NOT EXISTS due_date TIMESTAMP WITH TIME ZONE;

-- Set a default value for existing rows that have NULL
UPDATE tasks SET due_date = NOW() WHERE due_date IS NULL;

-- Make the column NOT NULL (if your model requires NOT NULL)
ALTER TABLE tasks ALTER COLUMN due_date SET NOT NULL;
