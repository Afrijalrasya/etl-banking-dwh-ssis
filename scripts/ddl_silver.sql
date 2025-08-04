use transaksi_dwh
/*
DDL Script: membuat table silver
===============================================================================
Script Purpose:

===============================================================================
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
    branch_code VARCHAR(10)
);
