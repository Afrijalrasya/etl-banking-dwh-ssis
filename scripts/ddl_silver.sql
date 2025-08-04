/*
DDL Script: membuat table silver
====================================================================================================
Tujuan Script:
 Script ini membuat tabel transaksi dalam schema 'silver', menghapus tabel jika sudah ada.
	Jalankan skrip ini untuk mendefinisikan ulang struktur DDL Tabel transaksi pada schema'silver'
====================================================================================================
*/

IF OBJECT_ID ('silver.transaksi', 'U') IS NOT NULL
	DROP TABLE silver.transaksi;
GO
CREATE TABLE silver.transaksi (
    id_transaksi VARCHAR(20),
    nomor_akun VARCHAR(20),
    tanggal_transaksi DATE,
    jumlah DECIMAL(18,2),
    channel VARCHAR(20),
    branch_code VARCHAR(10),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

