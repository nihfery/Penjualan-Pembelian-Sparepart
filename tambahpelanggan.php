<?php
// Konfigurasi database
$host = 'localhost';
$username = 'root';
$password = ''; // Ganti sesuai password database kamu
$database = 'bengkelapasi'; // Ganti dengan nama database kamu

// Koneksi ke database
$conn = new mysqli($host, $username, $password, $database);

// Ambil id_member berikutnya
$sqlGetId = "SELECT MAX(id_member) AS max_id FROM member";
$result = $conn->query($sqlGetId);
$row = $result->fetch_assoc();
$nextId = $row['max_id'] + 1;

// Proses form ketika disubmit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama_member = $_POST['nama'];
    $conn->query("INSERT INTO member (id_member, nama) VALUES ('$nextId', '$nama_member')");
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Pelanggan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Tambah Pelanggan</h1>

        <form method="POST" action="">
            <div class="mb-3">
                <label for="id_member" class="form-label">ID Pelanggan</label>
                <input type="text" class="form-control" id="id_member" name="id_member" value="<?= $nextId; ?>" readonly>
            </div>
            <div class="mb-3">
                <label for="nama" class="form-label">Nama Pelanggan</label>
                <input type="text" class="form-control" id="nama" name="nama" placeholder="Masukkan nama pelanggan">
            </div>
            <button type="submit" class="btn btn-primary">Tambah</button>
            <a href="dashboard.php" class="btn btn-secondary">Kembali</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
