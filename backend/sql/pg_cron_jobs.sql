-- =============================================================================
-- pg_cron Scheduled Jobs for Productivity App
-- Run these in the Supabase SQL Editor to register the cron jobs.
-- =============================================================================

-- 1. Run True Score calculation for all users at midnight UTC
SELECT cron.schedule(
  'calculate-daily-scores',
  '0 0 * * *',
  $$
  SELECT net.http_post(
    url := 'https://your-project.supabase.co/functions/v1/calculate-scores',
    headers := '{"Authorization": "Bearer YOUR_SERVICE_KEY"}'::jsonb
  )
  $$
);

-- 2. Run Sunday Debrief Agent every Sunday at 7pm UTC
SELECT cron.schedule(
  'sunday-debrief',
  '0 19 * * 0',
  $$
  SELECT net.http_post(
    url := 'https://your-project.supabase.co/functions/v1/sunday-debrief',
    headers := '{"Authorization": "Bearer YOUR_SERVICE_KEY"}'::jsonb
  )
  $$
);

-- ────────────────────────────────────────────────────────────────────────
-- To view registered jobs:
--   SELECT * FROM cron.job;
--
-- To unschedule a job:
--   SELECT cron.unschedule('calculate-daily-scores');
--   SELECT cron.unschedule('sunday-debrief');
-- ────────────────────────────────────────────────────────────────────────
