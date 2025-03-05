# iOS Community Food Sharing App

## Overview
The iOS Community Food Sharing App is a platform designed to empower communities to share food easily and responsibly. It allows users to post available food items, search for nearby offerings, and track their contributions through a streak system. Built with Swift, SwiftUI, SwiftData, and Supabase, the app emphasizes a clean, user-friendly design while leveraging robust backend services for real-time functionality.

## Table of Contents
- [Tech Stack](#tech-stack)
- [Design Guidelines](#design-guidelines)
- [Features](#features)
  - [Home Tab](#home-tab)
  - [Search Tab](#search-tab)
  - [Profile Tab](#profile-tab)
- [User Flows](#user-flows)
  - [Registration & Authentication](#registration--authentication)
  - [Editing & Deleting a Post](#editing--deleting-a-post)
  - [Reporting a Post](#reporting-a-post)
  - [Bookmarking a Post](#bookmarking-a-post)
  - [Chat Feature Flow](#chat-feature-flow)
  - [Notification Handling](#notification-handling)
  - [Leaderboard & Streak System](#leaderboard--streak-system)
- [Contributing](#contributing)
- [License](#license)

## Tech Stack
- **Swift**
- **SwiftUI**
- **SwiftData**
- **Supabase**

## Design Guidelines
- **Primary Font:** SF Pro Rounded
- **Font Sizes (Following Apple Design Guidelines):**
  - **Large Title:** 34pt
  - **Title 1:** 28pt
  - **Title 2:** 22pt
  - **Title 3:** 20pt
  - **Headline:** 17pt (bold)
  - **Body:** 17pt (regular)
  - **Callout:** 16pt
  - **Subheadline:** 15pt
  - **Footnote:** 13pt
  - **Caption 1:** 12pt
  - **Caption 2:** 11pt

## Features

### Home Tab
- **Welcome Message & Username Display:** Greets the user on landing.
- **Location Selection:**
  - **Automatic:** GPS-based detection.
  - **Manual:** Via pin or text input.
  - **Fallback:** Defaults to a random address if no selection is made.
- **New Post Creation:**
  - Navigate to a form screen with the following fields:
    - **Image:** Upload a food image.
    - **Title:** Name of the food.
    - **Description:** A short description.
    - **Labels:** Choose between "Veg" or "Non-Veg".
    - **Slider:** Set the expected number of people the food can feed.
    - **Address Selection:** Use pre-selected address or enter manually.
    - **Expiration:** Set duration for post visibility.
    - **Publish Option:** Submit the listing.
- **Food Listing Screen:**
  - Displays all active food posts with details like location and expiration time.
  - Allows filtering by category and distance.

#### User Flow for Home Tab
1. User lands on the home tab.
2. Location is detected automatically or set manually.
3. Existing food posts are displayed.
4. User clicks "New Post" to add a food listing.
5. The form is filled out and the post is published.
6. The new post appears in the listing.
7. If errors occur (e.g., missing fields, invalid image), the user is prompted to correct them.
8. Users can delete or edit their posts.

### Search Tab
- **Search Bar Interaction:** Double-tap to open the keyboard.
- **Filter Options:**
  - **Food Type:** "Veg" or "Non-Veg".
  - **Expected Feeds:** Number of people the food can serve.
  - **Distance:** Options like 1km, 2km, 5km, 10km, etc.
- **Search Results Screen:**
  - Displays matching food listings.
  - Supports sorting by proximity, popularity, and recency.

#### User Flow for Search Tab
1. User navigates to the search tab.
2. Taps the search bar (keyboard opens).
3. Enters a search query or selects filters.
4. Filtered results are displayed.
5. User selects a listing to view details.
6. If no matches are found, a "No listings found" message is displayed.
7. Users can reset or refine their search.

### Profile Tab
- **Dark Mode Toggle:** Switch between light and dark themes.
- **User Details Section:**
  - Update personal address.
  - View past donation history.
- **Streak Table:**
  - Tracks daily food donation streak.
  - Displays progress with a shareable card for social media.
- **Settings Screen:**
  - Update profile information.
  - Manage notification preferences.
  - Logout functionality.

#### User Flow for Profile Tab
1. User navigates to the profile tab.
2. Profile information is displayed.
3. User updates details if needed.
4. Donation streak and history are reviewed.
5. Streak can be shared on social media.
6. Dark mode can be toggled.
7. Logging out returns the user to the authentication screen.

## User Flows

### Registration & Authentication
- **Sign-In Options:**
  - Phone Number.
  - Google Account + Phone Number.
  - Apple ID + Phone Number.

#### Registration & Sign-Up Flow
1. User opens the app.
2. Welcome screen displays multiple sign-up options.
3. User selects an authentication method.
4. Phone number verification is performed via OTP.
5. Profile details are set up.
6. Location access is granted (or entered manually).
7. The onboarding guide is completed.
8. User is redirected to the home screen.
9. In case of failure, error messages prompt a retry.

### Editing & Deleting a Post
1. User selects an existing post from the home screen.
2. Taps the edit/delete option.
3. For editing, updates are made and saved.
4. For deletion, a confirmation popup is shown before removal.

### Reporting a Post
1. User selects a post to report.
2. Taps the "Report Post" option.
3. Chooses a reason for reporting.
4. The report is submitted to moderation.
5. Confirmation of the report is displayed.

### Bookmarking a Post
1. User taps the bookmark icon on a listing.
2. The post is saved in the "Bookmarks" section under the profile tab.
3. Tapping again removes the bookmark.

### Chat Feature Flow
1. User selects a food post.
2. Taps "Chat with Donor" to open a messaging interface.
3. Chat continues until the donor deletes the post (which disables the chat).
4. Options are provided to report or block unwanted messages.

### Notification Handling
1. Users receive notifications for relevant posts.
2. Tapping a notification opens the app to the corresponding post.
3. Notification preferences can be adjusted in the profile settings.

### Leaderboard & Streak System
1. Daily food donations help maintain a streak.
2. A leaderboard displays the top donors.
3. Milestone badges are earned.
4. Users can share their ranking on social media.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes with clear messages.
4. Open a pull request with a detailed description of your changes.
5. Ensure adherence to project guidelines.

## License
This project is licensed under the [MIT License](LICENSE).
