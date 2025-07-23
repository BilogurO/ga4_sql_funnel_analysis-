DROP TABLE IF EXISTS all_data;

CREATE TEMP TABLE ALL_DATA AS --Тимчасова база вихідних даних для усіх завдань
WITH all_ads AS (
  SELECT
    t1.ad_date AS ad_date,
    'Facebook Ads' AS media_source,
    t3.campaign_name,
    t4.adset_name,    
    t1.spend,
    t1.value,
    t1.reach
  FROM facebook_ads_basic_daily AS T1
  LEFT JOIN facebook_campaign AS t3 ON t1.campaign_id = t3.campaign_id
  JOIN facebook_adset AS t4 ON t1.adset_id = t4.adset_id
    UNION ALL
  SELECT
    t2.ad_date AS ad_date,
    'Google Ads' AS media_source,
    t2.campaign_name,
    t2.adset_name,    
    t2.spend,
    t2.value,
    t2.reach
  FROM google_ads_basic_daily AS t2
)
SELECT *
FROM all_ads;

------- Завдання 1 Відобрази агрегуючі показники (середнє, максимум та мінімум) для щоденних витрат по Google та Facebook окремо

SELECT ad_date, media_source,
		round (avg(spend),2) as avg_spend,
		min(spend) as MIN_spend_day,
		max(spend) as MAX_spend_day
		FROM ALL_DATA    --Тимчасова база вихідних даних
		group by ad_date, media_source
		order by ad_date;

------- Завдання 2 Знайди топ-5 днів за рівнем ROMI загалом (включаючи Google та Facebook), виведи дати та відповідні значення в порядку спадання

 SELECT ad_date, 
 	ROUND (CASE WHEN SUM(spend) > 0 THEN SUM(value)::numeric / SUM(spend)  ELSE 0 end,2) AS ROMI
 	FROM ALL_DATA    --Тимчасова база вихідних даних
 	group BY ad_date
 	order by Romi desc
 	LIMIT 5;
 
 ------- Завдання 3 Відобрази компанію з найвищим рівнем загального тижневого value (не забудь вказати тиждень та значення рекорду)
 
  SELECT
    campaign_name,
    DATE_TRUNC('week', ad_date)::date AS week_date,
    DATE_PART('week', ad_date) AS week,
    SUM(value) AS week_value
  FROM ALL_DATA    --Тимчасова база вихідних даних
  GROUP BY
    week,  week_date, campaign_name
ORDER BY week_value DESC
LIMIT 1;

 ------- Завдання 4 Знайди кампанію, що мала найбільший приріст у охопленні місяць-до місяця

WITH monthly_reach AS (
  SELECT
    campaign_name, DATE_TRUNC('month', ad_date)::date AS month,  
    SUM(reach) AS monthly_reach
  FROM ALL_DATA    --Тимчасова база вихідних даних
  GROUP BY campaign_name, month
  ),
reach_diff AS (
  SELECT
    campaign_name, month, monthly_reach,
    monthly_reach - LAG(monthly_reach) OVER (PARTITION BY campaign_name ORDER BY month) AS reach_growth
  FROM monthly_reach)
SELECT
  campaign_name, month, reach_growth 
  FROM reach_diff
WHERE
  reach_growth IS NOT NULL AND reach_growth > 0
ORDER BY
  reach_growth DESC
LIMIT 1;

------ Завдання 4 без використання віконих функцій та LAG


WITH union_ads AS (
    SELECT
        fs.ad_date,
        fs_comp.campaign_name,
        fs.reach
    FROM
        facebook_ads_basic_daily AS fs
    LEFT JOIN
        facebook_campaign AS fs_comp ON fs."campaign_id" = fs_comp.campaign_id
    UNION ALL
    SELECT
        ad_date,
        campaign_name,
        reach AS reach
    FROM
        public.google_ads_basic_daily
),
prev_date AS (
    SELECT
        date_trunc('month', ad_date)::date AS ad_month,
        campaign_name,
        SUM(reach) AS reach_sum
    FROM
        union_ads
    GROUP BY
        ad_month, campaign_name
)
SELECT
    pd1.ad_month,
    pd1.campaign_name,
    pd1.reach_sum - pd2.reach_sum AS increase_reach
FROM
    prev_date pd1
LEFT JOIN
    prev_date pd2 ON pd1.campaign_name = pd2.campaign_name
    AND pd2.ad_month = (SELECT MAX(ad_month) FROM prev_date WHERE ad_month < pd1.ad_month AND campaign_name = pd1.campaign_name)
WHERE
    (pd1.reach_sum - pd2.reach_sum) IS NOT NULL
ORDER BY
    increase_reach DESC
LIMIT 1;

 ------- Завдання 5 Поверненя назви та тривалість найдовшого безперервного (щоденного) показу adset_name (разом з Google та Facebook).

WITH deduplicated_ads AS (
  SELECT DISTINCT adset_name, ad_date
  FROM ALL_DATA ),    --Тимчасова база вихідних даних
numbered_ads AS (
  SELECT
    adset_name, ad_date, 
    ROW_NUMBER() OVER (PARTITION BY adset_name ORDER BY ad_date) AS rn
  FROM deduplicated_ads),
grouped_ads AS (
  SELECT
    adset_name, ad_date,
    ad_date - (rn || ' days')::interval AS grp
  FROM numbered_ads),
streaks AS (
  SELECT
    adset_name,
    COUNT(*) AS streak_length
  FROM grouped_ads
  GROUP BY adset_name, grp)
SELECT adset_name, streak_length
FROM streaks
ORDER BY streak_length DESC
LIMIT 1;