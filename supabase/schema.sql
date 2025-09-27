-- Velocity Review Platform Database Schema
-- Execute this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable RLS
ALTER DATABASE postgres SET row_security = on;

-- =====================================================
-- PROJECTS TABLE
-- =====================================================
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    description TEXT,
    admin_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'active', 'completed', 'archived')),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    total_duration FLOAT DEFAULT 0,
    clip_count INTEGER DEFAULT 0,
    folder_structure JSONB DEFAULT '{}'::jsonb,
    client_access_enabled BOOLEAN DEFAULT false,
    naming_pattern TEXT DEFAULT 'NFOL_XXX_GEN_vXXX'
);

-- Projects indexes
CREATE INDEX idx_projects_admin_id ON projects(admin_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_created_at ON projects(created_at DESC);

-- Projects RLS policies
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY projects_admin_access ON projects 
FOR ALL USING (auth.uid() = admin_id);

-- =====================================================
-- CLIPS TABLE
-- =====================================================
CREATE TABLE clips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    sequence_order INTEGER NOT NULL,
    title TEXT NOT NULL,
    main_video_path TEXT NOT NULL,
    duration FLOAT NOT NULL,
    thumbnail_path TEXT,
    thumbnail_sprite_path TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    file_size BIGINT,
    video_metadata JSONB DEFAULT '{}'::jsonb,
    codec_info JSONB DEFAULT '{}'::jsonb,
    UNIQUE(project_id, sequence_order)
);

-- Clips indexes
CREATE INDEX idx_clips_project_sequence ON clips(project_id, sequence_order);
CREATE INDEX idx_clips_project_id ON clips(project_id);

-- Clips RLS policies
ALTER TABLE clips ENABLE ROW LEVEL SECURITY;

CREATE POLICY clips_admin_access ON clips 
FOR ALL USING (
    project_id IN (
        SELECT id FROM projects WHERE admin_id = auth.uid()
    )
);

-- =====================================================
-- VARIATIONS TABLE
-- =====================================================
CREATE TABLE variations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clip_id UUID REFERENCES clips(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    video_path TEXT NOT NULL,
    duration FLOAT NOT NULL,
    thumbnail_path TEXT,
    file_size BIGINT,
    variation_order INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT NOW(),
    is_selected BOOLEAN DEFAULT false,
    codec_info JSONB DEFAULT '{}'::jsonb
);

-- Variations indexes
CREATE INDEX idx_variations_clip_id ON variations(clip_id);
CREATE INDEX idx_variations_selected ON variations(clip_id, is_selected);

-- Variations RLS policies
ALTER TABLE variations ENABLE ROW LEVEL SECURITY;

CREATE POLICY variations_admin_access ON variations 
FOR ALL USING (
    clip_id IN (
        SELECT c.id FROM clips c 
        JOIN projects p ON c.project_id = p.id 
        WHERE p.admin_id = auth.uid()
    )
);

-- =====================================================
-- CLIENT_INVITES TABLE
-- =====================================================
CREATE TABLE client_invites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    client_email TEXT NOT NULL,
    magic_token UUID DEFAULT gen_random_uuid(),
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'expired')),
    invited_by UUID REFERENCES auth.users(id),
    invited_at TIMESTAMP DEFAULT NOW(),
    expires_at TIMESTAMP DEFAULT (NOW() + INTERVAL '7 days'),
    access_permissions JSONB DEFAULT '{"can_comment": true, "can_select_variations": true}'::jsonb
);

-- Client invites indexes
CREATE UNIQUE INDEX idx_invites_token ON client_invites(magic_token);
CREATE INDEX idx_invites_email ON client_invites(client_email);
CREATE INDEX idx_invites_project ON client_invites(project_id);

-- Client invites RLS policies
ALTER TABLE client_invites ENABLE ROW LEVEL SECURITY;

CREATE POLICY client_invites_admin_access ON client_invites 
FOR ALL USING (invited_by = auth.uid());

-- =====================================================
-- REVIEW_SESSIONS TABLE
-- =====================================================
CREATE TABLE review_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    client_id UUID REFERENCES auth.users(id),
    selected_variations JSONB DEFAULT '{}'::jsonb,
    playback_position FLOAT DEFAULT 0,
    last_active TIMESTAMP DEFAULT NOW(),
    session_notes TEXT,
    is_finalized BOOLEAN DEFAULT false,
    review_completion_percentage FLOAT DEFAULT 0,
    session_duration INTEGER DEFAULT 0,
    interaction_count INTEGER DEFAULT 0
);

-- Review sessions indexes
CREATE INDEX idx_review_sessions_project ON review_sessions(project_id);
CREATE INDEX idx_review_sessions_client ON review_sessions(client_id);
CREATE INDEX idx_review_sessions_active ON review_sessions(last_active DESC);

-- Review sessions RLS policies
ALTER TABLE review_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY review_sessions_access ON review_sessions 
FOR ALL USING (
    client_id = auth.uid() OR 
    project_id IN (
        SELECT id FROM projects WHERE admin_id = auth.uid()
    )
);

-- =====================================================
-- ANALYTICS_EVENTS TABLE
-- =====================================================
CREATE TABLE analytics_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type TEXT NOT NULL,
    project_id UUID REFERENCES projects(id),
    user_id UUID REFERENCES auth.users(id),
    metadata JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Analytics events indexes
CREATE INDEX idx_analytics_events_type ON analytics_events(event_type);
CREATE INDEX idx_analytics_events_project ON analytics_events(project_id);
CREATE INDEX idx_analytics_events_created ON analytics_events(created_at DESC);

-- Analytics RLS policies
ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;

CREATE POLICY analytics_events_access ON analytics_events 
FOR ALL USING (
    user_id = auth.uid() OR 
    project_id IN (
        SELECT id FROM projects WHERE admin_id = auth.uid()
    )
);

-- =====================================================
-- CLIENT ACCESS POLICY FOR PROJECTS
-- =====================================================
CREATE POLICY projects_client_read ON projects 
FOR SELECT USING (
    id IN (
        SELECT project_id FROM client_invites 
        WHERE client_email = auth.jwt()->>'email' 
        AND status = 'accepted'
        AND expires_at > NOW()
    )
);

-- =====================================================
-- CLIENT ACCESS POLICIES FOR CLIPS AND VARIATIONS
-- =====================================================
CREATE POLICY clips_client_read ON clips 
FOR SELECT USING (
    project_id IN (
        SELECT ci.project_id FROM client_invites ci
        WHERE ci.client_email = auth.jwt()->>'email' 
        AND ci.status = 'accepted'
        AND ci.expires_at > NOW()
    )
);

CREATE POLICY variations_client_read ON variations 
FOR SELECT USING (
    clip_id IN (
        SELECT c.id FROM clips c 
        JOIN client_invites ci ON c.project_id = ci.project_id
        WHERE ci.client_email = auth.jwt()->>'email' 
        AND ci.status = 'accepted'
        AND ci.expires_at > NOW()
    )
);

-- =====================================================
-- UPDATED_AT TRIGGER FUNCTION
-- =====================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger to projects table
CREATE TRIGGER update_projects_updated_at 
    BEFORE UPDATE ON projects 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- STORAGE BUCKETS
-- =====================================================
-- Create storage buckets
INSERT INTO storage.buckets (id, name, public) VALUES 
('project-videos', 'project-videos', false),
('video-thumbnails', 'video-thumbnails', true);

-- Storage policies for project-videos bucket
CREATE POLICY "Admin can upload videos" ON storage.objects
FOR INSERT WITH CHECK (
    bucket_id = 'project-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Admin can view own videos" ON storage.objects
FOR SELECT USING (
    bucket_id = 'project-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Admin can delete own videos" ON storage.objects
FOR DELETE USING (
    bucket_id = 'project-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
);

-- Storage policies for video-thumbnails bucket (public read)
CREATE POLICY "Public can view thumbnails" ON storage.objects
FOR SELECT USING (bucket_id = 'video-thumbnails');

CREATE POLICY "Admin can upload thumbnails" ON storage.objects
FOR INSERT WITH CHECK (
    bucket_id = 'video-thumbnails' AND
    auth.uid()::text = (storage.foldername(name))[1]
);

-- =====================================================
-- UTILITY FUNCTIONS
-- =====================================================

-- Function to get project with clips and variations
CREATE OR REPLACE FUNCTION get_project_full_data(project_uuid UUID)
RETURNS JSON AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_build_object(
        'project', to_json(p.*),
        'clips', (
            SELECT json_agg(
                json_build_object(
                    'clip', to_json(c.*),
                    'variations', (
                        SELECT json_agg(to_json(v.*))
                        FROM variations v
                        WHERE v.clip_id = c.id
                        ORDER BY v.variation_order
                    )
                )
            )
            FROM clips c
            WHERE c.project_id = p.id
            ORDER BY c.sequence_order
        )
    ) INTO result
    FROM projects p
    WHERE p.id = project_uuid;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to update project statistics
CREATE OR REPLACE FUNCTION update_project_stats(project_uuid UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE projects 
    SET 
        clip_count = (
            SELECT COUNT(*) 
            FROM clips 
            WHERE project_id = project_uuid
        ),
        total_duration = (
            SELECT COALESCE(SUM(duration), 0) 
            FROM clips 
            WHERE project_id = project_uuid
        ),
        updated_at = NOW()
    WHERE id = project_uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to auto-update project stats when clips change
CREATE OR REPLACE FUNCTION trigger_update_project_stats()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        PERFORM update_project_stats(NEW.project_id);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        PERFORM update_project_stats(OLD.project_id);
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER clips_update_project_stats
    AFTER INSERT OR UPDATE OR DELETE ON clips
    FOR EACH ROW EXECUTE FUNCTION trigger_update_project_stats();

-- =====================================================
-- REALTIME SETUP
-- =====================================================
-- Enable realtime for collaboration
ALTER PUBLICATION supabase_realtime ADD TABLE projects;
ALTER PUBLICATION supabase_realtime ADD TABLE clips;
ALTER PUBLICATION supabase_realtime ADD TABLE variations;
ALTER PUBLICATION supabase_realtime ADD TABLE review_sessions;

COMMENT ON TABLE projects IS 'Main projects table with admin ownership and client access control';
COMMENT ON TABLE clips IS 'Video clips within projects, ordered sequentially';
COMMENT ON TABLE variations IS 'Alternative versions of clips for client selection';
COMMENT ON TABLE client_invites IS 'Magic link invitations for client access';
COMMENT ON TABLE review_sessions IS 'Client review sessions with selection tracking';
COMMENT ON TABLE analytics_events IS 'User interaction and performance analytics';
