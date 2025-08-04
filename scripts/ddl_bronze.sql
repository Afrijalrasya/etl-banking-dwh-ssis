/*
DDL Script: membuat table bronze
===============================================================================
Tujuan script:
 Script ini membuat table transaksi pada schema 'bronze' sebagai tempat staging.
Script ini akan menghapus table jika table nya sudah ada.
	Gunakan script ini untuk mendefinisikan ulang struktur DDL dari table
	transaksi pada schema 'bronze'
===============================================================================
*/

IF OBJECT_ID ('bronze.transaksi', 'U') IS NOT NULL
	DROP TABLE bronze.transaksi;
GO
CREATE TABLE bronze.transaksi (
    transaction_id VARCHAR(20),
    account_no VARCHAR(20),
    tgl_transaksi DATE,
    amount DECIMAL(18,2),
    channel VARCHAR(20),
    branch_code VARCHAR(10)
);

