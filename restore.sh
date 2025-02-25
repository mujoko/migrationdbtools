#!/bin/bash

# Direktori yang berisi file SQL
directory="/home/ubuntu/result"

# Username dan password untuk koneksi MySQL
db_user="root"
db_host="rds.amazonaws.com"
db_pass="86A1"

# Loop melalui setiap file SQL di direktori
for file in "$directory"/*.sql
do
  # Dapatkan nama database dari nama file (misalnya, "database_name.sql")
  db_name="bitwyre"

  # Buat database jika belum ada
  mysql -u "$db_user" -p"$db_pass" -h "$db_host" -e "CREATE DATABASE IF NOT EXISTS \`$db_name\`"

  # Restore database dari file SQL
  mysql -u "$db_user" -p"$db_pass" -h "$db_host" "$db_name" < "$file"

  # Tampilkan pesan sukses
  echo "Database $db_name berhasil di-restore dari $file"
done

echo "Semua database telah di-restore."
