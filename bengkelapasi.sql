-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 22, 2024 at 07:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bengkelapasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `alamat_mekanik`
--

CREATE TABLE `alamat_mekanik` (
  `id_mekanik` int(11) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `alamat_mekanik`
--

INSERT INTO `alamat_mekanik` (`id_mekanik`, `alamat`) VALUES
(1, 'Jl. Merdeka No.1, Jakarta'),
(2, 'Jl. Pahlawan No.2, Bandung'),
(3, 'Jl. Cendana No.3, Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `alamat_member`
--

CREATE TABLE `alamat_member` (
  `id_member` int(11) NOT NULL,
  `alamat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `alamat_member`
--

INSERT INTO `alamat_member` (`id_member`, `alamat`) VALUES
(1, 'Jl. Kebon Jeruk No.4, Jakarta'),
(2, 'Jl. Anggrek No.5, Bandung'),
(3, 'Jl. Mawar No.6, Surabaya');

-- --------------------------------------------------------

--
-- Table structure for table `alamat_vendor`
--

CREATE TABLE `alamat_vendor` (
  `id_vendor` int(11) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `alamat_vendor`
--

INSERT INTO `alamat_vendor` (`id_vendor`, `alamat`) VALUES
(1, 'Jl. Raya No. 1, Jakarta, Indonesia'),
(2, 'Jl. Sudirman No. 12, Bandung, Indonesia'),
(3, 'Jl. Merdeka No. 5, Surabaya, Indonesia');

-- --------------------------------------------------------

--
-- Table structure for table `coa`
--

CREATE TABLE `coa` (
  `no_akun` char(5) NOT NULL DEFAULT '',
  `nama_akun` varchar(20) DEFAULT NULL,
  `header_akun` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `coa`
--

INSERT INTO `coa` (`no_akun`, `nama_akun`, `header_akun`) VALUES
('1', 'Aktiva', NULL),
('11', 'Aktiva Lancar', '1'),
('111', 'Kas', '11'),
('112', 'Piutang Dagang', '11'),
('113', 'Persediaan Barang Da', '11'),
('114', 'Sewa Dibayar Dimuka ', '11'),
('115', 'Asuransi Dibayar Dim', '11'),
('116', 'Perlengkapan', '11'),
('2', 'Hutang', NULL),
('21', 'Hutang Lancar', '2'),
('211', 'Utang Dagang', '21'),
('3', 'Modal', NULL),
('311', 'Modal Tn X', '3'),
('3112', 'Prive Tn. X', '311'),
('4', 'Pendapatan', NULL),
('41', 'Pendapatan Usaha', '4'),
('411', 'Penjualan', '41'),
('412', 'Harga Pokok Penjuala', '41'),
('413', 'Retur Penjualan', '41'),
('414', 'Potongan Penjualan', '41'),
('415', 'Pendapatan Jasa', '41'),
('5', 'Beban', NULL),
('511', 'Beban Listrik', '5'),
('512', 'Beban Air', '5'),
('513', 'Beban Telepon', '5'),
('514', 'Beban Gaji', '5');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian_sparepart`
--

CREATE TABLE `detail_pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `id_sparepart` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `detail_pembelian_sparepart`
--

INSERT INTO `detail_pembelian_sparepart` (`id_pembelian`, `id_sparepart`, `jumlah`, `subtotal`) VALUES
(1, 1, 10, 500000.00),
(1, 2, 4, 300000.00),
(3, 1, 5, 250000.00),
(4, 1, 5, 250000.00),
(5, 1, 2, 100000.00),
(6, 1, 5, 250000.00),
(7, 5, 5, 650000.00),
(8, 5, 5, 650000.00),
(9, 5, 20, 2600000.00),
(10, 5, 10, 1300000.00),
(11, 6, 20, 2400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan_jasa`
--

CREATE TABLE `detail_penjualan_jasa` (
  `id_jasa` int(11) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `detail_penjualan_jasa`
--

INSERT INTO `detail_penjualan_jasa` (`id_jasa`, `id_penjualan`, `jumlah`, `subtotal`) VALUES
(1, 1, 1, 150000.00),
(2, 2, 1, 500000.00),
(3, 3, 1, 300000.00);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan_sparepart`
--

CREATE TABLE `detail_penjualan_sparepart` (
  `id_penjualan` int(11) NOT NULL,
  `id_sparepart` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `detail_penjualan_sparepart`
--

INSERT INTO `detail_penjualan_sparepart` (`id_penjualan`, `id_sparepart`, `jumlah`, `subtotal`) VALUES
(1, 1, 2, 100000.00),
(2, 3, 2, 150000.00),
(3, 1, 10, 500000.00),
(4, 1, 5, 250000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jasa`
--

CREATE TABLE `jasa` (
  `id_jasa` int(11) NOT NULL,
  `nama_jasa` varchar(255) DEFAULT NULL,
  `id_kategori` varchar(15) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jasa`
--

INSERT INTO `jasa` (`id_jasa`, `nama_jasa`, `id_kategori`, `harga`) VALUES
(1, 'Ganti Oli', 'KJ01', 150000.00),
(2, 'Perbaikan Mesin', 'KJ02', 500000.00),
(3, 'Servis Kelistrikan', 'KJ03', 300000.00),
(4, 'Perbaikan Pengereman', 'KJ04', 250000.00),
(5, 'Perbaikan Suspensi', 'KJ05', 400000.00),
(6, 'Ganti Spion', 'KJ01', 30000.00),
(7, 'Ganti Lampu', 'KJ01', 20000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_pembelian_sparepart`
--

CREATE TABLE `jurnal_pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `no_akun` char(5) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') DEFAULT NULL,
  `nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jurnal_pembelian_sparepart`
--

INSERT INTO `jurnal_pembelian_sparepart` (`id_pembelian`, `no_akun`, `posisi_dr_cr`, `nominal`) VALUES
(1, '111', 'kredit', 500000.00),
(2, '111', 'kredit', 300000.00),
(1, '113', 'debit', 500000.00),
(2, '113', 'debit', 300000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penggajian`
--

CREATE TABLE `jurnal_penggajian` (
  `no_akun` char(5) NOT NULL,
  `id_penggajian` int(11) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') DEFAULT NULL,
  `nominal` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jurnal_penggajian`
--

INSERT INTO `jurnal_penggajian` (`no_akun`, `id_penggajian`, `posisi_dr_cr`, `nominal`) VALUES
('111', 1, 'kredit', 3300000.00),
('111', 2, 'kredit', 2900000.00),
('111', 3, 'kredit', 3600000.00),
('511', 1, 'debit', 3300000.00),
('511', 2, 'debit', 2900000.00),
('511', 3, 'debit', 3600000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penjualan_jasa`
--

CREATE TABLE `jurnal_penjualan_jasa` (
  `no_akun` char(5) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') DEFAULT NULL,
  `nominal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jurnal_penjualan_jasa`
--

INSERT INTO `jurnal_penjualan_jasa` (`no_akun`, `id_penjualan`, `posisi_dr_cr`, `nominal`) VALUES
('111', 1, 'kredit', 150000.00),
('111', 2, 'kredit', 500000.00),
('111', 3, 'kredit', 300000.00),
('415', 1, 'debit', 150000.00),
('415', 2, 'debit', 500000.00),
('415', 3, 'debit', 300000.00);

-- --------------------------------------------------------

--
-- Table structure for table `jurnal_penjualan_sparepart`
--

CREATE TABLE `jurnal_penjualan_sparepart` (
  `no_akun` char(5) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `posisi_dr_cr` enum('debit','kredit') NOT NULL,
  `nominal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `jurnal_penjualan_sparepart`
--

INSERT INTO `jurnal_penjualan_sparepart` (`no_akun`, `id_penjualan`, `posisi_dr_cr`, `nominal`) VALUES
('111', 1, 'debit', 100000.00),
('111', 2, 'debit', 150000.00),
('411', 1, 'kredit', 100000.00),
('411', 2, 'kredit', 150000.00);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_jasa`
--

CREATE TABLE `kategori_jasa` (
  `id_kategori` varchar(10) NOT NULL,
  `nama_kategori` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `kategori_jasa`
--

INSERT INTO `kategori_jasa` (`id_kategori`, `nama_kategori`) VALUES
('KJ01', 'Servis Berkala'),
('KJ02', 'Sistem Mesin'),
('KJ03', 'Sistem Kelistrikan'),
('KJ04', 'Sistem Pengereman'),
('KJ05', 'Sistem Suspensi');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_sparepart`
--

CREATE TABLE `kategori_sparepart` (
  `id_kategori` varchar(15) NOT NULL,
  `nama_kategori` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `kategori_sparepart`
--

INSERT INTO `kategori_sparepart` (`id_kategori`, `nama_kategori`) VALUES
('S001', 'Mesin'),
('S002', 'Oli'),
('S003', 'Rem');

-- --------------------------------------------------------

--
-- Table structure for table `mekanik`
--

CREATE TABLE `mekanik` (
  `id_mekanik` int(11) NOT NULL,
  `nama_mekanik` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `mekanik`
--

INSERT INTO `mekanik` (`id_mekanik`, `nama_mekanik`) VALUES
(1, 'Budi Santoso'),
(2, 'Siti Aminah'),
(3, 'Joko Widodo');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id_member` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id_member`, `nama`) VALUES
(1, 'Andi Setiawan'),
(2, 'Rina Sari'),
(3, 'Dewi Lestari'),
(4, 'Fery'),
(5, 'Ridho');

-- --------------------------------------------------------

--
-- Table structure for table `no_telepon_mekanik`
--

CREATE TABLE `no_telepon_mekanik` (
  `id_mekanik` int(11) NOT NULL,
  `no_telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `no_telepon_mekanik`
--

INSERT INTO `no_telepon_mekanik` (`id_mekanik`, `no_telepon`) VALUES
(1, '081234567890'),
(2, '082345678901'),
(3, '083456789012');

-- --------------------------------------------------------

--
-- Table structure for table `no_telepon_member`
--

CREATE TABLE `no_telepon_member` (
  `id_member` int(11) NOT NULL,
  `no_telepon` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `no_telepon_member`
--

INSERT INTO `no_telepon_member` (`id_member`, `no_telepon`) VALUES
(1, '087654321098'),
(2, '088765432109'),
(3, '089876543210');

-- --------------------------------------------------------

--
-- Table structure for table `no_telepon_vendor`
--

CREATE TABLE `no_telepon_vendor` (
  `id_vendor` int(11) NOT NULL,
  `no_telepon` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `no_telepon_vendor`
--

INSERT INTO `no_telepon_vendor` (`id_vendor`, `no_telepon`) VALUES
(1, '021-12345678'),
(2, '022-23456789'),
(3, '031-34567890');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_sparepart`
--

CREATE TABLE `pembelian_sparepart` (
  `id_pembelian` int(11) NOT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_pembelian` date DEFAULT NULL,
  `id_vendor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `pembelian_sparepart`
--

INSERT INTO `pembelian_sparepart` (`id_pembelian`, `total_harga`, `tanggal_pembelian`, `id_vendor`) VALUES
(1, 500000.00, '2023-10-01', 1),
(2, 300000.00, '2023-10-02', 2),
(3, 200000.00, '2024-12-21', 1),
(4, 200000.00, '2024-12-21', 1),
(5, 80000.00, '2024-12-21', 2),
(6, 200000.00, '2024-12-21', 1),
(7, 650000.00, '2024-12-22', 1),
(8, 650000.00, '2024-12-22', 1),
(9, 2600000.00, '2024-12-22', 1),
(10, 1300000.00, '2024-12-22', 4),
(11, 2400000.00, '2024-12-22', 5);

-- --------------------------------------------------------

--
-- Table structure for table `penggajian`
--

CREATE TABLE `penggajian` (
  `id_penggajian` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `gaji_pokok` decimal(15,2) NOT NULL,
  `tunjangan` decimal(15,2) NOT NULL,
  `potongan` decimal(15,2) NOT NULL,
  `total_gaji` decimal(15,2) NOT NULL,
  `id_mekanik` int(11) NOT NULL,
  `id_presensi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `penggajian`
--

INSERT INTO `penggajian` (`id_penggajian`, `tanggal`, `gaji_pokok`, `tunjangan`, `potongan`, `total_gaji`, `id_mekanik`, `id_presensi`) VALUES
(1, '2023-10-01', 3000000.00, 500000.00, 200000.00, 3300000.00, 1, 1),
(2, '2023-10-01', 2800000.00, 400000.00, 150000.00, 2900000.00, 2, 2),
(3, '2023-10-01', 3200000.00, 600000.00, 250000.00, 3600000.00, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan_jasa`
--

CREATE TABLE `penjualan_jasa` (
  `id_penjualan` int(11) NOT NULL,
  `total_harga` decimal(15,2) DEFAULT NULL,
  `tanggal_penjualan` date DEFAULT NULL,
  `id_member` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `penjualan_jasa`
--

INSERT INTO `penjualan_jasa` (`id_penjualan`, `total_harga`, `tanggal_penjualan`, `id_member`) VALUES
(1, 150000.00, '2023-10-01', 1),
(2, 500000.00, '2023-10-02', 2),
(3, 300000.00, '2023-10-03', 1);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan_sparepart`
--

CREATE TABLE `penjualan_sparepart` (
  `id_penjualan` int(11) NOT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `tanggal_penjualan` date DEFAULT NULL,
  `id_member` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `penjualan_sparepart`
--

INSERT INTO `penjualan_sparepart` (`id_penjualan`, `total_harga`, `tanggal_penjualan`, `id_member`) VALUES
(1, 100000.00, '2023-10-01', 1),
(2, 300000.00, '2023-10-02', 2),
(3, 500000.00, '2024-12-20', 1),
(4, 250000.00, '2024-12-20', 4);

-- --------------------------------------------------------

--
-- Table structure for table `presensi`
--

CREATE TABLE `presensi` (
  `id_presensi` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('hadir','tidak hadir','sakit','cuti') DEFAULT NULL,
  `id_mekanik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `presensi`
--

INSERT INTO `presensi` (`id_presensi`, `tanggal`, `status`, `id_mekanik`) VALUES
(1, '2023-10-01', 'hadir', 1),
(2, '2023-10-01', 'tidak hadir', 2),
(3, '2023-10-01', 'hadir', 3);

-- --------------------------------------------------------

--
-- Table structure for table `sparepart`
--

CREATE TABLE `sparepart` (
  `id_sparepart` int(11) NOT NULL,
  `nama_sparepart` varchar(255) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `id_kategori` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `sparepart`
--

INSERT INTO `sparepart` (`id_sparepart`, `nama_sparepart`, `harga`, `stok`, `id_kategori`) VALUES
(1, 'Busi', 50000.00, 82, 'S001'),
(2, 'Oli Pertamina', 75000.00, 25, 'S002'),
(3, 'Kampas Rem', 100000.00, 15, 'S003'),
(4, 'Oli Motul', 121000.00, 20, 'S002'),
(5, 'Oli Motul 5100', 143000.00, 50, 'S002'),
(6, 'Oli Shell', 132000.00, 20, 'S002');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id_vendor` int(11) NOT NULL,
  `nama_vendor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`id_vendor`, `nama_vendor`) VALUES
(1, 'Yamaha'),
(2, 'Honda'),
(3, 'Kawasaki'),
(4, 'Motul'),
(5, 'Shell');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alamat_mekanik`
--
ALTER TABLE `alamat_mekanik`
  ADD PRIMARY KEY (`id_mekanik`);

--
-- Indexes for table `alamat_member`
--
ALTER TABLE `alamat_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `alamat_vendor`
--
ALTER TABLE `alamat_vendor`
  ADD PRIMARY KEY (`id_vendor`);

--
-- Indexes for table `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`no_akun`),
  ADD KEY `fk_no_akun` (`header_akun`);

--
-- Indexes for table `detail_pembelian_sparepart`
--
ALTER TABLE `detail_pembelian_sparepart`
  ADD PRIMARY KEY (`id_pembelian`,`id_sparepart`),
  ADD KEY `id_sparepart` (`id_sparepart`);

--
-- Indexes for table `detail_penjualan_jasa`
--
ALTER TABLE `detail_penjualan_jasa`
  ADD PRIMARY KEY (`id_jasa`,`id_penjualan`),
  ADD KEY `id_penjualan` (`id_penjualan`);

--
-- Indexes for table `detail_penjualan_sparepart`
--
ALTER TABLE `detail_penjualan_sparepart`
  ADD PRIMARY KEY (`id_penjualan`,`id_sparepart`),
  ADD KEY `id_sparepart` (`id_sparepart`);

--
-- Indexes for table `jasa`
--
ALTER TABLE `jasa`
  ADD PRIMARY KEY (`id_jasa`),
  ADD KEY `fk_id_kategori_jasa` (`id_kategori`);

--
-- Indexes for table `jurnal_pembelian_sparepart`
--
ALTER TABLE `jurnal_pembelian_sparepart`
  ADD PRIMARY KEY (`no_akun`,`id_pembelian`),
  ADD KEY `id_pembelian` (`id_pembelian`);

--
-- Indexes for table `jurnal_penggajian`
--
ALTER TABLE `jurnal_penggajian`
  ADD PRIMARY KEY (`no_akun`,`id_penggajian`),
  ADD KEY `id_penggajian` (`id_penggajian`);

--
-- Indexes for table `jurnal_penjualan_jasa`
--
ALTER TABLE `jurnal_penjualan_jasa`
  ADD PRIMARY KEY (`no_akun`,`id_penjualan`),
  ADD KEY `id_penjualan` (`id_penjualan`);

--
-- Indexes for table `jurnal_penjualan_sparepart`
--
ALTER TABLE `jurnal_penjualan_sparepart`
  ADD PRIMARY KEY (`no_akun`,`id_penjualan`),
  ADD KEY `id_penjualan` (`id_penjualan`);

--
-- Indexes for table `kategori_jasa`
--
ALTER TABLE `kategori_jasa`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `kategori_sparepart`
--
ALTER TABLE `kategori_sparepart`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `mekanik`
--
ALTER TABLE `mekanik`
  ADD PRIMARY KEY (`id_mekanik`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `no_telepon_mekanik`
--
ALTER TABLE `no_telepon_mekanik`
  ADD PRIMARY KEY (`id_mekanik`);

--
-- Indexes for table `no_telepon_member`
--
ALTER TABLE `no_telepon_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `no_telepon_vendor`
--
ALTER TABLE `no_telepon_vendor`
  ADD PRIMARY KEY (`id_vendor`);

--
-- Indexes for table `pembelian_sparepart`
--
ALTER TABLE `pembelian_sparepart`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `id_vendor` (`id_vendor`);

--
-- Indexes for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD PRIMARY KEY (`id_penggajian`),
  ADD KEY `id_mekanik` (`id_mekanik`),
  ADD KEY `id_presensi` (`id_presensi`);

--
-- Indexes for table `penjualan_jasa`
--
ALTER TABLE `penjualan_jasa`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `penjualan_sparepart`
--
ALTER TABLE `penjualan_sparepart`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `presensi`
--
ALTER TABLE `presensi`
  ADD PRIMARY KEY (`id_presensi`),
  ADD KEY `id_mekanik` (`id_mekanik`);

--
-- Indexes for table `sparepart`
--
ALTER TABLE `sparepart`
  ADD PRIMARY KEY (`id_sparepart`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id_vendor`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alamat_mekanik`
--
ALTER TABLE `alamat_mekanik`
  ADD CONSTRAINT `pkfk_id_mekanik` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `alamat_member`
--
ALTER TABLE `alamat_member`
  ADD CONSTRAINT `pkfk_id_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `alamat_vendor`
--
ALTER TABLE `alamat_vendor`
  ADD CONSTRAINT `pkfk_id_vendor` FOREIGN KEY (`id_vendor`) REFERENCES `vendor` (`id_vendor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `coa`
--
ALTER TABLE `coa`
  ADD CONSTRAINT `fk_no_akun` FOREIGN KEY (`header_akun`) REFERENCES `coa` (`no_akun`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_pembelian_sparepart`
--
ALTER TABLE `detail_pembelian_sparepart`
  ADD CONSTRAINT `detail_pembelian_sparepart_ibfk_1` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian_sparepart` (`id_pembelian`),
  ADD CONSTRAINT `detail_pembelian_sparepart_ibfk_2` FOREIGN KEY (`id_sparepart`) REFERENCES `sparepart` (`id_sparepart`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_penjualan_jasa`
--
ALTER TABLE `detail_penjualan_jasa`
  ADD CONSTRAINT `detail_penjualan_jasa_ibfk_1` FOREIGN KEY (`id_jasa`) REFERENCES `jasa` (`id_jasa`),
  ADD CONSTRAINT `detail_penjualan_jasa_ibfk_2` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_jasa` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `detail_penjualan_sparepart`
--
ALTER TABLE `detail_penjualan_sparepart`
  ADD CONSTRAINT `detail_penjualan_sparepart_ibfk_1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_sparepart` (`id_penjualan`),
  ADD CONSTRAINT `detail_penjualan_sparepart_ibfk_2` FOREIGN KEY (`id_sparepart`) REFERENCES `sparepart` (`id_sparepart`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jasa`
--
ALTER TABLE `jasa`
  ADD CONSTRAINT `fk_id_kategori_jasa` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_jasa` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_pembelian_sparepart`
--
ALTER TABLE `jurnal_pembelian_sparepart`
  ADD CONSTRAINT `jurnal_pembelian_sparepart_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_pembelian_sparepart_ibfk_2` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian_sparepart` (`id_pembelian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penggajian`
--
ALTER TABLE `jurnal_penggajian`
  ADD CONSTRAINT `jurnal_penggajian_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_penggajian_ibfk_2` FOREIGN KEY (`id_penggajian`) REFERENCES `penggajian` (`id_penggajian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penjualan_jasa`
--
ALTER TABLE `jurnal_penjualan_jasa`
  ADD CONSTRAINT `jurnal_penjualan_jasa_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_penjualan_jasa_ibfk_2` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_jasa` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jurnal_penjualan_sparepart`
--
ALTER TABLE `jurnal_penjualan_sparepart`
  ADD CONSTRAINT `jurnal_penjualan_sparepart_ibfk_1` FOREIGN KEY (`no_akun`) REFERENCES `coa` (`no_akun`),
  ADD CONSTRAINT `jurnal_penjualan_sparepart_ibfk_2` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan_sparepart` (`id_penjualan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `no_telepon_mekanik`
--
ALTER TABLE `no_telepon_mekanik`
  ADD CONSTRAINT `pkfk_idd_mekanik` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `no_telepon_member`
--
ALTER TABLE `no_telepon_member`
  ADD CONSTRAINT `pkfk_idd_member` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `no_telepon_vendor`
--
ALTER TABLE `no_telepon_vendor`
  ADD CONSTRAINT `pkfk_idd_vendor` FOREIGN KEY (`id_vendor`) REFERENCES `vendor` (`id_vendor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembelian_sparepart`
--
ALTER TABLE `pembelian_sparepart`
  ADD CONSTRAINT `pembelian_sparepart_ibfk_1` FOREIGN KEY (`id_vendor`) REFERENCES `vendor` (`id_vendor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penggajian`
--
ALTER TABLE `penggajian`
  ADD CONSTRAINT `penggajian_ibfk_1` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`),
  ADD CONSTRAINT `penggajian_ibfk_2` FOREIGN KEY (`id_presensi`) REFERENCES `presensi` (`id_presensi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penjualan_jasa`
--
ALTER TABLE `penjualan_jasa`
  ADD CONSTRAINT `penjualan_jasa_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penjualan_sparepart`
--
ALTER TABLE `penjualan_sparepart`
  ADD CONSTRAINT `penjualan_sparepart_ibfk_1` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `presensi`
--
ALTER TABLE `presensi`
  ADD CONSTRAINT `presensi_ibfk_1` FOREIGN KEY (`id_mekanik`) REFERENCES `mekanik` (`id_mekanik`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sparepart`
--
ALTER TABLE `sparepart`
  ADD CONSTRAINT `sparepart_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_sparepart` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
