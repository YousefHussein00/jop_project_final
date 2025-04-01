# Statistics Module

A reusable Flutter statistics visualization module that provides beautiful and interactive statistics displays.

## Features

- Circular progress indicators with labels and values
- Statistic bars with progress indication
- Statistics data provider for state management
- Ready-to-use statistics screen

## Structure

```
statistics/
├── domain/
│   └── statistics_model.dart
├── presentation/
│   ├── provider/
│   │   └── statistics_provider.dart
│   ├── screens/
│   │   └── statistics_screen.dart
│   └── widgets/
│       ├── circular_indicator.dart
│       └── statistic_bar.dart
└── README.md
```

## Usage

1. Copy the entire `statistics` folder to your project's `lib/features/` directory
2. Add the required dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  provider: ^6.0.0
  percent_indicator: ^4.0.0
```

3. Import and use the components in your app:

```dart
import 'package:your_app/features/statistics/presentation/screens/statistics_screen.dart';

// Use the statistics screen
StatisticsScreen()
```

## Dependencies

- provider: For state management
- percent_indicator: For circular progress indicators