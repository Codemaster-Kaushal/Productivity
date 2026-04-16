-- =============================================================================
-- Productivity App — Complete Supabase Schema
-- Run this ENTIRE script in the Supabase SQL Editor in one go.
-- =============================================================================

-- 1. USER PROFILES
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL,
  current_streak INTEGER NOT NULL DEFAULT 0,
  longest_streak INTEGER NOT NULL DEFAULT 0,
  last_active_date DATE,
  shield_count INTEGER NOT NULL DEFAULT 0,
  total_xp INTEGER NOT NULL DEFAULT 0,
  level TEXT NOT NULL DEFAULT 'Freshman',
  google_access_token TEXT,
  google_refresh_token TEXT,
  google_token_expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. SEMESTER GOALS
CREATE TABLE semester_goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  subject TEXT NOT NULL,
  title TEXT NOT NULL,
  semester_label TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 3. MILESTONES
CREATE TABLE milestones (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  semester_goal_id UUID NOT NULL REFERENCES semester_goals(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  is_completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at TIMESTAMPTZ
);

-- 4. GOALS
CREATE TABLE goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  subject TEXT NOT NULL,
  date DATE NOT NULL,
  is_completed BOOLEAN NOT NULL DEFAULT FALSE,
  semester_goal_id UUID REFERENCES semester_goals(id) ON DELETE SET NULL,
  focus_window_start TIME,
  focus_window_end TIME,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 5. TASKS
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  date DATE NOT NULL,
  is_completed BOOLEAN NOT NULL DEFAULT FALSE,
  linked_goal_id UUID REFERENCES goals(id) ON DELETE SET NULL,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 6. JOURNAL ENTRIES
CREATE TABLE journal_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  content TEXT NOT NULL,
  ai_prompts JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 7. POMODORO SESSIONS
CREATE TABLE pomodoro_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  linked_goal_id UUID REFERENCES goals(id) ON DELETE SET NULL,
  duration_minutes INTEGER NOT NULL DEFAULT 25,
  started_at TIMESTAMPTZ NOT NULL,
  completed_at TIMESTAMPTZ,
  idempotency_key UUID NOT NULL UNIQUE
);

-- 8. DAILY SCORES
CREATE TABLE daily_scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  true_score INTEGER NOT NULL,
  verdict TEXT NOT NULL,
  big3_points INTEGER,
  pomodoro_points INTEGER,
  task_points INTEGER,
  journal_points INTEGER,
  active_points INTEGER,
  penalty_points INTEGER,
  focus_badge_earned BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT uq_daily_scores_user_date UNIQUE (user_id, date)
);

-- 9. XP LOG
CREATE TABLE xp_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  category TEXT NOT NULL,
  xp_earned INTEGER NOT NULL,
  CONSTRAINT uq_xp_log_user_date_category UNIQUE (user_id, date, category)
);

-- 10. EXAM DAYS
CREATE TABLE exam_days (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  CONSTRAINT uq_exam_days_user_date UNIQUE (user_id, date)
);

-- 11. SYNC OPERATIONS
CREATE TABLE sync_operations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  operation_type TEXT NOT NULL,
  payload JSONB NOT NULL,
  idempotency_key UUID NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  synced_at TIMESTAMPTZ
);

-- 12. ENABLE ROW LEVEL SECURITY
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE semester_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE milestones ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE pomodoro_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE xp_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_days ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_operations ENABLE ROW LEVEL SECURITY;

-- 13. RLS POLICIES: user_profiles (id = auth.uid)
CREATE POLICY "Users can view own profile" ON user_profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON user_profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON user_profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- 14. RLS POLICIES: semester_goals
CREATE POLICY "Users can select own semester_goals" ON semester_goals FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own semester_goals" ON semester_goals FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own semester_goals" ON semester_goals FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own semester_goals" ON semester_goals FOR DELETE USING (auth.uid() = user_id);

-- 15. RLS POLICIES: goals
CREATE POLICY "Users can select own goals" ON goals FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own goals" ON goals FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own goals" ON goals FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own goals" ON goals FOR DELETE USING (auth.uid() = user_id);

-- 16. RLS POLICIES: tasks
CREATE POLICY "Users can select own tasks" ON tasks FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own tasks" ON tasks FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own tasks" ON tasks FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own tasks" ON tasks FOR DELETE USING (auth.uid() = user_id);

-- 17. RLS POLICIES: journal_entries
CREATE POLICY "Users can select own journal_entries" ON journal_entries FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own journal_entries" ON journal_entries FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own journal_entries" ON journal_entries FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own journal_entries" ON journal_entries FOR DELETE USING (auth.uid() = user_id);

-- 18. RLS POLICIES: pomodoro_sessions
CREATE POLICY "Users can select own pomodoro_sessions" ON pomodoro_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own pomodoro_sessions" ON pomodoro_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own pomodoro_sessions" ON pomodoro_sessions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own pomodoro_sessions" ON pomodoro_sessions FOR DELETE USING (auth.uid() = user_id);

-- 19. RLS POLICIES: daily_scores
CREATE POLICY "Users can select own daily_scores" ON daily_scores FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own daily_scores" ON daily_scores FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own daily_scores" ON daily_scores FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own daily_scores" ON daily_scores FOR DELETE USING (auth.uid() = user_id);

-- 20. RLS POLICIES: xp_log
CREATE POLICY "Users can select own xp_log" ON xp_log FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own xp_log" ON xp_log FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own xp_log" ON xp_log FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own xp_log" ON xp_log FOR DELETE USING (auth.uid() = user_id);

-- 21. RLS POLICIES: exam_days
CREATE POLICY "Users can select own exam_days" ON exam_days FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own exam_days" ON exam_days FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own exam_days" ON exam_days FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own exam_days" ON exam_days FOR DELETE USING (auth.uid() = user_id);

-- 22. RLS POLICIES: sync_operations
CREATE POLICY "Users can select own sync_operations" ON sync_operations FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own sync_operations" ON sync_operations FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own sync_operations" ON sync_operations FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own sync_operations" ON sync_operations FOR DELETE USING (auth.uid() = user_id);

-- 23. RLS POLICIES: milestones (via semester_goal ownership)
CREATE POLICY "Users can select own milestones" ON milestones FOR SELECT
  USING (EXISTS (SELECT 1 FROM semester_goals sg WHERE sg.id = semester_goal_id AND sg.user_id = auth.uid()));
CREATE POLICY "Users can insert own milestones" ON milestones FOR INSERT
  WITH CHECK (EXISTS (SELECT 1 FROM semester_goals sg WHERE sg.id = semester_goal_id AND sg.user_id = auth.uid()));
CREATE POLICY "Users can update own milestones" ON milestones FOR UPDATE
  USING (EXISTS (SELECT 1 FROM semester_goals sg WHERE sg.id = semester_goal_id AND sg.user_id = auth.uid()));
CREATE POLICY "Users can delete own milestones" ON milestones FOR DELETE
  USING (EXISTS (SELECT 1 FROM semester_goals sg WHERE sg.id = semester_goal_id AND sg.user_id = auth.uid()));

-- 24. AUTO-CREATE PROFILE ON SIGNUP
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, display_name)
  VALUES (NEW.id, COALESCE(NEW.raw_user_meta_data->>'display_name', NEW.email));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- DONE: 11 tables, RLS enabled, policies set, auto-profile trigger active.
