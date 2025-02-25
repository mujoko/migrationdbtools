#!/bin/bash

# Nama file yang berisi daftar tabel
file_tabel="blue-list-tables-include.txt"

# Nama database MySQL
database="cxxx"

# Koneksi ke MySQL
mysql_user="root"
mysql_password="ddddd"
mysql_host="ddddddrds.amazonaws.com"
# Membaca setiap baris dari file
while IFS= read -r table; do
    # Memeriksa nilai default untuk kolom created_at
    default_created_at=$(mysql -u "$mysql_user" -p"$mysql_password" -h "$mysql_host" -D "$database" -s -N -e "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$table' AND COLUMN_NAME = 'created_at';")

    # Memeriksa nilai default untuk kolom updated_at
    default_updated_at=$(mysql -u "$mysql_user" -p"$mysql_password" -h "$mysql_host" -D "$database" -s -N -e "SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$table' AND COLUMN_NAME = 'updated_at';")

    # Menampilkan hasil pemeriksaan
    if [[ "$default_created_at" != *"COLUMN_DEFAULT"* ]]; then
        echo "Tabel '$table': Kolom 'created_at' memiliki nilai default: $default_created_at"
    else
        echo "Tabel '$table': Kolom 'created_at' tidak ada."
    fi

    if [[ "$default_updated_at" != *"COLUMN_DEFAULT"* ]]; then
        echo "Tabel '$table': Kolom 'updated_at' memiliki nilai default: $default_updated_at"
    else
        echo "Tabel '$table': Kolom 'updated_at' tidak ada."
    fi

done < "$file_tabel"
