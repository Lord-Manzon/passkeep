# Passkeeper

Passkeeper is a Flutter-based password manager that allows you to store, edit, and copy your passwords safely. It categorizes your passwords into **All, Social, Games, and Work**, and includes a search feature to quickly find passwords.

## Features

- Add new passwords with a title, username/email, password, and category.
- Edit existing passwords by tapping on them.
- Copy passwords to clipboard with a single button.
- Search passwords by title or username in real-time.
- Categorized tabs with a count badge for each category.
- Dark-themed UI for better readability.

## How to Use

1. **Add Password**
   - Tap the **+ button** at the bottom right.
   - Fill in the details: Title, Username/Email, Password, Category.
   - Tap **Save** (or **Update** if editing).

2. **Edit Password**
   - Tap an existing password from the list.
   - Modify the fields and tap **Update**.

3. **Copy Password**
   - Tap the **copy icon** on the right of a password.

4. **Search Password**
   - Type in the search bar at the top. Only passwords that match the search query in title or username will appear in the **All tab**.

5. **View Categories**
   - Switch between **All, Social, Games, Work** tabs.
   - Each tab shows a badge count of how many passwords are stored in that category.

## Running on PC / Emulator

1. Clone the repository:
   ```bash
   git clone <your-repo-url>
   ```
2. Navigate to the project folder:
   cd passkeeper

3. Get dependencies:
   flutter pub get

4. Run on an emulator or connected device:
   flutter run
