# Step Detection - Flutter (Under Development)

Approaches and Visualisation:
To address the issue of too many points and improve the readability of the chart, we can downsample the data by dividing the entire series into (10 for example) equal segments, computing the average of the sensor data (az, for example) in each segment, and then using the average of the time for each segment as the X-axis.

Step count:
calculating the az spikes (based on a threshold) in real time in order to detect the steps and its counts.

for all visualisation I did down sampled the data points taking the average of segment or a window in order to be nicely readable and understandable for every kinds of users.

---

citation and sources that i learned:
https://api.flutter.dev/flutter/dart-math/dart-math-library.html

https://fluttergems.dev/math-utilities/

---

Data science part of this project:
https://github.com/arifhaidari/step_detection_data_science/tree/main

---

Data used in the backend:
I have used a small part (so the app to be light and simplicity) of the data since it was huge since the data science project (ML model) was not deployed to use API to fetch all data.
calculated_steps.json
input_data.json

---

challenges:
write this part a little bit with humor:
setting up the environemnt and dealing with compatibility issue (typical flutter things)
was not able use packages especially with data_table_2 and syncfusion_flutter_datagrid and different version of flutter.

the second challenge was step counter - the logic is very simple in python (just importing the packages) but it is a hell of work building from scratch - time to appreciate python :)
https://github.com/arifhaidari/step_detection_flutter/blob/main/lib/utils/step_counter.dart

for more challenges meet me here:
https://github.com/arifhaidari/step_detection_data_science/tree/main

---

a comprehensive documentation will be available in the data science part of this project which is available in this link:
https://github.com/arifhaidari/step_detection_data_science/tree/main

---

apk to install:
you can get the apk in build/app/outputs/flutter-apk/
