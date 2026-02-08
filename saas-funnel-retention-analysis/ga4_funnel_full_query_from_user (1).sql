-- SaaS User Funnel & Retention Analysis (BigQuery/SQL)
-- This query calculates step-by-step conversion and user retention trends

WITH daily_events AS (
  SELECT
    user_pseudo_id,
    TIMESTAMP_MICROS(event_timestamp) AS event_time,
    event_name,
    device.category AS platform,
    -- Extracting session ID to group events by visit
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id
  FROM `your-project.analytics_123456.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20230601' AND '20230701'
),

funnel_stages AS (
  SELECT
    user_pseudo_id,
    platform,
    COUNTIF(event_name = 'session_start') AS started_onboarding,
    COUNTIF(event_name = 'user_sign_up') AS signed_up,
    COUNTIF(event_name = 'main_landing_screen') AS reached_main,
    COUNTIF(event_name = 'play_song_or_video') AS completed_onboarding
  FROM daily_events
  GROUP BY 1, 2
),

conversion_metrics AS (
  SELECT
    platform,
    COUNT(DISTINCT user_pseudo_id) AS total_users,
    SUM(signed_up) / COUNT(DISTINCT user_pseudo_id) AS signup_rate,
    SUM(completed_onboarding) / SUM(signed_up) AS activation_rate
  FROM funnel_stages
  GROUP BY 1
)

-- Final Output: High-level funnel performance by platform (iOS vs Android)
SELECT 
  platform,
  total_users,
  ROUND(signup_rate * 100, 2) || '%' AS signup_pct,
  ROUND(activation_rate * 100, 2) || '%' AS activation_pct
FROM conversion_metrics
ORDER BY total_users DESC;
