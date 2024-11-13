# Expense Tracker

Track your expenses with Expense Tracker!

With a pretty bar chart to show you which kind of expense (currently only Food, Travel, Work, or Leisure) you've been splurging on. Features I *could* add:

- Update existing expenses
- Make expense list sortable by different metrics
- Ability to add new expense categories
- Better form validation messaging
- Remove dummy expenses when not in debug mode
- Customizable, or just prettier, colors

Built with Flutter as part of Maximilian Schwarzmüller's Udemy course: https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps

What I learned building this app:

- New widgets:
    - `ListView`
    - `LayoutBuilder`
    - `FutureBuilder`
    - `ScaffoldMessenger`
    - `SnackBar`
    - `Card`
    - `FractionallySizedBox`
    - `TextField`
    - `DropdownButton`
    - `Spacer`
    - `Dismissable`
- New concepts:
    - App Themes
    - Responsive design with `MediaQuery` and `LayoutBuilder`
    - Managing size constraints with `Expanded`, `double.infinity`, etc...
    - `showModalBottomSheet`
    - `TextEditingController` for managing TextField user input
    - `showDatePicker`
    - `showDialog` and `showCupertinoDialog` and corresponding alert dialogs

## Trying it out

You will need the Flutter SDK to run this app. Then, to run in debug mode, on your command line enter:

`flutter run`