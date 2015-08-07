cat optd_por_public.csv | awk -F^ '$42~"C" {print $1"^"$7"^"$42"^"$43}' > citiesByNames.csv
