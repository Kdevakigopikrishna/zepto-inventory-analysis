# 📦 Zepto Inventory Data Analysis (PostgreSQL)

## 📌 Project Overview  
This project focuses on analyzing the **Zepto Inventory Dataset** using **PostgreSQL**.  
The dataset was sourced from Kaggle and contains product-level information such as category, price, discounts, stock status, and weight.

The goal of this project is to perform:
- Data exploration  
- Data cleaning  
- Business-focused SQL analysis  

---

## 📊 Dataset Information  

- **Source:** Kaggle  
- **Dataset Link:**  
  https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset/data?select=zepto_v2.csv  
- **File Used:** `zepto_v2.csv`  
- **Platform:** PostgreSQL  

---

## 🛠️ Tools & Technologies  

- PostgreSQL  
- SQL  
- Kaggle  
- GitHub  

---

## 🗂️ Database Schema  

```sql
CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountpercent NUMERIC(8,2),
    availablequantity INTEGER,
    discountedsellingprice NUMERIC(8,2),
    weightin_gms INTEGER,
    outofstock BOOLEAN,
    quantity INTEGER
);
