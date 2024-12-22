<?php
// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "bengkelapasi");
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

$tgl_penjualan = isset($_GET['tgl_penjualan']) ? $_GET['tgl_penjualan'] : date('Y-m-d');

$sql = "SELECT ps.tanggal_penjualan, ps.id_penjualan, m.nama AS pelanggan, ps.total_harga 
        FROM penjualan_sparepart ps 
        JOIN member m ON ps.id_member = m.id_member 
        WHERE ps.tanggal_penjualan = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $tgl_penjualan);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Penjualan Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">LAPORAN PENJUALAN SPAREPART</h2>
    <div class="card mt-4">
        <div class="card-body">
            <form method="get" action="">
                <div class="row">
                    <div class="col-md-6">
                        <label for="tgl_penjualan" class="form-label">Pilih Tanggal</label>
                        <input type="date" name="tgl_penjualan" id="tgl_penjualan" class="form-control" value="<?= $tgl_penjualan; ?>" required>
                    </div>
                    <div class="col-md-3 align-self-end">
                        <button type="submit" class="btn btn-primary">Tampilkan</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="table-responsive mt-4">
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Tanggal</th>
                    <th>ID Penjualan</th>
                    <th>Pelanggan</th>
                    <th>Total Belanja (Rp)</th>
                    <th>Tools</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $no = 1;
                while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= date('d-m-Y', strtotime($row["tanggal_penjualan"])) ?></td>
                        <td><?= htmlspecialchars($row["id_penjualan"]) ?></td>
                        <td><?= htmlspecialchars($row["pelanggan"]) ?></td>
                        <td><?= number_format($row["total_harga"], 0, ',', '.') ?></td>
                        <td>
                            <a href="nota.php" class="btn btn-info btn-sm">Nota</a>
                            
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>
    <a href="dashboard.php" class="btn btn-secondary">Kembali</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php
$stmt->close();
$conn->close();
?>
