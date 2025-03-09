# 🚀 iOS Community Food Sharing App

Empowering communities to share food easily and responsibly. Built with Swift, SwiftUI, SwiftData, and Supabase, this app blends a clean, user-friendly design with robust real-time functionality. 🍎💡

---

## 📚 Table of Contents

- [🛠️ Tech Stack](#tech-stack)
- [🎨 Design Guidelines](#design-guidelines)
- [✨ Features](#features)
  - [🏠 Home Tab](#home-tab)
  - [🔍 Search Tab](#search-tab)
  - [👤 Profile Tab](#profile-tab)
- [🔄 User Flows](#user-flows)
  - [📝 Registration & Authentication](#registration--authentication)
  - [✏️ Editing & Deleting a Post](#editing--deleting-a-post)
  - [🚩 Reporting a Post](#reporting-a-post)
  - [🔖 Bookmarking a Post](#bookmarking-a-post)
  - [💬 Chat Feature Flow](#chat-feature-flow)
  - [🔔 Notification Handling](#notification-handling)
  - [🏆 Leaderboard & Streak System](#leaderboard--streak-system)
- [🤝 Contributing](#contributing)
- [📜 License](#license)

---

## 🛠️ Tech Stack

- **Swift** 🐦
- **SwiftUI** 📱
- **SwiftData** 💾
- **Supabase** 🔥

---

## 🎨 Design Guidelines

- **Primary Font:** SF Pro Rounded 🖋️
- **Font Sizes (Apple Design Guidelines):**
  - **Large Title:** 34pt 📏
  - **Title 1:** 28pt
  - **Title 2:** 22pt
  - **Title 3:** 20pt
  - **Headline:** 17pt (bold) 💪
  - **Body:** 17pt (regular)
  - **Callout:** 16pt
  - **Subheadline:** 15pt
  - **Footnote:** 13pt
  - **Caption 1:** 12pt
  - **Caption 2:** 11pt

---

## ✨ Features

### 🏠 Home Tab

- **Welcome Message & Username Display:** Greets users upon landing. 👋
- **Location Selection:**
  - **Automatic:** GPS-based detection 📍
  - **Manual:** Via pin or text input 🖊️
  - **Fallback:** Uses a default address if none is selected.
- **New Post Creation:** Create a food listing with:
  - **Image Upload:** 📸
  - **Title & Description:** 📝
  - **Labels:** Choose between "Veg" 🌿 and "Non-Veg" 🍖
  - **Slider:** Set expected number of people served ➡️
  - **Address Selection:** Pre-selected or manual entry 🏠
  - **Expiration:** Define post visibility duration ⏰
  - **Publish Option:** Submit your listing 🚀
- **Food Listing Screen:** Displays active food posts with details like location and expiration. Supports filtering by category and distance. 🔄

#### User Flow for Home Tab
1. User lands on the home tab. 🏠
2. Location is auto-detected or manually set. 📍
3. Food posts are displayed. 🍲
4. User taps "New Post" to create a listing. ➕
5. Fills out the form and publishes the post. ✅
6. New post appears in the listing. 🎉
7. Error prompts appear for any issues. ❗
8. Users can edit or delete their posts. ✏️🗑️

---

### 🔍 Search Tab

- **Search Bar Interaction:** Tap to open the keyboard. ⌨️
- **Filter Options:**
  - **Food Type:** "Veg" 🌿 or "Non-Veg" 🍖
  - **Expected Feeds:** Number of people served 👥
  - **Distance:** Options like 1km, 2km, etc. 📏
- **Search Results Screen:** Displays matching food listings and supports sorting by proximity, popularity, and recency. 📊

#### User Flow for Search Tab
1. User navigates to the search tab. 🔍
2. Taps the search bar to open the keyboard. ⌨️
3. Enters a query or selects filters. 🔄
4. Filtered results are displayed. 📋
5. User selects a listing to view details. 👀
6. A "No listings found" message appears if there are no matches. 🚫
7. Users can refine or reset their search. 🔄

---

### 👤 Profile Tab

- **Dark Mode Toggle:** Switch between light and dark themes. 🌙☀️
- **User Details:** Update address and view donation history. 🏠📜
- **Streak Table:** 
  - Tracks daily food donation streaks. 🔥
  - Shareable streak card for social media. 📢
- **Settings:** Update profile info, manage notifications, and logout. ⚙️

#### User Flow for Profile Tab
1. User navigates to the profile tab. 👤
2. Profile details are displayed. 📄
3. User can update personal information. ✏️
4. Donation streak and history are reviewed. 🔥
5. Option to share the streak on social media. 📢
6. Dark mode toggle available. 🌙☀️
7. Logging out returns the user to the authentication screen. 🔒

---

## 🔄 User Flows

### 📝 Registration & Authentication

- **Sign-In Options:**
  - Phone Number 📞
  - Google + Phone Number 🌐📞
  - Apple ID + Phone Number 🍎📞

#### Registration & Sign-Up Flow
1. User opens the app. 📲
2. Welcome screen displays multiple sign-up options. 🎉
3. User selects an authentication method. ✅
4. Phone number is verified via OTP. 🔑
5. Profile details are set up. 📝
6. Location access is granted or manually entered. 📍
7. Onboarding guide is completed. 🎓
8. User is redirected to the home screen. 🏠
9. Errors prompt a retry if necessary. ❗

---

### ✏️ Editing & Deleting a Post

1. User selects an existing post from the home screen. 🏠
2. Taps the edit/delete option. ✏️🗑️
3. For editing, changes are saved. 💾
4. For deletion, a confirmation popup appears. ❓

---

### 🚩 Reporting a Post

1. User selects a post to report. 🚩
2. Taps the "Report Post" option. 🛑
3. Chooses a reason for reporting. ❗
4. Report is submitted for moderation. 👮
5. A confirmation message is displayed. ✅

---

### 🔖 Bookmarking a Post

1. User taps the bookmark icon on a listing. 🔖
2. The post is saved in the "Bookmarks" section under the profile. 📑
3. Tapping again removes the bookmark. ❌

---

### 💬 Chat Feature Flow

1. User selects a food post. 🍲
2. Taps "Chat with Donor" to open the messaging interface. 💬
3. Chat continues until the donor deletes the post (which disables the chat). 🚫
4. Options to report or block messages are available. 🚷

---

### 🔔 Notification Handling

1. Users receive notifications for relevant posts. 🔔
2. Tapping a notification opens the corresponding post in the app. 📱
3. Notification preferences can be adjusted in the settings. ⚙️

---

### 🏆 Leaderboard & Streak System

1. Daily food donations maintain a streak. 🔥
2. A leaderboard displays the top donors. 🏅
3. Milestone badges are earned. 🎖️
4. Users can share their rankings on social media. 📢

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. **Fork** the repository. 🍴
2. Create a new **branch** for your feature or bugfix. 🌿
3. **Commit** your changes with clear messages. 📝
4. Open a **pull request** with a detailed description. 🔄
5. Follow the project guidelines. 📜

---

## 📜 License

This project is licensed under the [MIT License](LICENSE). 📜

---

*Happy Sharing! 🍽️🌍*
