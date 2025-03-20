# flutter_todo_web_desktop

A new Flutter project.

## Getting Started
This project is a starting point for a Flutter application.
 - Clean architecture implementation
 - Layout for web/desktop
 - Widgetbook implementation

## 📌  Project structure
```
📂 Project
├── 📂 Presentation
│   ├── 📂 Screens
│   ├── 📂 Components
│   ├── 📂 Resources
├── 📂 Domain 
│   ├── 📂 Entities
│   ├── 📂 UseCases
│   ├── 📂 Repositories
├── 📂 Data
│   ├── 📂 Networking (future)
│   ├── 📂 Database
│   ├── 📂 RepositoriesImpl
├── 📂 Tests (Future)
│   ├── 📂 UnitTests
│   ├── 📂 UITests
```

## 📜 Explanation
- Presentation 🎨: UI layer, containing ViewControllers, ViewModels, and custom UI components.
- Domain 🧠: Business logic layer, defining entities, use cases, and repository interfaces.
- Data 💾: Data sources, API calls, database management, and repository implementations.
- Core ⚙️: Shared utilities, extensions, and helper classes.
- Tests 🧪: Unit and UI testing files.

## 📚 Widgetbook
 - [x] Empty view
 - [x] CategoryScreen
 - [ ] ...

**widget build:**
 - `flutter pub run build_runner build --delete-conflicting-outputs`
 - `flutter run`
**formater**
- `dart format ./`
- `dart fix --apply`
