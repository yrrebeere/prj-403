# Pharmacy Dataset Update Glossary

| File | Description |
| ---- | ----------- |
| C1   | Combines monthly pharmacy data from multiple CSV files into a single DataFrame and saves it as `C1.csv` |
| C2   | Reads `C1.csv`, performs analysis (correlation), drops irrelevant columns, and saves the refined data as `C2.csv` |
| C3   | Streamlines date-related columns by splitting them into distinct attributes (date and time), eliminating redundant data columns. Optimises column order for enhanced clarity, placing the label (`looseqty`) at the end, yielding `C3.csv` |
