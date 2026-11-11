import requests
import pandas as pd

app_id = "YOUR_APP_ID"
app_key = "YOUR_APP_KEY"

jobs = []

cities = [
    "Mumbai",
    "Pune",
    "Bangalore",
    "Noida",
    "Gurgaon"
]

roles = [
    "Data Analyst",
    "Business Analyst",
    "Data Scientist",
    "Power BI Developer"
]

for city in cities:
    for role in roles:
        for page in range(1, 7):

            print(f"Fetching {city} | {role} | Page {page}")

            url = f"https://api.adzuna.com/v1/api/jobs/in/search/{page}?app_id={app_id}&app_key={app_key}&results_per_page=50&what={role}&where={city}"

            response = requests.get(url)

            data = response.json()

            for job in data["results"]:
                jobs.append({
                    "Title": job.get("title"),
                    "Company": job.get("company", {}).get("display_name"),
                    "Location": job.get("location", {}).get("display_name"),
                    "Salary_Min": job.get("salary_min"),
                    "Salary_Max": job.get("salary_max"),
                    "Contract_Type": job.get("contract_type"),
                    "Contract_Time": job.get("contract_time"),
                    "Category": job.get("category", {}).get("label"),
                    "City_Searched": city,
                    "Role_Searched": role
                })

df = pd.DataFrame(jobs)

print(df.head())

print("Total Jobs Collected:", len(df))

df.to_csv("jobs_new.csv", index=False)

print("CSV Saved Successfully!")

print(df.head())

print("Total Jobs:", len(df))