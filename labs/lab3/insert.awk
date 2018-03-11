function insert(db, columns, values){
  printf "INSERT INTO %s (%s) VALUES (%s);\n", db, columns, values
}
BEGIN{
  FS=","
  STDERR="/dev/stderr"
  db_regex="[[:alpha:]_@#][[:alnum:]_@#\\$]{0,50}"; db_pos=1; db_err=1
  col_pos=2; col_err=2
  val_regex="-?[[:digit:]]+$|\"[[:print:]]+\"" ;val_err=1
}
NR==db_pos {
  if (! match($0, "^"db_regex"$")){
    print "Error: Database name doesn't match a pattern" > STDERR
    exit db_err
  }
}
NR==col_pos {
  for(i = 1; i <= NF; i++) {
    if (! match($i, "^\""db_regex"\"$")){
      printf "Error: column %s doesn't match a pattern\n", $i > STDERR
      exit col_err
    }
  }
  gsub(/\,/,", ",$0);
  columns=$0
}
NR>2 {
  for(i = 1; i <= NF; i++) {
    if (! match($i, val_regex)){
      printf "Error: value %s in row %d doesn't match a pattern\n", $i, NR > STDERR
      exit val_err
    }
  }
  gsub(/\,/,", ",$0); insert(db, columns, $0)
}
