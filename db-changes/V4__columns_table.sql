
CREATE TABLE IF NOT EXISTS public.columns (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    position INTEGER NOT NULL DEFAULT 0,
    board_id INTEGER NOT NULL REFERENCES public.boards(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT unique_board_column_position UNIQUE (board_id, position)
);


CREATE INDEX IF NOT EXISTS idx_columns_name ON public.columns(name);
CREATE INDEX IF NOT EXISTS idx_columns_board_id ON public.columns(board_id);


CREATE OR REPLACE FUNCTION public.update_columns_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_columns_updated_at ON public.columns;
CREATE TRIGGER trg_columns_updated_at
    BEFORE UPDATE ON public.columns
    FOR EACH ROW
    EXECUTE FUNCTION public.update_columns_updated_at();
