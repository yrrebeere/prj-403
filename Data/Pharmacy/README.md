# Pharmacy Dataset Update Glossary

| File | Description |
| ---- | ----------- |
| D1   | Combines monthly pharmacy data from CSV files into a single DataFrame and saves it as `D1.csv` |
| D2   | Reads `D1.csv`, performs analysis (correlation), drops irrelevant columns, and saves the refined data as `D2.csv` |
| D3   | Streamlines date-related columns by splitting them into distinct attributes (date and time), eliminating redundant data columns. Optimizes column order for enhanced dataset clarity, placing the label (`looseqty`) at the end, yielding `D3.csv` |
| D4   | Reads `D3.csv`, converts the 'date' column to datetime format, aggregates sales data based on 'date' and 'itemname,' and saves the combined data as `D4.csv` |
| D5   | Reads `D4.csv`, filters the data for 'itemname' equal to 'PANADOL TAB,' and saves the filtered data as `D5.csv` |
