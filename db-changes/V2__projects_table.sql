CREATE TABLE projects (
                          project_id UUID PRIMARY KEY,
                          public_project_id UUID UNIQUE,
                          name VARCHAR(100) NOT NULL,
                          description TEXT,
                          color VARCHAR(20),
                          status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'archived')),
                          owner_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
                          created_at TIMESTAMP DEFAULT NOW(),
                          updated_at TIMESTAMP DEFAULT NOW(),
                          archived_at TIMESTAMP
);
