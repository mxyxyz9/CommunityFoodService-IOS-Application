# iOS Food Sharing App

## Tech Stack
- **Swift**
- **SwiftUI**
- **SwiftData**
- **Supabase**

## Design Guidelines
- **Primary Font**: SF Pro Rounded
- **Font Sizes (Following Apple Design Guidelines)**:
  - **Large Title**: 34pt
  - **Title 1**: 28pt
  - **Title 2**: 22pt
  - **Title 3**: 20pt
  - **Headline**: 17pt (bold)
  - **Body**: 17pt (regular)
  - **Callout**: 16pt
  - **Subheadline**: 15pt
  - **Footnote**: 13pt
  - **Caption 1**: 12pt
  - **Caption 2**: 11pt

## Features

### 1. **Home Tab**
- Displays a welcome message and username.
- Location selection:
  - Automatic GPS-based selection.
  - Manual selection via pin or text input.
  - Defaults to a random address if no selection is made.
- "New Post" tag for food sharing:
  - Navigates to a form screen with the following fields:
    - **Image**: Upload food image.
    - **Title**: Name of the food.
    - **Description**: Short description of the food.
    - **Labels**: Select from "Veg" or "Non-Veg".
    - **Slider**: Expected number of people the food can feed.
    - **Address Selection**: Uses pre-selected address or allows manual input.
    - **Expiration**: Set the time duration for the post visibility.
    - **Publish Option**: Posts the listing.
- **Food Listing Screen**:
  - Displays all active food posts.
  - Shows food details, location, and expiration time.
  - Option to filter listings by category and distance.

#### **User Flow for Home Tab**
1. **User lands on the home tab**.
2. **Location is automatically detected** or manually set.
3. **User views existing food posts**.
4. **User clicks "New Post" to add a food listing**.
5. **User fills out the form and publishes the post**.
6. **Post is visible in the listing screen**.
7. **If an error occurs (e.g., missing fields, invalid image format), prompt user to correct**.
8. **User can delete or edit their post**.

### 2. **Search Tab**
- Double tap on the search bar to open the keyboard.
- Filter options:
  - **Food Type**: "Veg" or "Non-Veg".
  - **Expected Feeds**: Number of people the food can serve.
  - **Distance-Based Filtering**: 1km, 2km, 5km, 10km, etc.
- **Search Results Screen**:
  - Displays matching food listings.
  - Allows sorting by proximity, popularity, and recent posts.

#### **User Flow for Search Tab**
1. **User navigates to the search tab**.
2. **User taps on the search bar (keyboard opens)**.
3. **User enters search query or selects filters**.
4. **Filtered results are displayed**.
5. **User selects a listing for more details**.
6. **If no results match, display "No listings found" message**.
7. **User can reset filters or refine the search**.

### 3. **Profile Tab**
- **Dark Mode Toggle**.
- **User Details Section**:
  - Update address.
  - View past donation history.
- **Streak Table**:
  - Tracks daily food donation streak.
  - Displays progress.
  - Shareable card for social media.
- **Settings Screen**:
  - Update profile information.
  - Manage notification preferences.
  - Logout option.

#### **User Flow for Profile Tab**
1. **User navigates to the profile tab**.
2. **User views profile information**.
3. **User updates profile details if needed**.
4. **User checks donation streak and history**.
5. **User shares streak on social media**.
6. **User toggles dark mode**.
7. **User logs out (returns to authentication screen)**.

## Registration & Authentication
- Sign in via:
  - **Phone Number**.
  - **Google Account** + Phone Number.
  - **Apple ID** + Phone Number.

#### **User Flow for Registration & Sign-Up**
1. **User opens the app**.
2. **Welcome screen is displayed with sign-up options**.
3. **User selects authentication method**.
4. **User verifies phone number using OTP**.
5. **User sets up profile details**.
6. **User allows location access (or enters manually)**.
7. **User completes onboarding guide**.
8. **User is redirected to the home screen**.
9. **If sign-up fails, display appropriate error messages and retry options**.

## Additional User Flows

### **Editing & Deleting a Post**
1. **User selects an existing post from the home screen**.
2. **User taps the edit/delete option**.
3. **If editing, user updates details and saves changes**.
4. **If deleting, confirmation popup appears before removal**.

### **Reporting a Post**
1. **User selects a post they want to report**.
2. **User taps "Report Post" option**.
3. **User selects a reason for reporting**.
4. **Report is submitted, and moderation is notified**.
5. **User receives confirmation that the report was sent**.

### **Bookmarking a Post**
1. **User taps the bookmark icon on a listing**.
2. **Post is saved under "Bookmarks" section in the profile tab**.
3. **User can remove the bookmark by tapping again**.

### **Chat Feature Flow**
1. **User selects a food post**.
2. **User taps "Chat with Donor"**.
3. **Chat screen opens for messaging**.
4. **If the donor deletes their post, chat is disabled**.
5. **User can report or block unwanted messages**.

### **Notification Handling**
1. **User receives notification for a relevant post**.
2. **User taps notification to open the app and view the post**.
3. **User can enable/disable notifications in profile settings**.

### **Leaderboard & Streak System**
1. **User donates food daily to maintain a streak**.
2. **Leaderboard updates with top donors**.
3. **User earns badges for milestones**.
4. **User can share their rank on social media**.

This app will help users efficiently share and find food while tracking their contributions through a streak system, ensuring maximum participation and engagement.
