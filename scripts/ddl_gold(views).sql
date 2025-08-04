/*
===============================================================================
DDL Script: Membuat Views Gold
===============================================================================
Tujuan Skrip:
 Skrip ini membuat View untuk layer Gold di data warehouse. 
    gold lauer mewakili dimensi dan tabel fakta (Star Schema)

    Setiap View melakukan transformasi dan menggabungkan data dari Silver Layer
 untuk menghasilkan data yang bersih, dan siap untuk bisnis.

Penggunaan:
    - View ini dapat digunakan secara langsung untuk analisis dan pelaporan.
===============================================================================
*/
--Membuat dim_channel=================================================
IF OBJECT_ID('gold.dim_channel', 'V') IS NOT NULL
DROP VIEW gold.dim_channel;
GO
CREATE VIEW gold.dim_channel AS
SELECT
	ROW_NUMBER() OVER(ORDER BY nama_channel) as id_channel, --surrogate key
	nama_channel
FROM(
SELECT DISTINCT
	channel as nama_channel
FROM silver.transaksi
)t
GO
--create dim_branch====================================================
IF OBJECT_ID('gold.dim_branch', 'V') IS NOT NULL
DROP VIEW gold.dim_branch;
GO
CREATE VIEW gold.dim_branch AS
SELECT
	ROW_NUMBER() OVER (order by branch_code) as id_branch, --surrogate key untuk dim_branch
	branch_code as kode_branch
FROM(
SELECT DISTINCT
	branch_code
FROM silver.transaksi
)t
GO
--create fact_sales============================================================================
IF OBJECT_ID('gold.fact_transaksi', 'V') IS NOT NULL
DROP VIEW gold.fact_transaksi;
GO
CREATE VIEW gold.fact_transaksi AS
select
t.id_transaksi,
t.nomor_akun,
t.tanggal_transaksi,
CAST(t.jumlah AS bigint)as jumlah,
c.id_channel,
b.id_branch
from silver.transaksi t
LEFT JOIN gold.dim_branch b
on b.kode_branch = t.branch_code
LEFT JOIN gold.dim_channel c
on c.nama_channel = t.channel

