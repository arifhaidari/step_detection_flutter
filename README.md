# Step Detection - Flutter (Under Development)

Visualisation:
To address the issue of too many points and improve the readability of the chart, we can downsample the data by dividing the entire series into 10 equal segments, computing the average of the sensor data (az, for example) in each segment, and then using the average of the time for each segment as the X-axis.

Approach:
Divide the Data into 10 Equal Parts:

If we have N data points, divide them into 10 equal parts.
For each part, compute the average of the sensor data (az in this case).
Also, compute the average time for each segment, or pick the end time of each segment.
Create a Function to Downsample the Data:

The function will take the sensor data and measurement ID, divide the data into 10 parts, and return the average values.
Plot the Downsampled Data:

Use the downsampled data (with 10 points) for the chart.

---

citation and sources that i learned:
https://api.flutter.dev/flutter/dart-math/dart-math-library.html

https://fluttergems.dev/math-utilities/

challenges:
setting up the environemnt and dealing with compatibility issue (typical flutter things)
was not able use packages such as:
data_table_2 and syncfusion_flutter_datagrid
