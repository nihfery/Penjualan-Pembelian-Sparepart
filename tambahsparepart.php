<?php
// Koneksi ke database
$mysqli = new mysqli("localhost", "root", "", "bengkelapasi");
if ($mysqli->connect_error) {
    die("Koneksi gagal: " . $mysqli->connect_error);
}

// Ambil ID terakhir dari tabel sparepart
$result = $mysqli->query("SELECT IFNULL(MAX(id_sparepart), 0) AS last_id FROM sparepart");
$last_id = ($result && $row = $result->fetch_assoc()) ? (int)$row['last_id'] : 0;
$next_id = $last_id + 1;

// Ambil data kategori
$kategori_result = $mysqli->query("SELECT id_kategori, nama_kategori FROM kategori_sparepart");

// Proses penambahan sparepart
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['tambah_sparepart'])) {
    $id_sparepart = $_POST['id_sparepart'];
    $nama_sparepart = $_POST['nama_sparepart'];
    $id_kategori = $_POST['id_kategori'];  // id_kategori yang dipilih oleh pengguna

    // Validasi input
    if (!empty($id_sparepart) && !empty($nama_sparepart) && !empty($id_kategori)) {
        // Validasi apakah id_kategori yang dipilih ada di tabel kategori_sparepart
        $kategori_check = $mysqli->prepare("SELECT id_kategori FROM kategori_sparepart WHERE id_kategori = ?");
        $kategori_check->bind_param("s", $id_kategori); // Gunakan tipe string untuk varchar
        $kategori_check->execute();
        $kategori_check->bind_result($found_id_kategori);
        $kategori_check->fetch();
        $kategori_check->close();

        if (!$found_id_kategori) {
            echo "<script>alert('Kategori tidak valid!');</script>";
        } else {
            // Menyimpan sparepart ke dalam database
            $stmt = $mysqli->prepare("INSERT INTO sparepart (id_sparepart, nama_sparepart, harga, stok, id_kategori) VALUES (?, ?, 0, 0, ?)");
            $stmt->bind_param("iss", $id_sparepart, $nama_sparepart, $id_kategori); // Bind tipe string untuk id_kategori

            try {
                if ($stmt->execute()) {
                    echo "<script>alert('Sparepart berhasil ditambahkan!');</script>";
                } else {
                    throw new Exception($stmt->error);
                }
            } catch (Exception $e) {
                echo "<script>alert('Gagal menambahkan sparepart: " . $e->getMessage() . "');</script>";
            }
        }
    } else {
        echo "<script>alert('Semua kolom wajib diisi!');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Tambah Sparepart</h1>
        <form method="POST" action="">
            <div class="mb-3">
                <label for="id_kategori" class="form-label">Kategori Sparepart</label>
                <select class="form-control" id="id_kategori" name="id_kategori" required>
                    <option value="">-- Pilih Kategori --</option>
                    <?php while ($row = $kategori_result->fetch_assoc()): ?>
                        <option value="<?= $row['id_kategori'] ?>"><?= $row['nama_kategori'] ?></option>
                    <?php endwhile; ?>
                </select>
            </div>
            <div class="mb-3">
                <label for="id_sparepart" class="form-label">ID Sparepart</label>
                <input type="number" class="form-control" id="id_sparepart" name="id_sparepart" value="<?= $next_id ?>" readonly>
            </div>
            <div class="mb-3">
                <label for="nama_sparepart" class="form-label">Nama Sparepart</label>
                <input type="text" class="form-control" id="nama_sparepart" name="nama_sparepart" required>
            </div>
            <button type="submit" name="tambah_sparepart" class="btn btn-primary">Tambah Sparepart</button>
            <a href="karen.php" class="btn btn-secondary">Kembali</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
