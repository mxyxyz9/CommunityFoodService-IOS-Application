**Community Food Service – iOS Application**


A community-driven food sharing platform that empowers individuals to donate surplus food, discover available listings nearby, and track their donation history—promoting sustainability and reducing food waste.

---

## 🏷️ Badges

![Swift Version](https://img.shields.io/badge/Swift-5.0-orange) ![iOS Deployment](https://img.shields.io/badge/iOS-13.0%2B-blue) ![License](https://img.shields.io/badge/License-MIT-green)

---

## 📖 Table of Contents

1. [Features](#-features)
2. [Screenshots](#-screenshots)
3. [Installation](#-installation)
4. [Technologies](#-technologies)
5. [Project Structure](#-project-structure)
6. [Roadmap](#-roadmap)
7. [Contributing](#-contributing)
8. [License](#-license)

---

## ✨ Features

* **Home Tab**: Post available food with images, descriptions, and estimated servings.
* **Search Tab**: Filter listings by type (Veg/Non-Veg), servings, distance, and dietary preferences.
* **Profile Tab**: View and manage user details, track donation history, and share donation streaks.
* **Location Selection**: Use GPS or manually enter an address to discover nearby food.
* **Donation Streaks**: Monitor and share ongoing donation activity to encourage regular contributions.
* **Push Notifications**: Receive alerts for new nearby listings and community announcements.
* **Multilingual Support**: Switch between English, Spanish, and other languages (coming soon).

---

## 📸 Screenshots

<p align="center">
  <img src="docs/screenshots/home.png" alt="Home Screen" width="200" />
  <img src="docs/screenshots/search.png" alt="Search Screen" width="200" />
  <img src="docs/screenshots/profile.png" alt="Profile Screen" width="200" />
</p>

---

## 🚀 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/mxyxyz9/CommunityFoodService-IOS-Application.git
   ```
2. **Navigate into the project**

   ```bash
   cd CommunityFoodService-IOS-Application
   ```
3. **Install dependencies**

   ```bash
   pod install
   ```
4. **Open the project**

   ```bash
   open CommunityFoodService.xcworkspace
   ```
5. **Build & run**

   * Select a simulator or device.
   * Press `Cmd + R`.

---

## 🛠️ Technologies

* **Language**: Swift 5
* **UI**: UIKit
* **Location**: CoreLocation, MapKit
* **Backend**: Firebase (Authentication, Firestore, Storage)
* **Dependency Management**: CocoaPods
* **Notifications**: Firebase Cloud Messaging

---

## 📂 Project Structure

```
├── CommunityFoodService.xcworkspace  # Workspace file
├── CommunityFoodService/             # App source code
│   ├── Models/                       # Data models
│   ├── Views/                        # UI components
│   ├── ViewControllers/              # Screen controllers
│   ├── Services/                     # API & location services
│   └── SupportingFiles/              # Assets, Info.plist
├── CommunityFoodServiceTests/        # Unit tests
├── CommunityFoodServiceUITests/      # UI tests
├── docs/                             # Documentation & screenshots
│   ├── screenshots/                  # Example UI
│   └── buildplan.md                  # Development timeline & planning
└── README.md                         # Project README
```

---

## 📈 Roadmap

| Status         | Task                                        |
| -------------- | ------------------------------------------- |
| ✅ Completed    | Basic CRUD for food listings                |
| ✅ Completed    | User authentication (Firebase)              |
| ✅ Completed    | GPS-based location discovery                |
| 🚧 In Progress | Advanced search filters (dietary, distance) |
| 🚧 In Progress | Push notifications for new listings         |
| 💤 Planned     | Web admin dashboard                         |
| 💤 Planned     | Multilingual support                        |
| 💤 Planned     | Dark mode                                   |

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repo.
2. Create a feature branch:

   ```bash
   git checkout -b feature/YourFeature
   ```
3. Commit your changes:

   ```bash
   git commit -m "Add YourFeature"
   ```
4. Push to your branch:

   ```bash
   git push origin feature/YourFeature
   ```
5. Open a Pull Request and describe your changes.

Ensure your code follows the existing style and include tests where applicable. For major changes, please open an issue first to discuss.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
