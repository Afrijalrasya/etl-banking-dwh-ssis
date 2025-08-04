/*
===============================================================================
Load Silver Layer (Bronze -> Silver)
===============================================================================
Tujuan Script:
 Script ini melakukan proses ETL (Extract, Transform, Load) untuk 
 mengisi tabel transaksi pada schema 'Silver' dari schema 'Bronze'.
	Tindakan yang dilakukan:
		- Memuat data yang ditransformasikan dan dibersihkan dari tabel bronze.transaksi
		  ke dalam tabel Silver.transaksi .

Penggunaan:
    jalankan package 'load-silver' pada SSIS untuk mengeksekusi task yang berisi script ini.
===============================================================================
*/
insert into silver.transaksi(
id_transaksi,
nomor_akun,
tanggal_transaksi,
jumlah,
channel,
branch_code
)
select
id_transaksi,
nomor_akun,
tanggal_transaksi,
jumlah,
channel,
branch_code
from( 
select 
transaction_id as id_transaksi,
case when LEN(account_no) = 6 THEN account_no
	 else substring (account_no, 1, 6)
	 end as nomor_akun,
FORMAT(CAST(tgl_transaksi AS DATE), 'yyyy-MM-dd') as tanggal_transaksi,
round(amount, 2) as jumlah,
TRIM(UPPER(channel))as channel,
row_number() over (partition by transaction_id order by tgl_transaksi) as flag_last,
branch_code
from bronze.transaksi
where transaction_id IS NOT NULL
)t
where flag_last = 1


