--create laporan_transaksi=====================================================================
IF OBJECT_ID('gold.laporan_transaksi', 'V') IS NOT NULL
DROP VIEW gold.laporan_transaksi;
GO
-- =============================================================================
-- Create laporan: gold.laporan_transaksi
-- =============================================================================
CREATE VIEW gold.laporan_transaksi AS

WITH base_query AS(
/*---------------------------------------------------------------------------
1) Base Query: Mengambil kolom inti dari fact_transaksi,dim_channel, dim_branch
---------------------------------------------------------------------------*/
select
t.id_transaksi,
t.nomor_akun,
t.tanggal_transaksi,
CAST(t.jumlah AS bigint)as jumlah,
c.id_channel,
c.nama_channel,
b.id_branch,
b.kode_branch
from gold.fact_transaksi t
LEFT JOIN gold.dim_branch b
on b.id_branch = t.id_branch
LEFT JOIN gold.dim_channel c
on c.id_channel = t.id_channel
),
aggregate_data as(
/*---------------------------------------------------------------------------
2) Aggregations: Summarizes key metrics 
---------------------------------------------------------------------------*/
SELECT
*,
DAY(tanggal_transaksi) as date_day,
MONTH(tanggal_transaksi) as date_month,
SUM(jumlah)over(PARTITION BY tanggal_transaksi) as total_cost_transaksi_harian,
AVG(jumlah)over(PARTITION BY tanggal_transaksi) as avg_transaksi_harian,
COUNT(id_transaksi) OVER (PARTITION by tanggal_transaksi) as freq_transaksi_harian,
COUNT(id_transaksi) OVER (partition by nama_channel)as freq_transaksi_by_channel,
COUNT(id_transaksi) OVER (PARTITION by MONTH(tanggal_transaksi)) as freq_transaksi_bulanan
FROM base_query
)
SELECT
id_transaksi,
nomor_akun,
tanggal_transaksi,
jumlah,
id_channel,
nama_channel,
id_branch,
kode_branch,
total_cost_transaksi_harian,
avg_transaksi_harian,
freq_transaksi_harian,
freq_transaksi_by_channel,
freq_transaksi_bulanan,
AVG(freq_transaksi_harian) over(partition by date_day) as avg_freq_transaksi_harian
FROM aggregate_data