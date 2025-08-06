# etl-transaksi-banking-domain
This project simulates the end-to-end ETL process and modeling of a small-scale data warehouse (data mart) for the banking domain, built using Microsoft SSIS and SQL Server. The use cases were designed to align with an environment involving regular financial data.

## 🗂️ Arsitektur Data
![Data Architecture](doc/TSD/arsitektur-data.png)


## 🧾 ETL Process Description

1. **Load Bronze**
   - Retrieve data from `transactions.xlsx` (multi-channel).
   - Saves to `bronze_transactions` table without transformation.
   - SSIS based Data flow task

2. **Transform to Silver**
   - Data validation: make sure date format, number of numbers are valid.
   - Normalize: all channels are uppercase, branch ID is uniform.
   - Output to `silver_transaction`.
   - Script-based executed using 'SSIS SQL execute task'.

3. **Load to Gold**
   - Create `dim_branch`, `dim_channel`, and `fact_transaction` via View.
   - Script-based executed using 'SSIS SQL execute task'
     
4. **Quick Report**
   - Calculates KPIs and key metrics such as number of transactions, transaction frequency,
 average transaction frequency etc.



## 📁 Project Structure
     
     ├── data_source/
     │ └── transaksi.xlsx # Sample multi-channel source data
     │
     ├── doc/
     │ ├── FSD/
     │ │ └── Draft FSD.docx # Functional Specification
     │ └── TSD/
     │ ├── TSD.pdf # Technical Spec Document
     │ └── arsitektur-data.png # Diagram alur data
     │
     ├── output/
     │ ├── dim_branch.xlsx
     │ ├── dim_channel.xlsx
     │ └── fact_transaksi.xlsx # Export-an dari Gold layer
     │
     ├── scripts/
     │ ├── init_db.sql # Setup awal database
     │ ├── ddl_bronze.sql
     │ ├── ddl_silver.sql
     │ ├── ddl_gold(views).sql
     │ ├── gold_report_transaksi.sql # Query pelaporan transaksi
     │ └── load_silver.sql # Script yang di eksekusi dengan task 'script' pada SSIS
     │
     ├── ssis-package/
     │ ├── load_bronze.dtsx # Load raw dari Excel ke Bronze
     │ ├── load_silver.dtsx # Transformasi dari Bronze ke Silver
     │ ├── load_gold.dtsx # Incremental load dari Silver ke Gold
     │ └── quick_report.dtsx # Export Gold ke Excel
     │
     ├── LICENSE
     └── README.md


## 💾 tools

- SQL Server 
- SSMS (Sql Server Management Studio)
- SSIS (SQL Server Integration Services)
- Microsoft Excel
  
## 📎 Dokumen Terkait

- [📄 FSD - Functional Spec](doc/FSD/Draft%20FSD.docx)
- [📄 TSD - Technical Spec](doc/TSD/TSD.pdf)
- [🖼️ Data Architecture](doc/TSD/arsitektur-data.png)

# 👨‍💻 Author

**Afrijal Rasya**  
_ETL Development Enthusiast | Aspiring Data Engineer_  
📧 afrijalrasyap@gmail.com

  
## 📜 Lisensi

This project is under the MIT license.
