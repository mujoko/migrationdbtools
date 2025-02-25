#!/bin/bash

# Informasi koneksi database GCP
db1_host="d5"
db1_user="f"
db1_pass="xfn"
db1_name="f"

# Informasi koneksi database AWS
db2_host="bwfrds.amazonaws.com"
db2_user="root"
db2_pass="8f"
db2_name="t"

# Fungsi untuk mendapatkan daftar tabel dari database
get_tables() {
  mysql -h "$1" -u "$2" -p"$3" -D "$4" -sN -e "SHOW TABLES"
}

# Fungsi untuk mendapatkan jumlah kolom dari tabel
#get_column_count() {
#  mysql -h "$1" -u "$2" -p"$3" -D "$4" -sN -e "SELECT COUNT(*) FROM information_schema.columns WHERE table_name = '$5'"
#}

# Fungsi untuk mendapatkan jumlah data dari tabel
get_row_count() {
  mysql -h "$1" -u "$2" -p"$3" -D "$4" -sN -e "SELECT COUNT(*) FROM \`$5\`"
}

# Dapatkan daftar tabel dari kedua database
tables_db1=$(get_tables "$db1_host" "$db1_user" "$db1_pass" "$db1_name")
tables_db2=$(get_tables "$db2_host" "$db2_user" "$db2_pass" "$db2_name")

date
# Loop melalui tabel di database 1
for table in $tables_db1; do
  # Dapatkan jumlah kolom dan data dari database 1
  row_count_db1=$(get_row_count "$db1_host" "$db1_user" "$db1_pass" "$db1_name" "$table")

  # Periksa apakah tabel ada di database 2
  if echo "$tables_db2" | grep -q "^$table$"; then
    # Dapatkan jumlah kolom dan data dari database 2
    row_count_db2=$(get_row_count "$db2_host" "$db2_user" "$db2_pass" "$db2_name" "$table")

    # Bandingkan jumlah kolom dan data
    if [[ "$col_count_db1" == "$col_count_db2" && "$row_count_db1" == "$row_count_db2" ]]; then
      echo "Table $table: MATCH (Rows: $row_count_db1)"
    else
      echo "Table $table: MISMATCH (Rows: $row_count_db1 vs Rows: $row_count_db2)"
    fi
  else
    echo "Table $table: Not found in $db2_name"
  fi
done

# Periksa tabel yang hanya ada di database 2
for table in $tables_db2; do
  if ! echo "$tables_db1" | grep -q "^$table$"; then
    echo "Table $table: Not found in $db1_name"
  fi
done
date
