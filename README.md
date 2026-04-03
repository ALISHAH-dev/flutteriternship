# Tasky

Tasky is a simple and clean task management app built with Flutter. It's designed to help you organize your daily  tasks with a modern ui and good color selection

 # (   How the App Works )

1.  Splash Screen: When you open the app, you'll see a quick splash screen for a few seconds.
2.  Login: You'll be taken to a login screen. Enter your details to get into the app.
3.  Home Dashboard: This is where all your notes are displayed. You can see a list of cards showing your task titles and descriptions.
4.  Adding a Task: Click the + button at the bottom. It opens a new screen where you can type your title, add a description, and pick a color for that specific task.
5.  Editing & Deleting : If you want to change something, just tap the edit icon on the card. To remove a task, hit the delete icon.
6.  Search: If you have a lot of notes, use the search bar at the top to find what you're looking for by title.

## Features

- Local Storage: Everything is saved on your phone (using shared_preferences), so your tasks won't disappear when you close the app.
- Custom Colors: You can pick different colors for each task to keep them organized visually.
- Authentication UI: Includes a professional login and a forgot password screen.  


## Setup & Run

1.  Make sure you have all the dependies install that is required to run or app smoothly
2.  Run `flutter pub get` in the terminal to install the dependencies.
3.  Connect your device or emulator.
4.  Run the app using:
  flutter run or flutter run chrome command and also we can use run button from the top of andriod studio to run it on emulator or a device that is connected 
to andriod studio 
## Files

- `lib/main.dart`: Sets up the app and theme.
- `lib/splash_screen.dart`: The loading screen.
- `lib/loginscreen.dart` and  `forgot_password_screen.dart`: The auth screens.
- `lib/todo_screen.dart`: The main list of tasks.
- `lib/task_form_screen.dart`: The screen for adding or editing tasks.
