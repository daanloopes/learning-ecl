Layout := RECORD
    STRING pickup_dt;
    DECIMAL8_2 fare;
END;

ds := DATASET([{'2019-01-01 01:08:56', 25.10},
               {'2019-01-01 02:10:22', 40.15}], Layout);

sumVal := SUM(ds, ds.fare);
avgVal := AVE(ds, ds.fare);
minVal := MIN(ds, ds.fare);
maxVal := MAX(ds, ds.fare);
countVal := COUNT(ds);

OUTPUT(DATASET([{'sum',sumVal}, 
                {'avg',avgVal}, 
                {'min', minVal}, 
                {'max', maxVal}, 
                {'count', countVal}], 
{STRING typ, DECIMAL8_2 val}));