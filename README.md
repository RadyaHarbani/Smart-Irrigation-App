# 🌱 Smart Irrigation App

A Flutter-based mobile application designed to help users manage and schedule plant watering efficiently using an interactive calendar system.

---

## 📱 Features

### 🗓️ Interactive Calendar

* Monthly calendar view
* Navigate between months and years
* Responsive layout for all screen sizes

### ⏰ Time-Based Scheduling (MAE)

Each day is divided into:

* **M (Morning)**
* **A (Afternoon)**
* **E (Evening)**

Users can assign watering schedules based on these time slots.

### 🌿 Drag & Drop Scheduling

* Drag plant items into calendar slots
* Intuitive and fast interaction

### ❌ Event Management

* Tap on a scheduled plant to remove it
* Real-time UI updates using reactive state management

### 🎨 Modern UI

* Clean and minimal design
* Google Fonts (Poppins)
* Smooth and responsive layout
* Horizontal scroll for better visibility

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **GetX** (State Management)
* **Google Fonts**
* **Intl** (Date formatting)
* **Flutter SVG**

---

## 📂 Project Structure

```
lib/
├── app/
│   ├── pages/
│   │   └── calendar/
│   │       ├── calendar_view.dart
│   │       └── calendar_controller.dart
│   └── ...
└── main.dart
```

---

## 🚀 Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/your-username/smart_irrigation_app.git
cd smart_irrigation_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run Application

```bash
flutter run
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get:
  google_fonts:
  intl:
  flutter_svg:
```

---

## 🎯 How to Use

1. Select a plant from the top list
2. Drag it into a calendar slot (M/A/E)
3. Tap on an event to delete it
4. Navigate months using arrows or tap the month to pick a date

---

## 📸 UI Highlights

* Horizontal scrollable calendar grid
* Fixed MAE labels for clarity
* Responsive layout across devices
* Smooth drag-and-drop experience

---

## 🔮 Future Improvements

* 💾 Local storage (Hive / SQLite)
* 🔔 Notifications for watering reminders
* 🌦 Weather API integration
* 🎨 Custom plant icons & colors
* 📊 Analytics for watering habits

---

## 👨‍💻 Developer Notes

* Uses **GetX reactive state** for efficient UI updates
* Single scroll container for synchronized header & grid
* Responsive sizing using `MediaQuery`

---

## ✨ Credits

Built with ❤️ using Flutter
