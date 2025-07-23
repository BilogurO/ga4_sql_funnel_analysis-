# 🎯 GA4 Funnel & ROMI Analysis (SQL Final Project)

This project demonstrates how to extract, process, and analyze GA4 event data using SQL to evaluate the performance of an e-commerce conversion funnel and marketing campaigns.

---

## 🧰 Tools & Technologies

- **Google BigQuery** – for querying GA4 data
- **PostgreSQL** – for local prototyping and testing
- **Google Analytics 4 (GA4)** – source of raw event data

---

## 📌 Business Goal

To analyze user behavior throughout the e-commerce funnel (visit → cart → checkout → purchase), evaluate campaign performance, and identify bottlenecks or drop-off points.

---

## 📈 Project Workflow

1. **Raw Data Extraction** from GA4 BigQuery Export
2. **Data Structuring** into session-level and user-level tables
3. **Funnel Building**: Tracking step-by-step conversion
4. **Metric Calculation**: ROMI, CR, sessions, CAC, revenue
5. **Visualization** using Looker Studio

---

## 🔎 Key Metrics

- **ROMI** (Return on Marketing Investment)
- **Conversion Rate** at each step
- **Number of Sessions**
- **Average Revenue per Session**

---

## 🧮 SQL Queries

All queries are in the [`/sql`](./sql) folder:

- `01_base_data.sql` – extract sessions and events  
- `02_funnel_steps.sql` – structure funnel steps  
- `03_metrics_calculation.sql` – ROMI, CR, CAC, etc.  
- `04_dashboard_final_query.sql` – output table for visualization  

---

## 🗣 Video Explanation

🎥 [Watch video explanation]([https://your-video-link.com](https://youtu.be/uaeLtc-wogI)) (3 min)

---

## 📄 Presentation PDF

Download the full project summary:  
📥 [(https://docs.google.com/presentation/d/1zZgcbFDvuNvtH1eIy_NJtZfz7wJiTg8g/edit?usp=sharing&ouid=114131734883581192753&rtpof=true&sd=true))

---

## ✅ What I Learned

- How to work with GA4 event data structure in BigQuery  
- How to calculate meaningful product and marketing metrics  
- How to create a data pipeline for visualization in BI tools  
- How to derive insights from large datasets using SQL

---

## 📬 Contact

Feel free to connect or ask questions:  
📧 biloguroleksij@gmail.com | [LinkedIn]([https://linkedin.com/in/your-profile](https://www.linkedin.com/in/%D0%BE%D0%BB%D0%B5%D0%BA%D1%81%D1%96%D0%B9-%D0%B1%D1%96%D0%BB%D0%BE%D0%B3%D1%83%D1%80-476a73364/))
