<?php
// Koneksi ke database
$mysqli = new mysqli("localhost", "root", "", "bengkelapasi");
if ($mysqli->connect_error) {
    die("Koneksi gagal: " . $mysqli->connect_error);
}

$member_result = $mysqli->query("SELECT id_member, nama FROM member");

// Ambil ID terakhir dari penjualan_sparepart
$result = $mysqli->query("SELECT IFNULL(MAX(id_penjualan), 0) AS last_id FROM penjualan_sparepart");
$last_id = ($result && $row = $result->fetch_assoc()) ? (int)$row['last_id'] : 0;
$next_id = $last_id + 1;

// Ambil data sparepart
$sparepart_result = $mysqli->query("SELECT * FROM sparepart");

// Simpan transaksi
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['simpan_transaksi'])) {
    $id_penjualan = $_POST['id_penjualan'];
    $tgl_penjualan = $_POST['tgl_penjualan'];
    $grand_total = $_POST['grand_total'];
    $id_member = $_POST['id_member'];

    // Format tanggal menjadi format MySQL
    $tanggal_terformat = date('Y-m-d', strtotime($tgl_penjualan));

    // Mulai transaksi database
    $mysqli->begin_transaction();
    try {
        // Insert ke tabel penjualan_sparepart
        $stmt = $mysqli->prepare(
            "INSERT INTO penjualan_sparepart (id_penjualan, total_harga, tanggal_penjualan, id_member) 
            VALUES (?, ?, ?, ?)"
        );
        $stmt->bind_param("idss", $id_penjualan, $grand_total, $tanggal_terformat, $id_member);
        $stmt->execute();

        // Insert ke tabel detail_penjualan_sparepart dan update stok sparepart
        if (isset($_POST['barang'])) {
            foreach ($_POST['barang'] as $barang) {
                $id_sparepart = $barang['id_sparepart'];
                $jumlah = $barang['jumlah'];

                // Hitung subtotal berdasarkan jumlah dan harga sparepart
                $result_harga = $mysqli->query("SELECT harga FROM sparepart WHERE id_sparepart = $id_sparepart");
                $harga = ($result_harga && $row_harga = $result_harga->fetch_assoc()) ? $row_harga['harga'] : 0;
                $subtotal = $jumlah * $harga;

                // Insert ke detail_penjualan_sparepart
                $stmt_detail = $mysqli->prepare(
                    "INSERT INTO detail_penjualan_sparepart (id_penjualan, id_sparepart, jumlah, subtotal) 
                    VALUES (?, ?, ?, ?)"
                );
                $stmt_detail->bind_param("iiid", $id_penjualan, $id_sparepart, $jumlah, $subtotal);
                $stmt_detail->execute();

                // Kurangi stok sparepart
                $stmt_update = $mysqli->prepare(
                    "UPDATE sparepart SET stok = stok - ? WHERE id_sparepart = ?"
                );
                $stmt_update->bind_param("ii", $jumlah, $id_sparepart);
                $stmt_update->execute();
            }
        }

        // Commit transaksi
        $mysqli->commit();
        echo "<script>alert('Transaksi berhasil disimpan!');</script>";
    } catch (Exception $e) {
        // Rollback jika terjadi error
        $mysqli->rollback();
        echo "<script>alert('Transaksi gagal: " . $e->getMessage() . "');</script>";
    }
}
?>





<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Penjualan Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center">PENJUALAN BARANG / SPAREPART</h2>
    <hr>
    <div class="d-flex justify-content-start mb-3">
        <a href="gudangsparepart.php" class="btn btn-secondary me-2">Gudang Sparepart </a>
        <a href="laporanpenjualan.php" class="btn btn-secondary">Lihat Laporan Penjulan</a>
    </div>
    <form method="POST" id="form-transaksi">
        <!-- Data Transaksi -->
        <h5>DATA TRANSAKSI</h5>
        <div class="row mb-2">
            <div class="col-md-3"><label>No. Penjualan</label></div>
            <div class="col-md-4">
                <input type="text" name="id_penjualan" class="form-control" value="<?= $next_id ?>" readonly>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-md-3"><label>Tgl. Penjualan</label></div>
            <div class="col-md-4">
                <input type="date" name="tgl_penjualan" class="form-control" value="<?= date('Y-m-d'); ?>" required>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-md-3"><label>Pelanggan</label></div>
            <div class="col-md-4">
                <select name="id_member" class="form-control" required>
                    <option value="">-- Pilih Pelanggan --</option>
                    <?php while ($row = $member_result->fetch_assoc()): ?>
                        <option value="<?= $row['id_member'] ?>"><?= htmlspecialchars($row['nama']) ?></option>
                    <?php endwhile; ?>
                </select>
            </div>
                <div class="col-md-1">
                    <a href="tambahpelanggan.php" class="btn btn-primary">+</a>
                </div>
        </div>
        <hr>

        <!-- Input Barang -->
        <h5>INPUT SPAREPART</h5>
        <div class="row mb-2">
            <div class="col-md-3"><label>Nama Barang</label></div>
            <div class="col-md-6">
                <select id="barang" class="form-control" onchange="tampilkanStok()">
                    <option value="">-- Pilih Sparepart --</option>
                    <?php while ($row = $sparepart_result->fetch_assoc()): ?>
                        <option value="<?= $row['id_sparepart'] ?>" data-harga="<?= $row['harga'] ?>" data-stok="<?= $row['stok'] ?>">
                            <?= $row['nama_sparepart'] ?> - Rp. <?= number_format($row['harga'], 2) ?>
                        </option>
                    <?php endwhile; ?>
                </select>
            </div>
        </div>

        <div class="row mb-2">
            <div class="col-md-3"><label>Total Stok</label></div>
            <div class="col-md-4">
                <input type="text" id="total-stok" class="form-control" readonly>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-md-3"><label>Jumlah</label></div>
            <div class="col-md-4">
                <input type="number" id="jumlah" class="form-control" min="1">
            </div>
        </div>
        <button type="button" id="tambah-barang" class="btn btn-success btn-sm">Tambah</button>
        <hr>

        <!-- Tabel Barang -->
        <h5>DAFTAR BARANG</h5>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Kode</th>
                    <th>Nama Barang</th>
                    <th>Harga</th>
                    <th>Jumlah</th>
                    <th>Subtotal</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody id="daftar-barang"></tbody>
            <tfoot>
                <tr>
                    <td colspan="4" class="text-end"><strong>Grand Total (Rp):</strong></td>
                    <td id="grand-total">0</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><strong>Pembayaran (Rp):</strong></td>
                    <td>
                        <input type="number" id="pembayaran" class="form-control" placeholder="Masukkan Pembayaran" min="1">
                    </td>
                    <td>
                        <button type="button" id="hitung-kembalian" class="btn btn-info btn-sm">Hitung Kembalian</button>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><strong>Kembalian (Rp):</strong></td>
                    <td id="kembalian">0</td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <input type="hidden" name="grand_total" value="0">

        <div class="d-flex justify-content-start mb-3">
            <button type="submit" name="simpan_transaksi" class="btn btn-primary">SIMPAN TRANSAKSI</button>
        </div>
        </form>
</div>

<script>
// Kode untuk menambahkan barang dan menghitung subtotal serta grand total sudah ada
document.getElementById('tambah-barang').onclick = function () {
    let barang = document.getElementById('barang');
    let jumlahInput = document.getElementById('jumlah');
    let jumlah = parseInt(jumlahInput.value);

    // Validasi input
    if (!barang.value || isNaN(jumlah) || jumlah <= 0) {
        alert('Pilih sparepart dan masukkan jumlah yang valid!');
        return;
    }

    // Ambil harga dan nama sparepart
    let harga = parseInt(barang.options[barang.selectedIndex].dataset.harga);
    let namaSparepart = barang.options[barang.selectedIndex].text.split(' - ')[0]; // Nama barang tanpa harga
    let idSparepart = barang.value;
    let subtotal = harga * jumlah;

    // Tambahkan barang ke daftar tabel
    let row = `<tr>
                    <td><input type="hidden" name="barang[${idSparepart}][id_sparepart]" value="${idSparepart}">${idSparepart}</td>
                    <td>${namaSparepart}</td>
                    <td>${harga}</td>
                    <td>
                        <input type="hidden" name="barang[${idSparepart}][jumlah]" value="${jumlah}">
                        ${jumlah}
                    </td>
                    <td>${subtotal}</td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm" onclick="hapusBaris(this)">Hapus</button>
                    </td>
                </tr>`;
    document.getElementById('daftar-barang').insertAdjacentHTML('beforeend', row);

    // Reset input jumlah
    jumlahInput.value = '';
    barang.selectedIndex = 0;

    // Update grand total
    updateGrandTotal();
};

document.getElementById('hitung-kembalian').onclick = function () {
    let grandTotal = parseFloat(document.querySelector('input[name="grand_total"]').value);
    let pembayaranInput = document.getElementById('pembayaran');
    let pembayaran = parseFloat(pembayaranInput.value);

    if (isNaN(pembayaran) || pembayaran <= 0) {
        alert('Masukkan pembayaran yang valid!');
        return;
    }

    if (pembayaran < grandTotal) {
        alert('Pembayaran tidak boleh kurang dari Grand Total!');
        return;
    }

    let kembalian = pembayaran - grandTotal;
    document.getElementById('kembalian').innerText = kembalian.toLocaleString();
};

// Fungsi untuk menghitung Grand Total
function updateGrandTotal() {
    let total = 0;
    document.querySelectorAll('#daftar-barang tr').forEach(row => {
        let subtotal = parseFloat(row.children[4].innerText);
        total += subtotal;
    });
    document.getElementById('grand-total').innerText = total.toLocaleString();
    document.querySelector('input[name="grand_total"]').value = total;
}

// Fungsi untuk menghapus baris barang
function hapusBaris(button) {
    button.closest('tr').remove();
    updateGrandTotal();
}

// Fungsi untuk menampilkan stok sparepart yang dipilih
function tampilkanStok() {
    var barang = document.getElementById('barang');
    var totalStok = document.getElementById('total-stok');

    // Pastikan item yang dipilih ada dan memiliki data stok
    if (barang.value !== "") {
        var selectedOption = barang.options[barang.selectedIndex];
        var stok = selectedOption.getAttribute('data-stok');
        totalStok.value = stok;
    } else {
        totalStok.value = ""; // Jika tidak ada barang yang dipilih
    }
}
</script>

</body>
</html>
