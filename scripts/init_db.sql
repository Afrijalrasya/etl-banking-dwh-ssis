/*
=============================================================
Membuat database dan schema
=============================================================
Tujuan Script:
 Script ini membuat sebuah database baru bernama 'transaksi_dwh' setelah mengecek apakah database tersebut sudah ada. 
    Jika database sudah ada, maka database tersebut akan dihapus dan dibuat ulang. Selain itu, Script ini membuat tiga skema 
 di dalam database: 'Bronze', 'Silver', dan 'Gold'.
	
PERINGATAN:
 Menjalankan Script ini akan menghapus seluruh database 'transaksi_dwh' jika ada. 
    Semua data di dalam database akan terhapus secara permanen. Lanjutkan dengan hati-hati 
 dan pastikan Anda memiliki backup yang tepat sebelum menjalankan Script ini.
*/

USE master;
GO

-- Hapus dan buat ulang 'transaksi_dwh' 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'transaksi_dwh')
BEGIN
    ALTER DATABASE transaksi_dwh SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE transaksi_dwh;
END;
GO

-- Membuat Database 'transaksi_dwh' 
CREATE DATABASE transaksi_dwh;
GO
USE transaksi_dwh;
GO

-- Membuat Schema
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

