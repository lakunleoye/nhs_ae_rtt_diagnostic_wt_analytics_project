# Introduction
Timely access to healthcare is a core principle of the NHS, with national standards in place to monitor patient pathways. This project focuses on analysing healthcare performance across NHS England, particularly in Referral to Treatment (RTT), Accident & Emergency (A&E), and Diagnostic Wait Times over the past 3 to 6 months.
Given increased pressures on NHS services post-pandemic, there is a growing need for transparent, data-driven insights to support clinical and operational decision-making. This analysis will assess how NHS England healthcare providers perform against national KPIs, identify data quality concerns, and forecast future trends in service demand and compliance.

 # Objectives
 - Analyse 3 months of  A&E and Diagnostic Waiting Times data and 6 months of RTT data for NHS England service providers.
 - Measure trust-level compliance with national standards (e.g., RTT 52+ weeks breaches, A&E 4-hour target, and Diagnostic waiting times 6+ weeks breaches).
- Identify and report on missing, inconsistent, or duplicated records affecting data reliability.
- Create intuitive dashboards and executive summaries to inform clinical boards and stakeholders.

# Key Business Questions
- Which organisations have the highest number of A&E attendances breaching the 4-hour target, and how has this changed over the past 3 months?
- Which treatment functions and trusts are contributing most to the rise in 52+ week RTT breaches over the last 6 months?
- Which diagnostic tests and organisations have the highest and fastest-growing 6+ week breaches?

# Technical Details
- **Excel(Power Query):** Initial preparation, cleaning, and exploration
- **PostgreSQL(PGadmin) & Dbeaver:** Database creation, SQL querying, aggregating and editing
- **Power BI:** interactive dashboards & visualisation
- **VS Code:** Git integration
- **Git & Github:** Version control

# Report File
- The Power BI report file is available here [nhs_ae_rtt_diag](/powerbi/nhs_ae_rtt_diag.pbix)

# Analysis
## Business Question 1:
**Which organisations have the highest number of A&E attendances breaching the 4-hour target, and how has this changed over the past 3 months?**

Query: [ae_4hrs_breaches_analysis](/Scripts/1_ae_4hrs_breaches_analysis.sql)

* A&E performance is a critical NHS indicator. The 4-hour standard requires patients to be admitted, transferred, or discharged within 4 hours of arrival. This analysis identifies:
(1) Trusts with the highest breach volumes and (2)Trends over 3 months (improving or worsening)

![ae_4hours_breach_analysis](/images/ae_4hours_breach_analysis.png)


# Insight
**Widespread Improvement Across Regions**
- All listed NHS Trusts saw reductions in 4-hour breaches, indicating system-wide improvements in emergency department performance.
- Most reductions are in the range of 6% to 14%, which is significant in operational terms.

**Top 5 Performing Trusts by Percentage Drop:**
- *Liverpool University Hospitals NHS Foundation Trust (% change: -14%)*
- *University Hospitals of North Midlands NHS Trust (% change: -14%)*
- *Bedfordshire Hospitals NHS Foundation Trust (% change: -13%)*
- *Mersey and West Lanchashire Teaching Hospitals NHS Trust (% change: -13%),*
- *York and Scarborough Teaching Hospitals NHS Foundation Trust (% change -13%).* 
###
These trusts achieved double-digit percentage reductions, which likely reflect operational improvements like:
- Streamlined patient flow
- Better triage or discharge processes
- Increased staff or bed capacity
- Fewer admissions due to milder flu/COVID activity

## Strategic Implications:
- These reductions likely reflect active operational strategies to tackle A&E pressures (e.g., winter pressures plans, improved discharge pathways).
- However, the data should be monitored further to confirm this is part of a sustained trend, not a short-term anomaly.

## Business Question 2:
**Which treatment functions and trusts are contributing most to the rise in 52+ week RTT breaches over the last 6 months?**

Query: [rrt_52plus_weeks-breaches_analysis](/Scripts/2_rtt_52plus_weeks_breaches_analysis.sql)

- NHS leaders need to identify where the longest patient waits are occurring to support recovery planning. This analysis highlights the organisations and clinical specialties (treatment functions) with the most serious long-wait issues, focusing on 52+ week breaches — a key national KPI.

- This dataset highlights the most severe long-wait backlogs (patients waiting over 52 weeks) across various NHS trusts and treatment functions.

![rtt_52plus_weeks_breach_analysis](/images/rtt_52plus_weeks_breach_analysis.png)

# Insights

**Severe Long-Wait Backlogs Remain in Key Services**
- All listed trusts have over 7,000 patients waiting more than 52 weeks.
- The services most impacted are:
    - Ear, Nose, and Throat (ENT)
    - Trauma and Orthopaedics
    - Gynaecology
    - Oral Surgery
    - Neurology
    - Paediatrics

These are largely planned care/surgical services, which have historically struggled to recover from pandemic-era delays.

**Top 3 Worst-Affected Trusts by Total Breaches (52+ Weeks):**
- *Mid and South Essex NHS Foundation Trust (Treatment: Ear, Nose, and Throat; Total Breaches: 12,197)*
- *Manchester University NHS Foundation trust (Treatment: Gynaecology; Total Breaches: 10,204)*
- *Mid and South Essex NHS Foundation Trust (Treatment: Trauma and Orthopaedics; Total Breaches: 9,727)*
###
These are alarmingly high figures, indicating systemic delays for thousands of patients in just two NHS trusts.

**Manchester University NHS FT Appears 3 Times in the List**
- This trust has high 52-week breaches across:
    - Gynaecology (10,204)
    - Oral Surgery (8,995)
    - Paediatrics (7,173)
- Suggests widespread strain across specialties, not an isolated backlog.

## Strategic Implications:
- These 52+ week wait figures show a serious backlog in elective/planned care, despite improvements in emergency and 4-hour breach performance (seen in the previous dataset).
- There may be a trade-off occurring where resources are diverted to urgent care, causing elective procedures to suffer.

## Business Question 3:
**Which diagnostic tests and organisations have the highest and fastest-growing 6+ week breaches?**

Query: [diagnostics_6pus_weeks_breaches_analysis](/Scripts/3_diagnostics_6plus_weeks_breaches_analysis.sql)

- NHS diagnostic performance is measured by the percentage of patients waiting 6+ weeks for a test. Identifying where delays are concentrated — and growing — helps prioritise which trusts and modalities (e.g., MRI, CT, colonoscopy) need additional capacity or escalation support.

![diagnostic_tests_6plus_weeks_breaches_analysis](/images/diagnostic_tests_6plus_weeks_breach_analysis.png)

- The data shows a significant month-over-month spike in diagnostic test breaches (waits of 6+ weeks) for various NHS trusts across regions from January through March 2025. Here's a breakdown of key insights:

**Extreme Surge in Breaches:**
- The top-ranked trusts are experiencing massive increases in 6+ week breaches.
- Warrington and Halton NHS Trust saw the most dramatic increase in Non-obstetric Ultrasound, with breaches jumping from 2 to 284 — a 14,100% increase.

**Systemic Across Regions and Tests:**
- The issue is not isolated to one region or test.
- Affected regions include: North West, Midlands, South East, North East.
- Affected diagnostics include:
    - Non-obsteric Ultrasound
    - Cardiology
    - Audiology
    - Neurophysiology
    - Gastroscopy
   
## Strategic Implications:
- These changes suggest a sharp decline in diagnostic service capacity, possibly due to:
   - Operational bottlenecks (e.g., staff shortages, equipment outages)
    - Surge in demand (e.g., post-holiday season backlog)
    - Systemic delays or disruptions in service delivery

- The issue may require urgent attention from NHS management and regional health authorities to:
    - Investigate root causes
    - Reallocate resources
    - Communicate with affected patient groups

- Notable outliers like Warrington and Halton NHS Trust (Breach % change: 14100 %) and Walsall Healthcare NHS Trust (Breach % change: 8800 %) indicate potential crisis points that could trigger care delays or patient safety risks if unaddressed.

# Combined Insights from Diagnostic Delays • A&E 4-Hour Breach Reductions • 52+ Week Waits

## Elective & Diagnostic Services Are Under Severe Strain

- Massive spikes in 6+ week breaches for diagnostics in January 2025:
    - 14,100% increase in Non-Obstetric Ultrasound (Warrington)
    - Many trusts across North West, Midlands, South East reported 1000–8000% increases
- Long-wait (52+ weeks) backlogs remain staggering:
    - Mid and South Essex NHS FT (Ear, Nose and Throat (ENT)): 12,197 patient
    - Manchester University NHS FT (Gynaecology): 10,204
    - ENT, Orthopaedics, Gynaecology, and Paediatrics dominate long-wait categories
    - These are complex surgical specialties that were hard-hit post-COVID and still haven’t recovered

**Conclusion:** Elective and diagnostic services have accumulating pressure, leading to unsustainable delays in planned care.

## Emergency Care is Improving Significantly
- February 2025 data shows substantial reductions in A&E 4-hour breaches:
    - Up to -14% month-over-month reduction

## Trade-Off Emerging: Emergency Gains vs Elective Setbacks
- While emergency care improves, elective and diagnostic services suffer:
    - Diagnostic backlog is spiking while A&E pressure eases
    - Long waits (>52 weeks) are flat or worsening in surgical services
    - Indicates possible reallocation of capacity from electives to emergency

# Strategic Recommendations:
1.	Target Elective Recovery Funds:
    - Prioritize ENT, Gynaecology, Orthopaedics in North West and East of England
    - Consider pop-up elective surgical hubs or weekend clinics
2.	Balance Emergency vs Elective Capacity:
    - Ensure urgent care improvements are not sustained at the long-term expense of chronic surgical waiters
3.	Audit Diagnostics Rapidly:
    - Investigate cause of >1000% breach increases (equipment, staff, scheduling backlogs)
    - Reinforce reporting and escalation protocols

