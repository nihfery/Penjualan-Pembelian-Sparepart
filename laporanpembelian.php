<?php
// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "bengkelapasi");
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

$tgl_pembelian = isset($_GET['tgl_pembelian']) ? $_GET['tgl_pembelian'] : date('Y-m-d');

// Mengambil data dari tabel pembelian_sparepart
$sql = "SELECT pb.tanggal_pembelian, pb.id_pembelian, v.nama_vendor AS vendor, pb.total_harga 
        FROM pembelian_sparepart pb
        JOIN vendor v ON pb.id_vendor = v.id_vendor 
        WHERE pb.tanggal_pembelian = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $tgl_pembelian);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Pembelian Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">LAPORAN PEMBELIAN SPAREPART</h2>
    <div class="card mt-4">
        <div class="card-body">
            <form method="get" action="">
                <div class="row">
                    <div class="col-md-6">
                        <label for="tgl_pembelian" class="form-label">Pilih Tanggal</label>
                        <input type="date" name="tgl_pembelian" id="tgl_pembelian" class="form-control" value="<?= $tgl_pembelian; ?>" required>
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
                    <th>ID Pembelian</th>
                    <th>Vendor</th>
                    <th>Total Belanja (Rp)</th>
                    <th>Lihat</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $no = 1;
                while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= date('d-m-Y', strtotime($row["tanggal_pembelian"])) ?></td>
                        <td><?= htmlspecialchars($row["id_pembelian"]) ?></td>
                        <td><?= htmlspecialchars($row["vendor"]) ?></td>
                        <td><?= number_format($row["total_harga"], 0, ',', '.') ?></td>
                        <td>
                            <a href="nota.php?id_pembelian=<?= $row['id_pembelian'] ?>" class="btn btn-info btn-sm">Nota</a>
                        
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>
    <a href="karen.php" class="btn btn-secondary">Kembali</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php
$stmt->close();
$conn->close();
?>
