<?php
// Konfigurasi database
$host = 'localhost';
$username = 'root';
$password = ''; // Ganti sesuai password database kamu
$database = 'bengkelapasi'; // Ganti dengan nama database kamu

// Koneksi ke database
$conn = new mysqli($host, $username, $password, $database);

// Ambil id_vendor berikutnya
$sqlGetId = "SELECT MAX(id_vendor) AS max_id FROM vendor";
$result = $conn->query($sqlGetId);
$row = $result->fetch_assoc();
$nextId = $row['max_id'] + 1;

// Proses form ketika disubmit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama_vendor = $_POST['nama_vendor'];

    // Insert data ke database
    if ($conn->query("INSERT INTO vendor (id_vendor, nama_vendor) VALUES ('$nextId', '$nama_vendor')")) {
        // Jika berhasil, set session untuk pesan sukses
        session_start();
        $_SESSION['success'] = 'Vendor berhasil ditambahkan!';
    } else {
        // Jika gagal, set session untuk pesan error
        session_start();
        $_SESSION['error'] = 'Gagal menambahkan vendor!';
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Tambah Vendor</h1>

        <!-- Peringatan jika berhasil atau gagal -->
        <?php if (isset($_SESSION['success'])): ?>
            <div class="alert alert-success">
                <?= $_SESSION['success']; ?>
            </div>
            <?php unset($_SESSION['success']); ?>
        <?php elseif (isset($_SESSION['error'])): ?>
            <div class="alert alert-danger">
                <?= $_SESSION['error']; ?>
            </div>
            <?php unset($_SESSION['error']); ?>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="mb-3">
                <label for="id_vendor" class="form-label">ID Vendor</label>
                <input type="text" class="form-control" id="id_vendor" name="id_vendor" value="<?= $nextId; ?>" readonly>
            </div>
            <div class="mb-3">
                <label for="nama_vendor" class="form-label">Nama Vendor</label>
                <input type="text" class="form-control" id="nama_vendor" name="nama_vendor" placeholder="Karen Bau Kentut!!!">
            </div>
            <a href="karen.php" class="btn btn-secondary">Kembali</a>
            <button type="submit" class="btn btn-primary">Tambah</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
