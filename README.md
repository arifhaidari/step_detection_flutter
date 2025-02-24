# Step Detection - Flutter (Under Development)

## Overview

This Flutter app is designed to detect (predict) and count steps using sensor data. The app also visualizes the sensor data in a readable format by applying data downsampling techniques.

## Features

- **Step Counting**: Detects steps by identifying spikes in the accelerometer's magnitude based on a threshold.
- **Data Visualization**: Downsamples sensor data by segmenting it into equal parts and averaging values for improved readability.
- **Lightweight Backend Data**: Uses a small subset of the original dataset (JSON files) to keep the app lightweight, also the API (the data science project) is integrated into backend where user can do the prediction and also list out the predictions.
- **Flutter-Based UI**: Interactive charts and tables to display step counts and sensor data trends.

## Approach & Data Visualization

To improve chart readability and manage large amounts of sensor data, the app segments the data into equal parts (e.g., 10 segments). It then:

- Computes the average of sensor values (e.g., az) for each segment.
- Uses the average time of each segment as the X-axis for visualization.

This method ensures a smooth and easily interpretable graphical representation for all users.

## Screenshots

🔗 [See Screenshots](https://github.com/arifhaidari/step_detection_flutter/blob/main/screenshots/screenshot_list.md)

## Data Used

The app utilizes precomputed step detection data:

- `calculated_steps.json`
- `input_data.json`
- API calls (data come from serer)

Since the full dataset is large, only a small subset (JSON Files) is included to maintain simplicity and efficiency.

## Challenges :)

1. **Setting Up the Environment**: Dealing with compatibility issues... Classic Flutter struggles! 🙃
2. **Package Woes**: Some packages refused to cooperate—especially `data_table_2` and `syncfusion_flutter_datagrid` with different Flutter versions (I must blame my old standard laptop as well 🙃).
3. **Python Equivalent Logic**: What’s easy in Python (import a package and call a function) turned into a monster of a task in Flutter. Appreciation for Python just skyrocketed! 🚀

For more developer insights, visit the data science (part of this) project: [Step Detection Data Science](https://github.com/arifhaidari/step_detection_data_science/tree/main)

## Data Science Component

The core logic and experiments for step detection are documented in the data science counterpart of this project:
🔗 [Step Detection Data Science](https://github.com/arifhaidari/step_detection_data_science/tree/main)

## Citations & Learning Resources

- [Dart Math Library](https://api.flutter.dev/flutter/dart-math/dart-math-library.html)
- [Flutter Gems - Math Utilities](https://fluttergems.dev/math-utilities/)

## Installation

You can install the app by downloading the APK:
[📥 Download APK](https://github.com/arifhaidari/step_detection_flutter/tree/main/apk)

---

For full documentation, check out the data science part of this project: [Documentation](https://github.com/arifhaidari/step_detection_data_science/tree/main)
