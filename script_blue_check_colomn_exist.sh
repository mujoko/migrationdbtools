#!/bin/bash

# Nama file yang berisi daftar tabel
file_tabel="list-tables.txt"

# Nama database MySQL
database="xxxx"

# Koneksi ke MySQL
mysql_user="root"
mysql_password="8xxxxx"
mysql_host="xxxxxxx.rds.amazonaws.com"
# Membaca setiap baris dari file
while IFS= read -r table; do
    # Memeriksa apakah kolom created_at dan updated_at ada di tabel
    created_at_exists=$(mysql -u "$mysql_user" -p"$mysql_password" -h "$mysql_host" -D "$database" -s -N -e "SHOW COLUMNS FROM $table LIKE 'created_at';")
    updated_at_exists=$(mysql -u "$mysql_user" -p"$mysql_password" -h "$mysql_host" -D "$database" -s -N -e "SHOW COLUMNS FROM $table LIKE 'updated_at';")

    if [[ -n "$created_at_exists" && -n "$updated_at_exists" ]]; then
        echo "Tabel '$table' memiliki kolom 'created_at' dan 'updated_at'."
    else
        echo "$table" >> blue-list-tables-exclude.txt
    fi
done < "$file_tabel"
~
~
~
~
~
~
