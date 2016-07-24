transfer_windows = [
  [ 12,383,0,"2014-08-14 22:00" ],
  [ 12,389,1,"2014-10-01 22:00" ],
  [ 12,396,2,"2014-12-04 22:00" ],
  [ 12,406,3,"2015-02-04 22:00" ],
  [ 12,413,4,"2015-03-29 22:00" ],
  [ 13,421,0,"2015-08-06 22:00" ],
  [ 13,428,1,"2015-10-01 22:00" ],
  [ 13,434,2,"2015-12-02 22:00" ],
  [ 13,446,3,"2016-02-11 22:00" ],
  [ 13,452,4,"2016-04-06 22:00" ]
]

puts("Seeding transfer windows...")

transfer_windows.each do |season_id, d11_match_day_id, transfer_window_number, datetime|
  TransferWindow.create(season_id: season_id, d11_match_day_id: d11_match_day_id - 1, transfer_window_number: transfer_window_number, datetime: datetime, status: :finished)
end

transfer_days = [
  [ 50,1,"2014-08-14 22:00" ],
  [ 51,1,"2014-10-01 22:00" ],
  [ 51,2,"2014-10-02 22:00" ],
  [ 52,1,"2014-12-04 22:00" ],
  [ 52,2,"2014-12-05 22:00" ],
  [ 52,3,"2014-12-06 22:00" ],
  [ 52,4,"2014-12-07 22:00" ],
  [ 53,1,"2015-02-04 22:00" ],
  [ 53,2,"2015-02-05 22:00" ],
  [ 54,1,"2015-03-29 22:00" ],
  [ 54,2,"2015-03-30 22:00" ],  
  [ 55,1,"2015-08-06 22:00" ],
  [ 56,1,"2015-10-01 22:00" ],
  [ 56,2,"2015-10-02 22:00" ],
  [ 56,3,"2015-10-03 22:00" ],
  [ 57,1,"2015-12-02 22:00" ],
  [ 57,2,"2015-12-03 22:00" ],
  [ 58,1,"2016-02-11 22:00" ],
  [ 58,2,"2016-02-12 22:00" ],
  [ 58,3,"2016-02-13 22:00" ],
  [ 59,1,"2016-04-06 22:00" ],
  [ 59,2,"2016-04-07 22:00" ]
]

puts("Seeding transfer day...")

transfer_days.each do |transfer_window_id, transfer_day_number, datetime|
  TransferDay.create(transfer_window_id: transfer_window_id, transfer_day_number: transfer_day_number, status: 2, datetime: datetime)
end

transfers = [
  [50,129,34,75],
  [50,1007,41,180],
  [50,624,4,175],
  [50,2709,7,185],
  [50,2705,48,150],
  [50,2472,12,120],
  [50,2189,42,155],
  [50,2290,48,170],
  [50,2284,24,155],
  [50,1453,43,120],
  [50,1989,18,120],
  [50,2167,3,160],
  [50,1040,48,5],
  [50,1369,31,95],
  [50,2197,2,125],
  [50,2274,12,170],
  [50,1526,18,165],
  [50,1103,29,150],
  [50,1509,45,5],
  [50,1015,29,50],
  [50,2418,43,75],
  [50,2742,43,20],
  [50,1731,16,60],
  [50,2706,13,65],
  [50,1963,4,140],
  [50,1958,2,130],
  [50,1619,3,100],
  [50,2628,33,140],
  [50,2528,31,85],
  [50,1645,2,85],
  [50,2215,31,80],
  [50,1271,3,85],
  [50,2385,16,55],
  [50,2388,42,70],
  [50,2716,33,90],
  [50,2587,32,125],
  [50,135,29,35],
  [50,1650,18,50],
  [50,2337,34,50],
  [50,871,37,70],
  [50,2615,34,85],
  [50,2048,45,60],
  [50,1285,41,60],
  [50,2461,43,40],
  [50,2150,32,90],
  [50,2620,32,110],
  [50,2376,29,80],
  [50,2510,48,45],
  [50,1336,13,85],
  [50,2020,13,85],
  [50,1598,37,70],
  [50,1337,37,145],
  [50,2712,2,25],
  [50,2283,42,30],
  [50,2346,31,60],
  [50,2248,16,80],
  [50,2715,45,120],
  [50,1709,33,50],
  [50,1860,34,50],
  [50,2708,2,55],
  [50,2397,24,45],
  [50,2765,33,45],
  [50,1698,4,55],
  [50,2503,24,20],
  [50,1740,32,15],
  [50,2779,7,50],
  [50,2619,43,75],
  [50,2420,16,15],
  [50,1911,13,50],
  [50,1199,37,100],
  [50,1174,37,25],
  [50,2171,34,25],
  [50,2309,13,40],
  [50,789,16,25],
  [50,1960,24,65],
  [50,1818,31,65],
  [50,1481,45,90],
  [50,2622,16,45],
  [50,1869,43,45],
  [50,1552,7,50],
  [50,1456,3,25],
  [50,2454,24,85],
  [50,2768,34,35],
  [50,2531,32,15],
  [50,1447,34,50],
  [50,1485,31,20],
  [50,2730,41,50],
  [50,2763,13,85],
  [50,1541,33,40],
  [50,2172,48,25],
  [50,1914,32,50],
  [50,2305,16,35],
  [50,1381,3,5],
  [50,2727,33,30],
  [50,2152,31,25],
  [50,622,29,25],
  [50,1530,4,35],
  [50,84,32,30],
  [50,2383,4,50],
  [50,2434,41,5],
  [50,1483,16,15],
  [50,1450,24,65],
  [50,900,42,25],
  [50,2711,32,5],
  [50,2719,12,45],
  [50,2562,7,15],
  [50,253,43,30],
  [50,2129,13,15],
  [50,1969,34,45],
  [50,2520,37,30],
  [50,1971,7,15],
  [50,2399,37,15],
  [50,1484,45,20],
  [50,2764,33,50],
  [50,2734,43,50],
  [50,2338,29,45],
  [50,1718,34,30],
  [50,2419,42,5],
  [50,1182,16,45],
  [50,2480,37,25],
  [50,2750,16,5],
  [50,1402,3,60],
  [50,778,45,10],
  [50,2629,13,35],
  [50,2521,48,45],
  [50,1834,18,5],
  [50,551,43,5],
  [50,1508,18,70],
  [50,919,34,15],
  [50,2291,37,5],
  [50,1245,48,5],
  [50,2541,32,15],
  [50,2506,3,5],
  [50,2026,45,20],
  [50,2572,31,35],
  [50,2326,29,25],
  [50,1543,45,40],
  [50,2713,12,10],
  [50,2670,3,25],
  [50,782,41,5],
  [50,1018,7,35],
  [50,2325,7,30],
  [50,1548,45,10],
  [50,1446,18,45],
  [50,2752,18,15],
  [50,1281,48,15],
  [50,1807,13,15],
  [50,2720,24,45],
  [50,2421,29,10],
  [50,272,48,5],
  [50,1642,4,5],
  [50,1147,3,5],
  [50,2466,33,30],
  [50,1747,7,30],
  [50,1489,29,25],
  [50,1444,45,15],
  [50,2330,42,30],
  [50,952,24,5],
  [50,1806,45,50],
  [50,2599,34,10],
  [50,2132,12,5],
  [50,2134,41,35],
  [50,521,41,40],
  [50,1945,41,20],
  [50,2348,43,20],
  [50,1185,43,20],
  [50,1332,37,5],
  [50,948,42,30],
  [50,1810,4,5],
  [50,1095,3,5],
  [50,1142,33,5],
  [50,1683,31,5],
  [50,2066,12,40],
  [50,2630,12,40],
  [50,2343,31,10],
  [50,2464,41,20],
  [50,2767,41,60],
  [50,2590,48,10],
  [50,2570,32,5],
  [50,2585,12,55],
  [50,2774,18,15],
  [50,2778,2,45],
  [50,2165,42,20],
  [50,2084,48,15],
  [50,1825,32,25],
  [50,1761,3,20],
  [50,1676,33,15],
  [50,2321,31,5],
  [50,1997,29,5],
  [50,2058,42,5],
  [50,1753,7,20],
  [50,2769,41,5],
  [50,2749,7,5],
  [50,1424,2,5],
  [50,1668,18,5],
  [50,2258,13,5],
  [50,2130,2,10],
  [50,2760,4,5],
  [50,2015,29,5],
  [50,2584,42,5],
  [50,485,24,5],
  [50,2723,7,5],
  [50,1426,12,5],
  [50,2592,2,5],
  [50,2762,18,5],
  [50,2659,13,5],
  [50,1845,37,5],
  [50,2139,4,5],
  [50,1772,24,5],
  [50,2083,12,5],
  [50,2756,2,10],
  [50,1074,18,5],
  [50,1392,4,5],
  [50,1882,2,5],
  [50,2155,4,5],
  [50,2722,16,15],
  [50,1957,12,5],
  [50,312,42,110],
  [50,1801,33,5],
  [50,1796,24,5],
  [51,1,24,0],
  [51,1,41,0],
  [51,1,34,0],
  [51,1,48,0],
  [51,1,37,0],
  [51,1,31,0],
  [51,1,3,0],
  [51,1,12,0],
  [51,1,24,0],
  [51,1,43,0],
  [51,1,16,0],
  [51,1,45,0],
  [51,1,4,0],
  [51,1,45,0],
  [51,1,31,0],
  [51,1,34,0],
  [51,1,7,0],
  [51,1,3,0],
  [51,1,24,0],
  [51,1,24,0],
  [51,1,13,0],
  [51,1,32,0],
  [51,1,13,0],
  [51,1,12,0],
  [51,1,24,0],
  [51,1,42,0],
  [51,1,12,0],
  [51,1,32,0],
  [51,1,31,0],
  [51,1,42,0],
  [51,1,34,0],
  [51,1,42,0],
  [51,1,24,0],
  [51,1,16,0],
  [51,1,31,0],
  [51,1,43,0],
  [51,1,4,0],
  [51,1,42,0],
  [51,1,42,0],
  [51,1,41,0],
  [51,1,24,0],
  [51,1,43,0],
  [51,1,12,0],
  [51,1,24,0],
  [51,1,3,0],
  [51,1,32,0],
  [51,1,32,0],
  [51,1,31,0],
  [51,1,42,0],
  [51,1,32,0],
  [51,1,48,0],
  [51,1,34,0],
  [51,1,12,0],
  [51,1,13,0],
  [51,1,32,0],
  [51,1,12,0],
  [51,1,33,0],
  [51,1,16,0],
  [51,1,43,0],
  [51,1,16,0],
  [51,1,13,0],
  [51,1,33,0],
  [51,1,41,0],
  [51,1,34,0],
  [51,1,41,0],
  [51,2564,43,140],
  [51,2595,34,95],
  [51,2312,43,70],
  [51,2796,24,165],
  [51,616,45,55],
  [51,1702,32,85],
  [51,2771,42,15],
  [51,1985,31,35],
  [51,2188,34,15],
  [51,1580,32,15],
  [51,2804,33,50],
  [51,1453,32,125],
  [51,2794,32,45],
  [51,1001,13,35],
  [51,2529,13,5],
  [51,626,16,20],
  [51,2726,31,10],
  [51,1734,34,20],
  [51,1681,45,25],
  [51,2743,31,10],
  [51,1568,16,15],
  [51,1535,48,20],
  [51,2654,43,15],
  [51,1133,41,5],
  [51,1378,42,5],
  [51,1992,41,10],
  [51,1960,13,75],
  [51,1749,13,10],
  [51,2729,31,10],
  [51,2092,12,5],
  [51,2261,43,5],
  [51,1898,33,30],
  [51,2732,12,5],
  [51,1343,41,15],
  [51,1304,16,10],
  [51,2728,42,5],
  [51,2606,24,5],
  [51,1531,4,25],
  [51,2798,42,5],
  [51,1549,16,5],
  [51,1622,48,5],
  [51,2806,12,150],
  [51,2388,24,30],
  [51,2461,34,5],
  [51,2787,24,20],
  [51,2012,42,5],
  [51,2807,24,10],
  [51,2284,34,5],
  [51,2150,42,35],
  [51,2764,32,5],
  [51,1450,12,5],
  [51,2805,24,5],
  [51,2802,7,30],
  [51,2584,41,5],
  [51,1369,12,5],
  [51,2792,24,15],
  [51,1993,24,5],
  [51,2472,4,20],
  [51,2791,37,10],
  [51,2783,32,5],
  [52,1215,31,30],
  [52,1307,3,5],
  [52,2398,12,5],
  [52,1825,3,5],
  [52,2616,3,5],
  [53,1,43,0],
  [53,1,48,0],
  [53,1,45,0],
  [53,1,24,0],
  [53,1,13,0],
  [53,1,7,0],
  [53,1,3,0],
  [53,1,41,0],
  [53,1,16,0],
  [53,1,16,0],
  [53,1,13,0],
  [53,1,41,0],
  [53,1,42,0],
  [53,1,4,0],
  [53,1,34,0],
  [53,1,31,0],
  [53,1,4,0],
  [53,1,48,0],
  [53,1,16,0],
  [53,1,48,0],
  [53,1,33,0],
  [53,1,34,0],
  [53,1,7,0],
  [53,1,33,0],
  [53,1,45,0],
  [53,1,4,0],
  [53,1,34,0],
  [53,1,32,0],
  [53,1,13,0],
  [53,1,34,0],
  [53,1,31,0],
  [53,1,41,0],
  [53,1,24,0],
  [53,1,42,0],
  [53,1,12,0],
  [53,1,4,0],
  [53,1,31,0],
  [53,1,16,0],
  [53,1,34,0],
  [53,1,41,0],
  [53,1,48,0],
  [53,1,34,0],
  [53,1,24,0],
  [53,1,34,0],
  [53,1,3,0],
  [53,1,33,0],
  [53,1,13,0],
  [53,1,43,0],
  [53,1,3,0],
  [53,1,2,0],
  [53,1,2,0],
  [53,1,42,0],
  [53,1,12,0],
  [53,1,31,0],
  [53,1,32,0],
  [53,1,42,0],
  [53,1,7,0],
  [53,1,32,0],
  [53,1,24,0],
  [53,1,42,0],
  [53,1,33,0],
  [53,1,12,0],
  [53,2587,13,200],
  [53,2595,2,55],
  [53,2610,12,70],
  [53,1761,3,45],
  [53,2724,31,35],
  [53,2527,16,40],
  [53,1985,16,10],
  [53,2616,48,5],
  [53,2477,45,30],
  [53,2734,4,35],
  [53,1800,12,5],
  [53,1804,4,10],
  [53,2234,12,105],
  [53,1574,16,10],
  [53,1483,41,45],
  [53,798,48,5],
  [53,2612,16,20],
  [53,1535,34,5],
  [53,2768,31,5],
  [53,1378,34,5],
  [53,2615,34,10],
  [53,1960,7,60],
  [53,2771,34,5],
  [53,2628,24,95],
  [53,2623,34,5],
  [53,1693,2,5],
  [53,1040,24,5],
  [53,2806,41,75],
  [53,1238,34,5],
  [53,2165,48,15],
  [53,2461,45,5],
  [53,2711,31,5],
  [53,1736,48,5],
  [53,2820,32,5],
  [53,2599,32,5],
  [53,2787,4,5],
  [53,1447,41,5],
  [53,2431,13,5],
  [53,2663,4,5],
  [53,1047,7,25],
  [53,2581,13,5],
  [53,2171,24,10],
  [53,1531,24,5],
  [53,1718,41,5],
  [53,1018,34,5],
  [53,2716,7,5],
  [53,2779,32,5],
  [53,1807,13,5],
  [54,1959,43,10],
  [54,1436,3,5],
  [54,2467,43,5],
  [54,1095,3,5],
  [55,2152,31,5],
  [55,1182,42,5],
  [55,1336,42,5],
  [55,2510,42,5],
  [55,1992,42,5],
  [55,1860,42,5],
  [56,1657,33,5],
  [56,2763,33,5],
  [56,1676,33,5],
  [56,2797,33,5],
  [57,1,32,0],
  [57,1,42,0],
  [57,1,16,0],
  [57,1,48,0],
  [57,1,24,0],
  [57,1,7,0],
  [57,1,31,0],
  [57,1,34,0],
  [57,1,3,0],
  [57,1,42,0],
  [57,1,34,0],
  [57,1,2,0],
  [57,1,12,0],
  [57,1,32,0],
  [57,1,45,0],
  [57,1,24,0],
  [57,1,34,0],
  [57,1,45,0],
  [57,1,16,0],
  [57,1,32,0],
  [57,1,2,0],
  [57,1,41,0],
  [57,1,16,0],
  [57,1,48,0],
  [57,1,13,0],
  [57,1,12,0],
  [57,1,4,0],
  [57,1,41,0],
  [57,1,7,0],
  [57,1,16,0],
  [57,1,42,0],
  [57,1,45,0],
  [57,1,34,0],
  [57,1,13,0],
  [57,1,43,0],
  [57,1,7,0],
  [57,1,31,0],
  [57,1,45,0],
  [57,1,42,0],
  [57,1,32,0],
  [57,1,13,0],
  [57,1,41,0],
  [57,1,32,0],
  [57,1,12,0],
  [57,1,48,0],
  [57,1,43,0],
  [57,1,34,0],
  [57,1,45,0],
  [57,1,7,0],
  [57,1,31,0],
  [57,1,34,0],
  [57,1,2,0],
  [57,1,32,0],
  [57,1,32,0],
  [57,1,32,0],
  [57,747,31,35],
  [57,2312,48,25],
  [57,2794,16,10],
  [57,2717,45,15],
  [57,2089,13,5],
  [57,616,45,5],
  [57,2619,34,35],
  [57,312,42,35],
  [57,2066,2,35],
  [57,2572,42,10],
  [57,2343,4,40],
  [57,1971,41,5],
  [57,1453,32,105],
  [57,1800,12,5],
  [57,1967,31,10],
  [57,1801,34,25],
  [57,2715,45,10],
  [57,2531,7,10],
  [57,2464,31,35],
  [57,2325,34,5],
  [57,2610,34,5],
  [57,2732,2,5],
  [57,1945,45,5],
  [57,1450,7,35],
  [57,2674,3,5],
  [57,1040,34,5],
  [57,2712,32,10],
  [57,2837,42,130],
  [57,1914,13,20],
  [57,2630,12,85],
  [57,2407,2,5],
  [57,1424,41,5],
  [57,2686,16,80],
  [57,1047,16,5],
  [57,2779,24,5],
  [57,495,32,45],
  [57,919,34,5],
  [57,1969,45,5],
  [57,2838,32,5],
  [57,2840,16,55],
  [57,2849,32,45],
  [57,2851,32,5],
  [57,2848,42,15],
  [57,1765,24,15],
  [57,2843,32,5],
  [57,2841,7,5],
  [57,2704,7,40],
  [57,2707,12,5],
  [57,2839,41,5],
  [57,1806,32,5],
  [58,2583,43,5],
  [58,1001,48,5],
  [58,2348,13,5],
  [58,2623,43,5],
  [58,2820,48,5],
  [59,1,42,0],
  [59,1,32,0],
  [59,1,41,0],
  [59,1,34,0],
  [59,1,34,0],
  [59,1,48,0],
  [59,1,48,0],
  [59,1,41,0],
  [59,1,4,0],
  [59,1,32,0],
  [59,1,24,0],
  [59,1,45,0],
  [59,1,12,0],
  [59,1,2,0],
  [59,1,4,0],
  [59,1,48,0],
  [59,1,16,0],
  [59,1,43,0],
  [59,1,2,0],
  [59,1,43,0],
  [59,1,16,0],
  [59,1,43,0],
  [59,1,42,0],
  [59,1,34,0],
  [59,1,16,0],
  [59,1,43,0],
  [59,1,32,0],
  [59,1,7,0],
  [59,1,45,0],
  [59,1,42,0],
  [59,1,32,0],
  [59,1,41,0],
  [59,1,16,0],
  [59,1,7,0],
  [59,1,42,0],
  [59,2248,42,10],
  [59,2261,42,10],
  [59,2564,7,5],
  [59,2188,2,20],
  [59,1736,2,20],
  [59,1718,32,195],
  [59,2572,34,5],
  [59,2523,16,105],
  [59,2048,24,55],
  [59,2172,42,10],
  [59,1804,41,85],
  [59,1238,16,10],
  [59,2009,42,20],
  [59,2722,7,5],
  [59,1392,45,5],
  [59,1900,34,5],
  [59,1113,32,5],
  [59,2143,12,10],
  [59,2714,45,5],
  [59,489,4,5],
  [59,1831,34,5],
  [59,2461,43,10],
  [59,1810,16,55],
  [59,2026,16,5],
  [59,2385,4,5],
  [59,565,48,5],
  [59,1223,41,10],
  [60,2798,43,5],
  [60,2743,32,5],
  [60,1580,43,5],
  [60,1281,48,5],
  [60,2771,43,5],
  [60,919,48,5],
  [60,1634,41,5],
  [60,952,32,5],
  [61,1958,2,110],
  [61,1018,2,5],
  [61,495,2,5],
  [61,1199,2,70],
  [61,2388,2,110],
  [61,2397,2,60],
  [61,1882,2,40],
  [61,2913,2,5],
  [61,1926,2,15],
  [61,2066,2,5],
  [61,129,2,75],
  [61,1736,3,45],
  [61,1548,3,45],
  [61,2555,3,45],
  [61,2277,3,50],
  [61,1446,3,45],
  [61,2096,3,45],
  [61,2348,3,45],
  [61,1392,3,45],
  [61,2723,3,45],
  [61,1541,3,45],
  [61,1574,3,45],
  [61,1963,4,175],
  [61,1693,4,5],
  [61,2931,4,5],
  [61,1456,4,5],
  [61,948,4,5],
  [61,2960,4,5],
  [61,2587,4,20],
  [61,1271,4,70],
  [61,624,4,190],
  [61,2752,4,15],
  [61,2581,4,5],
  [61,622,7,10],
  [61,2514,7,10],
  [61,1960,7,75],
  [61,2945,7,95],
  [61,2129,7,15],
  [61,2151,7,80],
  [61,2189,7,90],
  [61,2946,7,35],
  [61,2954,7,45],
  [61,1826,7,40],
  [61,871,7,5],
  [61,2171,12,40],
  [61,2326,12,75],
  [61,2936,12,105],
  [61,2686,12,75],
  [61,2398,12,40],
  [61,489,12,5],
  [61,2980,12,5],
  [61,2707,12,45],
  [61,2734,12,5],
  [61,2715,12,55],
  [61,2690,12,10],
  [61,1740,13,70],
  [61,2234,13,195],
  [61,2084,13,50],
  [61,952,13,10],
  [61,2962,13,40],
  [61,2967,13,30],
  [61,2521,13,5],
  [61,2570,13,5],
  [61,1424,13,5],
  [61,1818,13,50],
  [61,2562,13,40],
  [61,2722,16,30],
  [61,1654,16,10],
  [61,1298,16,15],
  [61,2972,16,5],
  [61,2528,16,20],
  [61,2337,16,45],
  [61,2197,16,75],
  [61,2963,16,5],
  [61,2530,16,55],
  [61,2791,16,30],
  [61,2215,16,65],
  [61,2981,18,25],
  [61,1619,18,100],
  [61,1989,18,45],
  [61,2595,18,75],
  [61,2106,18,5],
  [61,2134,18,30],
  [61,1508,18,70],
  [61,2968,18,15],
  [61,2794,18,50],
  [61,2964,18,35],
  [61,1718,18,50],
  [61,2916,24,10],
  [61,2900,24,5],
  [61,1337,24,95],
  [61,2309,24,45],
  [61,1483,24,10],
  [61,2742,24,30],
  [61,2167,24,210],
  [61,2592,24,5],
  [61,2952,24,30],
  [61,1526,24,15],
  [61,2961,24,40],
  [61,2564,29,30],
  [61,2572,29,5],
  [61,2048,29,5],
  [61,1015,29,120],
  [61,1645,29,60],
  [61,1103,29,170],
  [61,2172,29,40],
  [61,789,29,5],
  [61,2807,29,55],
  [61,2629,29,5],
  [61,2771,29,5],
  [61,1806,31,20],
  [61,1481,31,100],
  [61,778,31,45],
  [61,2150,31,60],
  [61,2719,31,20],
  [61,2270,31,5],
  [61,1804,31,25],
  [61,2420,31,150],
  [61,2325,31,20],
  [61,2165,31,10],
  [61,2922,31,45],
  [61,2188,32,15],
  [61,2744,32,5],
  [61,1825,32,5],
  [61,2434,32,5],
  [61,2969,32,15],
  [61,2532,32,10],
  [61,2290,32,245],
  [61,1751,32,5],
  [61,2346,32,35],
  [61,2472,32,145],
  [61,2489,32,10],
  [61,2763,33,10],
  [61,1444,33,40],
  [61,2523,33,10],
  [61,2957,33,50],
  [61,2792,33,35],
  [61,2615,33,55],
  [61,2765,33,35],
  [61,2944,33,5],
  [61,2709,33,205],
  [61,2805,33,50],
  [61,2930,33,5],
  [61,1447,34,25],
  [61,2706,34,120],
  [61,2477,34,55],
  [61,1453,34,55],
  [61,2749,34,35],
  [61,1807,34,20],
  [61,2892,34,40],
  [61,2343,34,45],
  [61,2953,34,45],
  [61,2020,34,45],
  [61,2531,34,15],
  [61,1564,37,50],
  [61,2597,37,45],
  [61,2396,37,45],
  [61,1845,37,45],
  [61,1900,37,45],
  [61,272,37,45],
  [61,2743,37,45],
  [61,2918,37,45],
  [61,2606,37,45],
  [61,2844,37,45],
  [61,2467,37,45],
  [61,2779,41,15],
  [61,2132,41,10],
  [61,2274,41,130],
  [61,1650,41,60],
  [61,2730,41,20],
  [61,2982,41,10],
  [61,2184,41,5],
  [61,2802,41,70],
  [61,2720,41,80],
  [61,2248,41,65],
  [61,2724,41,35],
  [61,2338,42,5],
  [61,1765,42,35],
  [61,2418,42,55],
  [61,1552,42,20],
  [61,2376,42,60],
  [61,2399,42,15],
  [61,2977,42,65],
  [61,2620,42,90],
  [61,1402,42,50],
  [61,1860,42,10],
  [61,2330,42,50],
  [61,2312,43,65],
  [61,1709,43,30],
  [61,2619,43,30],
  [61,1530,43,5],
  [61,2934,43,50],
  [61,2480,43,35],
  [61,2975,43,5],
  [61,2454,43,10],
  [61,1801,43,20],
  [61,1869,43,45],
  [61,2705,43,205],
  [61,1969,45,75],
  [61,1598,45,10],
  [61,1945,45,20],
  [61,2461,45,15],
  [61,2622,45,45],
  [61,2787,45,15],
  [61,1369,45,90],
  [61,2768,45,35],
  [61,2938,45,120],
  [61,2630,45,20],
  [61,2261,45,40],
  [61,2983,48,15],
  [61,2716,48,5],
  [61,2284,48,140],
  [61,2520,48,5],
  [61,2628,48,170],
  [61,2933,48,15],
  [61,2806,48,45],
  [61,900,48,30],
  [61,1436,48,15],
  [61,1642,48,5],
  [61,2515,48,45],
  [62,1,2,0],
  [62,1,12,0],
  [62,1,2,0],
  [62,1,7,0],
  [62,1,48,0],
  [62,1,4,0],
  [62,1,13,0],
  [62,1,2,0],
  [62,1,29,0],
  [62,1,2,0],
  [62,1,3,0],
  [62,1,13,0],
  [62,1,34,0],
  [62,1,24,0],
  [62,1,3,0],
  [62,1,3,0],
  [62,1,45,0],
  [62,1,29,0],
  [62,1,4,0],
  [62,1,13,0],
  [62,1,32,0],
  [62,1,42,0],
  [62,1,37,0],
  [62,1,45,0],
  [62,1,29,0],
  [62,1,7,0],
  [62,1,24,0],
  [62,1,12,0],
  [62,1,41,0],
  [62,1,45,0],
  [62,1,32,0],
  [62,1,42,0],
  [62,1,34,0],
  [62,1,32,0],
  [62,1,12,0],
  [62,1,42,0],
  [62,1,43,0],
  [62,1,45,0],
  [62,1,32,0],
  [62,1,32,0],
  [62,1,16,0],
  [62,1,32,0],
  [62,1,13,0],
  [62,1,29,0],
  [62,1,13,0],
  [62,1,29,0],
  [62,1,37,0],
  [62,1,12,0],
  [62,1,34,0],
  [62,1,33,0],
  [62,1,12,0],
  [62,1,48,0],
  [62,1,41,0],
  [62,1,24,0],
  [62,1,32,0],
  [62,1,34,0],
  [62,1,33,0],
  [62,1,33,0],
  [62,1,48,0],
  [62,1,34,0],
  [62,1,24,0],
  [62,1,2,0],
  [62,1,24,0],
  [62,1,37,0],
  [62,1,31,0],
  [62,1,4,0],
  [62,1,48,0],
  [62,1,12,0],
  [62,1,33,0],
  [62,1,33,0],
  [62,1,24,0],
  [62,1,16,0],
  [62,1,13,0],
  [62,1,32,0],
  [62,1,16,0],
  [62,1,42,0],
  [62,1,12,0],
  [62,1,48,0],
  [62,1001,33,90],
  [62,2922,13,45],
  [62,2901,33,50],
  [62,2979,13,75],
  [62,565,13,25],
  [62,3015,34,240],
  [62,2104,12,50],
  [62,2726,12,45],
  [62,2291,45,50],
  [62,1971,33,60],
  [62,2290,24,175],
  [62,2288,32,170],
  [62,2997,29,140],
  [62,2914,37,15],
  [62,1987,12,30],
  [62,1215,45,40],
  [62,2391,31,45],
  [62,2143,3,30],
  [62,747,42,10],
  [62,2984,33,50],
  [62,1727,37,30],
  [62,2717,45,5],
  [62,2971,2,25],
  [62,2472,32,115],
  [62,2098,2,10],
  [62,3012,32,55],
  [62,2961,42,10],
  [62,1641,2,5],
  [62,495,29,5],
  [62,1486,3,5],
  [62,2915,29,10],
  [62,1103,16,105],
  [62,2305,32,25],
  [62,3009,2,15],
  [62,2167,12,135],
  [62,2026,29,5],
  [62,2892,16,5],
  [62,1489,41,20],
  [62,1113,32,10],
  [62,2989,32,15],
  [62,2709,42,120],
  [62,1898,32,5],
  [62,2843,48,30],
  [62,1737,24,5],
  [62,2715,45,5],
  [62,2936,12,5],
  [62,2343,24,5],
  [62,2806,29,10],
  [62,2988,32,5],
  [62,2998,13,5],
  [62,2449,16,5],
  [62,2991,3,5],
  [62,521,13,5],
  [62,1698,2,15],
  [62,2171,41,5],
  [62,2398,12,5],
  [62,1768,34,5],
  [62,1914,24,5],
  [62,2996,24,25],
  [62,1018,12,5],
  [62,1199,7,5],
  [62,1645,4,5],
  [62,129,48,5],
  [63,2912,7,10],
  [63,2422,48,10],
  [63,2937,34,5],
  [63,2261,37,30],
  [63,2431,34,5],
  [63,1751,34,5],
  [63,1765,24,10],
  [63,1657,42,5],
  [63,2572,33,5],
  [63,2562,48,5],
  [63,1483,13,5],
  [63,2742,4,5],
  [64,2958,4,5],
  [64,2921,43,5],
  [64,2749,48,5],
  [65,1,7,0],
  [65,1,33,0],
  [65,1,33,0],
  [65,1,34,0],
  [65,1,34,0],
  [65,1,34,0],
  [65,1,34,0],
  [65,1,34,0],
  [65,1,34,0],
  [65,1,37,0],
  [65,1,37,0],
  [65,1,37,0],
  [65,1,43,0],
  [65,1,41,0],
  [65,1,48,0],
  [65,1,48,0],
  [65,1,3,0],
  [65,1,3,0],
  [65,1,2,0],
  [65,1,2,0],
  [65,1,2,0],
  [65,1,16,0],
  [65,1,16,0],
  [65,1,16,0],
  [65,1,16,0],
  [65,1,24,0],
  [65,1,24,0],
  [65,1,24,0],
  [65,1,24,0],
  [65,1,48,0],
  [65,1,24,0],
  [65,1,24,0],
  [65,1,32,0],
  [65,1,32,0],
  [65,1,32,0],
  [65,1,24,0],
  [65,1,45,0],
  [65,1,45,0],
  [65,1,42,0],
  [65,1,42,0],
  [65,1,42,0],
  [65,1,42,0],
  [65,1,42,0],
  [65,1,4,0],
  [65,1,4,0],
  [65,1,4,0],
  [65,1,16,0],
  [65,1,12,0],
  [65,1,12,0],
  [65,1,12,0],
  [65,1,12,0],
  [65,1,13,0],
  [65,1,13,0],
  [65,1,13,0],
  [65,1,13,0],
  [65,1,13,0],
  [65,1,43,0],
  [65,1,7,0],
  [65,2945,12,5],
  [65,1996,12,115],
  [65,1761,37,35],
  [65,2717,33,5],
  [65,2974,34,20],
  [65,3015,42,120],
  [65,2290,4,185],
  [65,2728,13,145],
  [65,2726,7,60],
  [65,1967,42,15],
  [65,2722,3,20],
  [65,1747,16,15],
  [65,2838,48,60],
  [65,2969,24,5],
  [65,624,34,130],
  [65,2709,34,130],
  [65,2261,42,10],
  [65,2076,13,10],
  [65,1553,16,5],
  [65,2792,2,55],
  [65,2933,33,55],
  [65,2721,13,5],
  [65,1453,24,10],
  [65,2971,42,35],
  [65,1860,42,5],
  [65,1740,32,85],
  [65,3016,37,20],
  [65,2528,2,80],
  [65,2206,13,5],
  [65,1548,16,10],
  [65,2337,24,5],
  [65,1402,37,10],
  [65,1698,34,5],
  [65,1914,48,25],
  [65,2376,24,15],
  [65,272,7,25],
  [65,622,16,5],
  [65,1657,3,5],
  [65,2489,34,5],
  [65,1768,12,5],
  [65,952,2,5],
  [65,2991,16,5],
  [65,2706,24,80],
  [66,2900,43,5],
  [66,1722,48,5],
  [66,1869,34,5],
  [66,1392,45,5],
  [66,2952,4,5],
  [66,2445,24,10],
  [66,2190,45,5],
  [66,2152,4,5],
  [66,1450,13,5],
  [66,2880,32,5],
  [66,1462,24,5],
  [66,2592,43,5],
  [66,2980,12,5],
  [66,2207,32,5],
  [66,2812,41,5],
  [67,1,13,0],
  [67,1,33,0],
  [67,1,24,0],
  [67,1,4,0],
  [67,1,24,0],
  [67,1,16,0],
  [67,1,16,0],
  [67,1,3,0],
  [67,1,34,0],
  [67,1,3,0],
  [67,1,32,0],
  [67,1,37,0],
  [67,1,12,0],
  [67,1,7,0],
  [67,1,34,0],
  [67,1,2,0],
  [67,1,32,0],
  [67,1,12,0],
  [67,1,2,0],
  [67,1,3,0],
  [67,1,4,0],
  [67,1,41,0],
  [67,1,16,0],
  [67,1,13,0],
  [67,1,32,0],
  [67,1,16,0],
  [67,1,41,0],
  [67,1,3,0],
  [67,1,32,0],
  [67,1,24,0],
  [67,1,43,0],
  [67,1,2,0],
  [67,1,37,0],
  [67,1,32,0],
  [67,1,34,0],
  [67,1,48,0],
  [67,1,2,0],
  [67,1,24,0],
  [67,1,12,0],
  [67,1,33,0],
  [67,1,41,0],
  [67,1,13,0],
  [67,1,3,0],
  [67,1,3,0],
  [67,1,13,0],
  [67,1,48,0],
  [67,1,29,0],
  [67,1,41,0],
  [67,1,32,0],
  [67,1,43,0],
  [67,1,45,0],
  [67,1,4,0],
  [67,1,24,0],
  [67,1,32,0],
  [67,1,16,0],
  [67,1,29,0],
  [67,1,2,0],
  [67,2288,12,10],
  [67,1996,45,95],
  [67,2472,2,185],
  [67,2951,2,50],
  [67,2720,4,5],
  [67,2274,32,125],
  [67,2104,29,50],
  [67,1642,12,10],
  [67,2466,37,25],
  [67,2197,34,5],
  [67,2727,41,155],
  [67,3010,37,5],
  [67,2173,32,5],
  [67,2997,34,5],
  [67,2365,32,150],
  [67,2952,4,5],
  [67,2245,24,115],
  [67,900,16,15],
  [67,3009,32,25],
  [67,2791,16,10],
  [67,2972,16,5],
  [67,2215,24,5],
  [67,919,3,5],
  [67,2305,13,25],
  [67,3040,3,145],
  [67,1740,41,5],
  [67,2312,13,5],
  [67,3027,32,5],
  [67,2207,41,10],
  [67,1768,3,15],
  [67,2434,4,10],
  [67,1702,24,150],
  [67,1526,24,55],
  [67,2756,16,105],
  [67,3053,7,5],
  [67,2506,3,5],
  [67,1911,33,5],
  [67,1765,24,5],
  [67,2706,32,35],
  [67,1698,34,5],
  [67,3056,2,5],
  [67,3062,32,10],
  [67,2130,2,5],
  [67,1245,48,50],
  [68,2717,33,5],
  [68,2969,3,10],
  [68,1826,41,5],
  [68,2917,16,5],
  [68,2015,3,30],
  [68,2291,29,10],
  [68,1337,13,5],
  [68,1511,43,5],
  [68,2988,48,5],
  [68,1336,2,5],
  [68,1653,13,5],
  [68,344,12,5],
  [69,1343,43,5],
  [70,1,24,0],
  [70,1,24,0],
  [70,1,7,0],
  [70,1,7,0],
  [70,1,24,0],
  [70,1,7,0],
  [70,1,7,0],
  [70,1,33,0],
  [70,1,33,0],
  [70,1,12,0],
  [70,1,12,0],
  [70,1,3,0],
  [70,1,3,0],
  [70,1,41,0],
  [70,1,41,0],
  [70,1,41,0],
  [70,1,7,0],
  [70,1,16,0],
  [70,1,16,0],
  [70,1,16,0],
  [70,1,16,0],
  [70,1,34,0],
  [70,1,34,0],
  [70,1,34,0],
  [70,1,2,0],
  [70,1,45,0],
  [70,1,45,0],
  [70,1,45,0],
  [70,1,12,0],
  [70,2709,7,155],
  [70,624,24,150],
  [70,2530,34,5],
  [70,2151,16,30],
  [70,2514,34,5],
  [70,2989,2,5],
  [70,2309,24,65],
  [70,2280,3,5],
  [70,2245,24,5],
  [70,2967,12,10],
  [70,871,41,5],
  [70,272,3,5],
  [70,3047,16,150],
  [70,2749,34,5],
  [70,3029,41,150],
  [70,2528,7,5],
  [70,2938,16,5],
  [70,3064,7,5],
  [70,2564,7,5],
  [70,1971,41,5],
  [70,1668,12,5],
  [70,3072,33,5],
  [70,2096,12,10],
  [70,3074,33,5],
  [70,1734,16,5],
  [70,2462,7,5],
  [71,2711,45,5],
  [71,2722,45,5],
  [71,948,45,5]
]

puts("Seeding transfers")

transfers.each do | transfer_day_id, player_id, d11_team_id, fee |
  Transfer.create(transfer_day_id: transfer_day_id, player_id: player_id, d11_team_id: d11_team_id, fee: fee)
end

Transfer.where(player_id: 1).each do |transfer|
  transfer.delete
end

sold_transfers = [
  [51,485],
  [51,521],
  [51,919],
  [51,1040],
  [51,1332],
  [51,1369],
  [51,1381],
  [51,1426],
  [51,1450],
  [51,1453],
  [51,1483],
  [51,1509],
  [51,1530],
  [51,1543],
  [51,1683],
  [51,1718],
  [51,1753],
  [51,1761],
  [51,1772],
  [51,1796],
  [51,1807],
  [51,1825],
  [51,1911],
  [51,1957],
  [51,1960],
  [51,2058],
  [51,2083],
  [51,2150],
  [51,2152],
  [51,2165],
  [51,2171],
  [51,2283],
  [51,2284],
  [51,2305],
  [51,2321],
  [51,2348],
  [51,2383],
  [51,2388],
  [51,2419],
  [51,2434],
  [51,2454],
  [51,2461],
  [51,2472],
  [51,2503],
  [51,2506],
  [51,2541],
  [51,2570],
  [51,2572],
  [51,2584],
  [51,2587],
  [51,2590],
  [51,2599],
  [51,2630],
  [51,2659],
  [51,2711],
  [51,2713],
  [51,2716],
  [51,2722],
  [51,2734],
  [51,2750],
  [51,2763],
  [51,2764],
  [51,2767],
  [51,2768],
  [51,2769],
  [53,253],
  [53,272],
  [53,616],
  [53,952],
  [53,1001],
  [53,1018],
  [53,1095],
  [53,1133],
  [53,1182],
  [53,1304],
  [53,1336],
  [53,1343],
  [53,1378],
  [53,1392],
  [53,1447],
  [53,1485],
  [53,1531],
  [53,1535],
  [53,1549],
  [53,1622],
  [53,1676],
  [53,1734],
  [53,1747],
  [53,1801],
  [53,1806],
  [53,1810],
  [53,1860],
  [53,1914],
  [53,1960],
  [53,1969],
  [53,1985],
  [53,1992],
  [53,1993],
  [53,2012],
  [53,2066],
  [53,2155],
  [53,2346],
  [53,2385],
  [53,2461],
  [53,2464],
  [53,2510],
  [53,2595],
  [53,2606],
  [53,2615],
  [53,2616],
  [53,2628],
  [53,2629],
  [53,2654],
  [53,2670],
  [53,2708],
  [53,2712],
  [53,2728],
  [53,2732],
  [53,2743],
  [53,2764],
  [53,2771],
  [53,2779],
  [53,2783],
  [53,2787],
  [53,2798],
  [53,2804],
  [53,2806],
  [57,84],
  [57,312],
  [57,789],
  [57,798],
  [57,1040],
  [57,1047],
  [57,1215],
  [57,1238],
  [57,1307],
  [57,1336],
  [57,1378],
  [57,1424],
  [57,1450],
  [57,1453],
  [57,1484],
  [57,1531],
  [57,1535],
  [57,1548],
  [57,1574],
  [57,1580],
  [57,1693],
  [57,1718],
  [57,1731],
  [57,1736],
  [57,1749],
  [57,1800],
  [57,1804],
  [57,1945],
  [57,1971],
  [57,1985],
  [57,1992],
  [57,2048],
  [57,2188],
  [57,2258],
  [57,2312],
  [57,2325],
  [57,2343],
  [57,2461],
  [57,2510],
  [57,2531],
  [57,2581],
  [57,2584],
  [57,2599],
  [57,2610],
  [57,2616],
  [57,2619],
  [57,2623],
  [57,2715],
  [57,2749],
  [57,2768],
  [57,2771],
  [57,2778],
  [57,2779],
  [57,2794],
  [57,2820],
  [59,312],
  [59,495],
  [59,782],
  [59,919],
  [59,1040],
  [59,1245],
  [59,1281],
  [59,1285],
  [59,1642],
  [59,1702],
  [59,1765],
  [59,2026],
  [59,2092],
  [59,2130],
  [59,2139],
  [59,2172],
  [59,2248],
  [59,2261],
  [59,2407],
  [59,2467],
  [59,2527],
  [59,2564],
  [59,2572],
  [59,2610],
  [59,2612],
  [59,2623],
  [59,2712],
  [59,2716],
  [59,2717],
  [59,2837],
  [59,2838],
  [59,2839],
  [59,2840],
  [59,2841],
  [59,2848],
  [62,129],
  [62,489],
  [62,495],
  [62,622],
  [62,900],
  [62,948],
  [62,952],
  [62,1018],
  [62,1103],
  [62,1199],
  [62,1392],
  [62,1424],
  [62,1447],
  [62,1483],
  [62,1548],
  [62,1574],
  [62,1598],
  [62,1645],
  [62,1693],
  [62,1740],
  [62,1751],
  [62,1765],
  [62,1845],
  [62,1945],
  [62,2048],
  [62,2129],
  [62,2167],
  [62,2171],
  [62,2184],
  [62,2261],
  [62,2290],
  [62,2338],
  [62,2343],
  [62,2346],
  [62,2398],
  [62,2399],
  [62,2454],
  [62,2461],
  [62,2472],
  [62,2489],
  [62,2528],
  [62,2532],
  [62,2562],
  [62,2564],
  [62,2570],
  [62,2572],
  [62,2597],
  [62,2690],
  [62,2706],
  [62,2709],
  [62,2715],
  [62,2716],
  [62,2730],
  [62,2742],
  [62,2744],
  [62,2749],
  [62,2763],
  [62,2792],
  [62,2806],
  [62,2892],
  [62,2900],
  [62,2913],
  [62,2916],
  [62,2918],
  [62,2922],
  [62,2931],
  [62,2933],
  [62,2936],
  [62,2944],
  [62,2957],
  [62,2961],
  [62,2963],
  [62,2967],
  [62,2969],
  [62,2972],
  [62,2977],
  [62,2980],
  [62,2983],
  [65,2912],
  [65,2930],
  [65,2572],
  [65,1768],
  [65,1751],
  [65,2937],
  [65,3015],
  [65,2431],
  [65,1453],
  [65,272],
  [65,2467],
  [65,2261],
  [65,1709],
  [65,1489],
  [65,1436],
  [65,2422],
  [65,2991],
  [65,2555],
  [65,2098],
  [65,1698],
  [65,2971],
  [65,2722],
  [65,2449],
  [65,2791],
  [65,1654],
  [65,2592],
  [65,1737],
  [65,1765],
  [65,1914],
  [65,1642],
  [65,2343],
  [65,2952],
  [65,2434],
  [65,2305],
  [65,2988],
  [65,2290],
  [65,2717],
  [65,2291],
  [65,1657],
  [65,2376],
  [65,1402],
  [65,1860],
  [65,2709],
  [65,624],
  [65,1645],
  [65,2960],
  [65,2337],
  [65,1018],
  [65,2734],
  [65,2104],
  [65,2726],
  [65,2962],
  [65,1483],
  [65,2979],
  [65,2922],
  [65,521],
  [65,1869],
  [65,2945],
  [67,565],
  [67,1001],
  [67,1337],
  [67,1456],
  [67,1526],
  [67,1548],
  [67,1553],
  [67,1657],
  [67,1698],
  [67,1736],
  [67,1740],
  [67,1761],
  [67,1768],
  [67,1826],
  [67,1869],
  [67,1882],
  [67,1898],
  [67,1996],
  [67,2066],
  [67,2096],
  [67,2152],
  [67,2171],
  [67,2197],
  [67,2206],
  [67,2207],
  [67,2215],
  [67,2274],
  [67,2277],
  [67,2288],
  [67,2309],
  [67,2312],
  [67,2388],
  [67,2396],
  [67,2472],
  [67,2489],
  [67,2515],
  [67,2528],
  [67,2706],
  [67,2707],
  [67,2717],
  [67,2720],
  [67,2721],
  [67,2722],
  [67,2723],
  [67,2728],
  [67,2749],
  [67,2806],
  [67,2812],
  [67,2880],
  [67,2900],
  [67,2938],
  [67,2952],
  [67,2969],
  [67,2989],
  [67,2991],
  [67,2997],
  [67,3009],
  [70,1765],
  [70,2445],
  [70,2151],
  [70,871],
  [70,2245],
  [70,2514],
  [70,272],
  [70,1971],
  [70,2717],
  [70,2398],
  [70,344],
  [70,2506],
  [70,1541],
  [70,2207],
  [70,2132],
  [70,2727],
  [70,2726],
  [70,2530],
  [70,900],
  [70,2917],
  [70,2972],
  [70,1698],
  [70,624],
  [70,2709],
  [70,3056],
  [70,2622],
  [70,2768],
  [70,2190],
  [70,2980]  
]

sold_transfers.each do | transfer_day_id, player_id |
  if Transfer.where(transfer_day_id: transfer_day_id, player_id: player_id).empty?
    Transfer.create(transfer_day_id: transfer_day_id, player_id: player_id, d11_team_id: 1, fee: 0)
  end
end
