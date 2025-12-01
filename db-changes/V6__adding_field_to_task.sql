ALTER TABLE public.tasks
    ADD COLUMN IF NOT EXISTS completed BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE public.tasks
    ADD COLUMN IF NOT EXISTS priority VARCHAR(20) NOT NULL DEFAULT 'medium';

ALTER TABLE public.tasks
    ADD COLUMN IF NOT EXISTS due_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW();

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'idx_tasks_title'
          AND n.nspname = 'public'
    ) THEN
CREATE INDEX idx_tasks_title ON public.tasks(title);
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname = 'idx_tasks_column_id'
          AND n.nspname = 'public'
    ) THEN
CREATE INDEX idx_tasks_column_id ON public.tasks(column_id);
END IF;
END
$$;
