<?php
// Koneksi ke database
$mysqli = new mysqli("localhost", "root", "", "bengkelapasi");
if ($mysqli->connect_error) {
    die("Koneksi gagal: " . $mysqli->connect_error);
}

// Ambil data vendor
$vendor_result = $mysqli->query("SELECT id_vendor, nama_vendor FROM vendor");

// Ambil data sparepart
$sparepart_query = "
    SELECT s.id_sparepart, s.nama_sparepart, s.harga, s.stok, k.nama_kategori 
    FROM sparepart s
    JOIN kategori_sparepart k ON s.id_kategori = k.id_kategori
";
$sparepart_result = $mysqli->query($sparepart_query);

// Ambil ID terakhir dari pembelian_sparepart
$result = $mysqli->query("SELECT IFNULL(MAX(id_pembelian), 0) AS last_id FROM pembelian_sparepart");
$last_id = ($result && $row = $result->fetch_assoc()) ? (int)$row['last_id'] : 0;
$next_id = $last_id + 1;

// Simpan transaksi pembelian sparepart
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['simpan_transaksi'])) {
    $id_pembelian = $_POST['id_pembelian'];
    $tgl_pembelian = $_POST['tgl_pembelian'];
    $total_harga = $_POST['total_harga'];
    $id_vendor = $_POST['id_vendor'];

    // Format tanggal menjadi format MySQL
    $tanggal_terformat = date('Y-m-d', strtotime($tgl_pembelian));

    // Mulai transaksi database
    $mysqli->begin_transaction();
    try {
        // Insert ke tabel pembelian_sparepart
        $stmt = $mysqli->prepare(
            "INSERT INTO pembelian_sparepart (id_pembelian, total_harga, tanggal_pembelian, id_vendor) 
            VALUES (?, ?, ?, ?)"
        );
        $stmt->bind_param("idss", $id_pembelian, $total_harga, $tanggal_terformat, $id_vendor);
        $stmt->execute();

        // Insert ke tabel detail_pembelian_sparepart dan update stok sparepart
        if (isset($_POST['barang'])) {
            foreach ($_POST['barang'] as $barang) {
                $id_sparepart = $barang['id_sparepart'];
                $jumlah = $barang['jumlah'];
                $harga_beli = $barang['harga'];

                // Hitung subtotal
                $subtotal = $jumlah * $harga_beli;

                // Hitung harga jual (markup 10%)
                $harga_jual = $harga_beli * 1.10;

                // Insert ke detail_pembelian_sparepart
                $stmt_detail = $mysqli->prepare(
                    "INSERT INTO detail_pembelian_sparepart (id_pembelian, id_sparepart, jumlah, subtotal) 
                    VALUES (?, ?, ?, ?)"
                );
                $stmt_detail->bind_param("iiid", $id_pembelian, $id_sparepart, $jumlah, $subtotal);
                $stmt_detail->execute();

                // Update stok sparepart
                $stmt_update_stok = $mysqli->prepare(
                    "UPDATE sparepart SET stok = stok + ?, harga = ? WHERE id_sparepart = ?"
                );
                $stmt_update_stok->bind_param("idi", $jumlah, $harga_jual, $id_sparepart);
                $stmt_update_stok->execute();
            }
        }

        // Commit transaksi
        $mysqli->commit();
        echo "<script>alert('Transaksi pembelian berhasil disimpan dan harga sparepart diperbarui!');</script>";
    } catch (Exception $e) {
        // Rollback jika terjadi error
        $mysqli->rollback();
        echo "<script>alert('Transaksi pembelian gagal: " . $e->getMessage() . "');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaksi Pembelian Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">PEMBELIAN BARANG / SPAREPART</h2>
        <hr>
        <div class="d-flex justify-content-start mb-3">
            <a href="laporanpembelian.php" class="btn btn-secondary">Lihat Laporan Pembelian</a>
        </div>
        <form method="POST" action="">
            <h5>DATA TRANSAKSI</h5>
            <div class="row mb-3">
                <label for="id_pembelian" class="col-md-3 col-form-label">Nomor Pembelian</label>
                <div class="col-md-4">
                    <input type="text" name="id_pembelian" id="id_pembelian" class="form-control" readonly value="<?= $next_id ?>">
                </div>
            </div>
            <div class="row mb-3">
                <label for="tgl_pembelian" class="col-md-3 col-form-label">Tanggal Pembelian</label>
                <div class="col-md-4">
                    <input type="date" name="tgl_pembelian" id="tgl_pembelian" class="form-control" value="<?= date('Y-m-d'); ?>" required>
                </div>
            </div>
            <div class="row mb-3">
                <label for="id_vendor" class="col-md-3 col-form-label">Vendor</label>
                <div class="col-md-4">
                    <select name="id_vendor" id="id_vendor" class="form-control" required>
                        <option value="">-- Pilih Vendor --</option>
                        <?php while ($row = $vendor_result->fetch_assoc()): ?>
                            <option value="<?= $row['id_vendor'] ?>"><?= $row['nama_vendor'] ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="col-md-1">
                    <a href="tambahvendor.php" class="btn btn-primary">+</a>
                </div>
            </div>

            <h5>INPUT SPAREPART</h5>
            <div class="row mb-3">
                <label class="col-md-3 col-form-label">Nama Barang</label>
                <div class="col-md-4">
                    <select id="barang" class="form-control">
                        <option value="">-- Pilih Sparepart --</option>
                        <?php while ($row = $sparepart_result->fetch_assoc()): ?>
                            <option value="<?= $row['id_sparepart'] ?>" 
                                    data-harga="<?= $row['harga'] ?>" 
                                    data-stok="<?= $row['stok'] ?>">
                                <?= $row['nama_sparepart'] ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="col-md-1">
                    <a href="tambahsparepart.php" class="btn btn-primary">+</a>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-md-3 col-form-label">Harga Beli</label>
                <div class="col-md-4">
                    <input type="number" id="harga" class="form-control" min="0" required>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-md-3 col-form-label">Jumlah</label>
                <div class="col-md-4">
                    <input type="number" id="jumlah" class="form-control" min="1">
                </div>
            </div>
            <div class="row mb-3">
                <div class="mb-3">
                    <button type="button" id="tambah-barang" class="btn btn-success btn-sm">Tambah</button>
                </div>
            </div>
            <hr>
            <h5>DAFTAR BARANG</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>No</th>
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
                        <td colspan="4" class="text-end"><strong>Total Harga (Rp):</strong></td>
                        <td id="grand-total">0</td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
            <input type="hidden" name="total_harga" value="0">
            <div class="row">
                <div class="mb-3">
                    <button type="submit" name="simpan_transaksi" class="btn btn-primary">Simpan Transaksi</button>
                </div>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('tambah-barang').onclick = function () {
            let barang = document.getElementById('barang');
            let jumlahInput = document.getElementById('jumlah');
            let hargaInput = document.getElementById('harga');
            let jumlah = parseInt(jumlahInput.value);
            let harga = parseFloat(hargaInput.value);

            if (!barang.value || isNaN(jumlah) || jumlah <= 0 || isNaN(harga) || harga <= 0) {
                alert('Pilih sparepart, masukkan jumlah, dan harga yang valid!');
                return;
            }

            let namaSparepart = barang.options[barang.selectedIndex].text.split(' - ')[0];
            let idSparepart = barang.value;
            let subtotal = harga * jumlah;

            let row = `<tr>
                            <td><input type="hidden" name="barang[${idSparepart}][id_sparepart]" value="${idSparepart}">${idSparepart}</td>
                            <td>${namaSparepart}</td>
                            <td><input type="hidden" name="barang[${idSparepart}][harga]" value="${harga}">${harga.toFixed(2)}</td>
                            <td><input type="hidden" name="barang[${idSparepart}][jumlah]" value="${jumlah}">${jumlah}</td>
                            <td>${subtotal.toFixed(2)}</td>
                            <td><button type="button" class="btn btn-danger btn-sm" onclick="hapusBarang(this)">Hapus</button></td>
                        </tr>`;

            document.getElementById('daftar-barang').innerHTML += row;
            hitungGrandTotal();
        };

        function hitungGrandTotal() {
            let grandTotal = 0;
            document.querySelectorAll('#daftar-barang tr').forEach(row => {
                let subtotal = parseFloat(row.querySelector('td:nth-child(5)').textContent);
                grandTotal += subtotal;
            });
            document.getElementById('grand-total').textContent = grandTotal.toFixed(2);
            document.querySelector('input[name="total_harga"]').value = grandTotal.toFixed(2);
        }

        function hapusBarang(button) {
            button.closest('tr').remove();
            hitungGrandTotal();
        }
    </script>
</body>
</html>
