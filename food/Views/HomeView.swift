import SwiftUI
import SwiftData
import PhotosUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var foodPosts: [FoodPost]
    @State private var isNewPostExpanded = false
    @Environment(\.colorScheme) var colorScheme
    
    // Location & Picker
    @State private var location: Location?
    @State private var showingLocationPicker = false
    
    // New post form states
    @State private var title = ""
    @State private var foodDescription = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    // 0 = Non-Veg, 1 = Veg
    @State private var vegValue = 0
    
    @State private var servingSize = 2
    @State private var expirationHours = 4
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Enhanced dynamic background gradient for dark mode
                LinearGradient(
                    gradient: Gradient(colors: [
                        colorScheme == .dark ? Color(hex: "121212") : Color(hex: "F5F5F5"),
                        colorScheme == .dark ? Color(hex: "262626") : Color(hex: "FFFFFF")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay(
                    // Add subtle pattern overlay for dark mode
                    colorScheme == .dark ? 
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.05))
                                .frame(width: 200, height: 200)
                                .blur(radius: 60)
                                .offset(x: -100, y: -100)
                            Circle()
                                .fill(Color.purple.opacity(0.05))
                                .frame(width: 300, height: 300)
                                .blur(radius: 80)
                                .offset(x: 150, y: 150)
                        } : nil
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Show a header if we have a location
                    if let location = location {
                        LocationHeader(location: location)
                    }
                    
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            // DisclosureGroup for creating a new post with improved styling
                            DisclosureGroup(
                                isExpanded: $isNewPostExpanded,
                                content: {
                                    newPostForm
                                },
                                label: {
                                    Label("Share Food", systemImage: "plus.circle.fill")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(colorScheme == .dark ? Color.blue.opacity(0.9) : .blue)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .contentShape(Rectangle())
                                        .padding(.vertical, 4)
                                }
                            )
                            .padding(16)
                            .background(
                                ZStack {
                                    // Blurred background
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(colorScheme == .dark ? 
                                              Color(UIColor.systemBackground).opacity(0.3) : 
                                              Color(UIColor.systemBackground).opacity(0.8))
                                        .blur(radius: colorScheme == .dark ? 0.5 : 0)
                                    
                                    // Glassmorphism effect
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(colorScheme == .dark ? 
                                              Color(hex: "1E1E1E").opacity(0.7) : 
                                              Color(UIColor.systemBackground).opacity(0.8))
                                }
                                .shadow(color: colorScheme == .dark ? 
                                       Color.black.opacity(0.2) : 
                                       Color.black.opacity(0.1), 
                                       radius: colorScheme == .dark ? 15 : 10, x: 0, y: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(colorScheme == .dark ? 
                                           Color.white.opacity(0.1) : 
                                           Color.white.opacity(0.2), lineWidth: 1)
                            )
                            
                            // Display existing posts
                            ForEach(foodPosts) { post in
                                FoodPostCard(post: post)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding()
                        .animation(.spring(response: 0.4), value: foodPosts.count)
                    }
                }
            }
            .navigationTitle("Food Share")
            // Present the location picker
            .sheet(isPresented: $showingLocationPicker) {
                LocationPickerView(selectedLocation: $location)
            }
        }
    }
    
    // MARK: - New Post Form
    private var newPostForm: some View {
        VStack(spacing: 20) {
            // Photo Picker with improved styling
            sectionContainer {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        // Show the selected image
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        // Use ContentUnavailableView as the placeholder
                        ContentUnavailableView("Tap to add a photo", systemImage: "photo")
                            .frame(height: 200)
                            .background(Color(UIColor.systemBackground).opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .onChange(of: selectedItem) { _, newValue in
                    Task {
                        if let data = try? await newValue?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            }
            
            // Title & Description
            sectionContainer {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Details")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(.body, design: .rounded))
                    
                    TextField("Description", text: $foodDescription, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(.body, design: .rounded))
                        .lineLimit(3...6)
                }
            }
            
            // Preferences section
            sectionContainer {
                VStack(alignment: .leading, spacing: 16) {
                    // Segmented control for Non-Veg / Veg
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dietary Preference")
                            .font(.system(.headline, design: .rounded))
                        
                        Picker("Dietary Preference", selection: $vegValue) {
                            Text("Non-Veg").tag(0)
                            Text("Veg").tag(1)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // Serving size
                    HStack {
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.blue)
                        Stepper("Serves \(servingSize)", value: $servingSize, in: 1...20)
                    }
                }
            }
            
            // Location section
            sectionContainer {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Location")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    
                    // Location display
                    if let location = location {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.blue)
                            Text(location.address)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.secondary)
                            Spacer()
                            Button("Change") {
                                showingLocationPicker = true
                            }
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.blue)
                        }
                    } else {
                        Button {
                            showingLocationPicker = true
                        } label: {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                                Text("Select Location")
                                    .font(.system(.body, design: .rounded))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            
            // Availability section
            sectionContainer {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Availability")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                        Stepper("Available for \(expirationHours) hours", value: $expirationHours, in: 1...24)
                    }
                }
            }
            
            // Share Food button
            Button {
                createPost()
            } label: {
                Text("Share Food")
                    .font(.system(.headline, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(title.isEmpty || foodDescription.isEmpty ? Color.gray : Color.blue)
                    )
                    .foregroundColor(.white)
            }
            .disabled(title.isEmpty || foodDescription.isEmpty)
            .padding(.top, 8)
        }
        .padding(.vertical)
    }
    
    // Helper function to create consistent section containers
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(16)
            .background(
                ZStack {
                    // Base layer with blur
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colorScheme == .dark ? 
                              Color(UIColor.systemBackground).opacity(0.2) : 
                              Color(UIColor.systemBackground).opacity(0.8))
                        .blur(radius: colorScheme == .dark ? 0.5 : 0)
                    
                    // Glassmorphism effect
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colorScheme == .dark ? 
                              Color(hex: "1E1E1E").opacity(0.7) : 
                              Color(UIColor.systemBackground).opacity(0.8))
                }
                .shadow(color: colorScheme == .dark ? 
                       Color.black.opacity(0.25) : 
                       Color.black.opacity(0.1), 
                       radius: colorScheme == .dark ? 15 : 10, x: 0, y: 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(colorScheme == .dark ? 
                           Color.white.opacity(0.08) : 
                           Color.white.opacity(0.2), lineWidth: 1)
            )
    }
    
    // MARK: - Create Post
    private func createPost() {
        // Example placeholder for image URL
        let imageURL: URL? = nil
        
        // Build a new FoodPost
        let post = FoodPost(
            title: title,
            foodDescription: foodDescription,
            imageURL: imageURL,
            isVegetarian: (vegValue == 1),  // 0 = Non-Veg, 1 = Veg
            servingSize: servingSize,
            location: location ?? Location(latitude: 0, longitude: 0, address: "No location"),
            expirationDate: Calendar.current.date(byAdding: .hour, value: expirationHours, to: Date()) ?? Date(),
            userId: "user123"
        )
        
        // Insert & save
        modelContext.insert(post)
        try? modelContext.save()
        
        // Reset the form
        title = ""
        foodDescription = ""
        selectedItem = nil
        selectedImageData = nil
        vegValue = 0
        servingSize = 2
        expirationHours = 4
        isNewPostExpanded = false
    }
}

// MARK: - LocationHeader
struct LocationHeader: View {
    let location: Location
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(colorScheme == .dark ? Color.blue.opacity(0.9) : .blue)
                .opacity(isAnimating ? 1 : 0.7)
                .scaleEffect(isAnimating ? 1 : 0.9)
            Text(location.address)
                .font(.system(.subheadline, design: .rounded))
                .opacity(isAnimating ? 1 : 0.7)
            Spacer()
        }
        .padding()
        .background(
            ZStack {
                // Base blur effect
                RoundedRectangle(cornerRadius: 15)
                    .fill(colorScheme == .dark ? 
                          Color(UIColor.systemBackground).opacity(0.2) : 
                          Color(UIColor.systemBackground).opacity(0.8))
                    .blur(radius: colorScheme == .dark ? 0.5 : 0)
                
                // Glassmorphism effect
                RoundedRectangle(cornerRadius: 15)
                    .fill(colorScheme == .dark ? 
                          Color(hex: "1E1E1E").opacity(0.7) : 
                          Color(UIColor.systemBackground).opacity(0.8))
            }
            .shadow(color: colorScheme == .dark ? 
                   Color.black.opacity(0.2) : 
                   Color.black.opacity(0.05), 
                   radius: colorScheme == .dark ? 10 : 5, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(colorScheme == .dark ? 
                       Color.white.opacity(0.08) : 
                       Color.white.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
        .padding(.top, 8)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                isAnimating = true
            }
        }
    }
}

// MARK: - FoodPostCard
struct FoodPostCard: View {
    let post: FoodPost
    @State private var isHovered = false
    @State private var isPressed = false
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Image section with improved styling for dark mode
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(colorScheme == .dark ? Color.gray.opacity(0.15) : Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(colorScheme == .dark ? Color.gray.opacity(0.7) : .gray)
                        )
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            
            // Content section with improved typography
            VStack(alignment: .leading, spacing: 12) {
                // Title with subtle animation
                Text(post.title)
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                // Description with improved styling
                Text(post.foodDescription)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                // Metadata section with icons
                HStack(spacing: 16) {
                    // Vegetarian indicator
                    Label(
                        post.isVegetarian ? "Vegetarian" : "Non-Vegetarian",
                        systemImage: post.isVegetarian ? "leaf.fill" : "fork.knife"
                    )
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(post.isVegetarian ? .green : .orange)
                    
                    // Serving size
                    Label(
                        "Serves \(post.servingSize)",
                        systemImage: "person.2.fill"
                    )
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.blue)
                    
                    // Expiration countdown
                    Label(
                        expirationText(for: post),
                        systemImage: "clock.fill"
                    )
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(expirationColor(for: post))
                }
                .padding(.top, 4)
                
                // Location with map pin icon
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                    Text(post.location.address)
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(
            ZStack {
                // Base layer with blur for dark mode
                RoundedRectangle(cornerRadius: 25)
                    .fill(colorScheme == .dark ? 
                          Color(UIColor.systemBackground).opacity(0.2) : 
                          Color(UIColor.systemBackground).opacity(0.8))
                    .blur(radius: colorScheme == .dark ? 0.5 : 0)
                
                // Glassmorphism effect
                RoundedRectangle(cornerRadius: 25)
                    .fill(colorScheme == .dark ? 
                          Color(hex: "1E1E1E").opacity(0.7) : 
                          Color(UIColor.systemBackground).opacity(0.8))
            }
            .shadow(color: colorScheme == .dark ? 
                   Color.black.opacity(0.25) : 
                   Color.black.opacity(0.1), 
                   radius: colorScheme == .dark ? 15 : 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(colorScheme == .dark ? 
                       Color.white.opacity(0.08) : 
                       Color.white.opacity(0.2), lineWidth: 1)
        )
        .scaleEffect(isPressed ? 0.98 : 1)
        .animation(.spring(response: 0.3), value: isPressed)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.7).delay(0.1)) {
                isAnimating = true
            }
        }
    }
    
    // Helper function to format expiration text
    private func expirationText(for post: FoodPost) -> String {
        let timeRemaining = post.expirationDate.timeIntervalSince(Date())
        
        if timeRemaining <= 0 {
            return "Expired"
        }
        
        let hoursRemaining = Int(timeRemaining / 3600)
        if hoursRemaining < 1 {
            let minutesRemaining = Int(timeRemaining / 60)
            return "\(minutesRemaining)m left"
        } else {
            return "\(hoursRemaining)h left"
        }
    }
    
    // Helper function to determine expiration color
    private func expirationColor(for post: FoodPost) -> Color {
        let timeRemaining = post.expirationDate.timeIntervalSince(Date())
        
        if timeRemaining <= 0 {
            return .red
        } else if timeRemaining < 3600 { // Less than 1 hour
            return .orange
        } else if timeRemaining < 7200 { // Less than 2 hours
            return .yellow
        } else {
            return .green
        }
    }
}
