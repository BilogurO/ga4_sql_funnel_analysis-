Completed Tasks in PostgreSQL (file: /sql/Final_SQL_1-5.sql)
 - Aggregated metrics (average, maximum, and minimum) for daily Google and Facebook expenses have been displayed separately.
 - The top 5 days by overall ROMI (including Google and Facebook) have been identified, with dates and corresponding values presented in descending order.
 - The company with the highest overall weekly value has been displayed (including the specific week and record value).
 - The campaign that had the largest month-over-month increase in reach has been identified.
 - A query has been written to return the name and duration of the longest continuous (daily) display of an adset_name (combining both Google and Facebook data).

Completed Tasks in BigQuery
Data Preparation for BI System Reporting. (file: /sql/BQ_Events_in_GA4)
 - A query was created to retrieve a table containing information about events, users, and sessions in GA4.
 - The table includes the following fields: event_timestamp (converted to timestamp data type), user_pseudo_id, session_id, event_name, country, ``device_category,source, medium, and campaign`.
 - Data was limited to the year 2021.
 - Data was filtered for specific events: "Session start", "Product view", "Add to cart", "Begin checkout", "Add shipping info", "Add payment info", and "Purchase".

Conversion Rate Calculation by Date and Traffic Channel. (file: /sql/BQ_Conversions_GA4)
 - A query was created to retrieve a table with conversion information from session start to purchase.
 - The table includes the following fields: event_date (derived from event_timestamp), source, medium, campaign, and user_sessions_count (unique sessions for unique users).
 - Conversion rates calculated include: visit_to_cart, visit_to_checkout, and visit_to_purchase.
 - A combination of user ID and session ID was used to identify unique sessions.
 - Results were grouped by date, source, medium, and campaign.

Conversion Comparison Across Different Landing Pages. (file: /sql/BQ_Create conversion landing pages)
 - The page path was extracted from page_location for session start events.
 - For each unique session start page path, the following metrics were calculated using 2020 data: number of unique sessions for unique users, number of purchases, and conversion rate from session start to purchase.
 - Session start and purchase events were correctly joined using user ID and session ID.
 - Results were aggregated by page path.

Checking Correlation Between User Engagement and Purchases. (file: /sql/BQ_Create Correlation_in_GA4)
 - For each unique session, the following were determined: whether the user was engaged (session_engaged), total user activity time (engagement_time_msec), and whether a purchase occurred.
 - The correlation coefficient was calculated between user engagement and purchase, as well as between total activity time and purchase.
 - A combination of user ID and session ID was used to join session events.
 - Null values in the engagement_time_msec field were handled using coalesce.
 - The session_engaged string value was converted to an integer.
