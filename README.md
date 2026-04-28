# Tasky

Tasky is a simple app made with Flutter. It helps you keep track of your tasks, notes, and counts. It has a nice look and you can pick different colors.

# ( How the App Works )

1. Splash Screen: When you open the app, you see a quick screen for a few seconds.
2. Login: You go to a login screen. Put in your details to enter the app.
3. Dashboard: This is the main menu. You can pick Tasks, Notes, or the Counter.
4. Tasks App:
   - Home Screen: See all your tasks in a list with bright borders.
   - Checkbox: Click the box to finish a task.
   - Favorites: Click the star to save important tasks.
5. Notes App:
   - Design: Your notes look like cards with the time they were made.
   - Colors: Pick a color for each note.
6. Counter App:
   - Track: A screen to add or subtract numbers. It saves by itself.
7. Adding and Editing: Click the plus button to make a new one. You can type titles and pick colors.
8. Deleting: Click the trash icon to remove a task or note.
9. Search: Use the bar at the top to find your notes by name.

## Features

- Saves on phone: Everything is saved so it does not go away when you close the app.
- Pick colors: You can choose different colors for your items.
- Login screen: It has a login and a reset password screen.
- Separate parts: Tasks and notes are in different screens.

## Setup and Run

1. Install Flutter on your computer.
2. Run flutter pub get in the terminal.
3. Plug in your phone or start an emulator.
4. Run the app with: flutter run or click the play button in Android Studio.

## Files

- lib/main.dart: Starts the app.
- lib/splash_screen.dart: The first screen.
- lib/loginscreen.dart: The login screen.
- lib/forgot_password_screen.dart: The password reset screen.
- lib/dashboard_screen.dart: The main menu.
- lib/todo_screen.dart: The task list.
- lib/notes_screen.dart: The notes list.
- lib/counter_screen.dart: The counter screen.
- lib/task_form_screen.dart: The screen to add or change items.


State Management (Provider)

This app uses Provider for managing state in a clean and simple way. It helps handle tasks, notes, and counter data more efficiently and keeps the UI updated automatically when changes happen.

Features
Saves on phone: Everything is saved so it does not go away when you close the app.
Pick colors: You can choose different colors for your items.
Login screen: It has a login and a reset password screen.
Separate parts: Tasks and notes are in different screens.
