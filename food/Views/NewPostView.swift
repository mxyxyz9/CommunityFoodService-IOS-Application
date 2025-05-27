import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    @State private var title = ""
    @State private var foodDescription = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var isVegetarian = false
    @State private var servingSize = 2
    @State private var expirationHours = 4
    
    // TODO: Replace with actual user location
    let location = Location(latitude: 37.7749, longitude: -122.4194, address: "San Francisco, CA")
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                
                ScrollView {
                    VStack(spacing: 20) {
                        photoPickerSection
                        detailsSection
                        preferencesSection
                        locationSection
                        availabilitySection
                    }
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        createPost()
                    }
                    .disabled(title.isEmpty || foodDescription.isEmpty)
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
    }
    
    // MARK: - UI Components
    
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                colorScheme == .dark ? Color(hex: "1A1A1A") : Color(hex: "F5F5F5"),
                colorScheme == .dark ? Color(hex: "2A2A2A") : Color(hex: "FFFFFF")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var photoPickerSection: some View {
        sectionContainer {
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        ContentUnavailableView("Tap to add a photo", systemImage: "photo")
                            .frame(height: 200)
                            .background(Color(UIColor.systemBackground).opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .padding(16)
        }
    }
    
    private var detailsSection: some View {
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
            .padding(16)
        }
    }
    
    private var preferencesSection: some View {
        sectionContainer {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: isVegetarian ? "leaf.fill" : "fork.knife")
                        .foregroundColor(isVegetarian ? .green : .orange)
                    Toggle("Vegetarian", isOn: $isVegetarian)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                }
                
                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.blue)
                    Stepper("Serves \(servingSize)", value: $servingSize, in: 1...20)
                }
            }
            .padding(16)
        }
    }
    
    private var locationSection: some View {
        sectionContainer {
            VStack(alignment: .leading, spacing: 16) {
                Text("Location")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text(location.address)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
            .padding(16)
        }
    }
    
    private var availabilitySection: some View {
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
            .padding(16)
        }
    }
    
    // Helper function to create consistent section containers
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(UIColor.systemBackground).opacity(0.8))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal)
    }
    
    // MARK: - Actions
    
    private func createPost() {
        // TODO: Upload image and get URL
        let imageURL: URL? = nil
        
        let post = FoodPost(
            title: title,
            foodDescription: foodDescription,
            imageURL: imageURL,
            isVegetarian: isVegetarian,
            servingSize: servingSize,
            location: location,
            expirationDate: Calendar.current.date(byAdding: .hour, value: expirationHours, to: Date()) ?? Date(),
            userId: "user123" // TODO: Replace with actual user ID
        )
        
        modelContext.insert(post)
        
        try? modelContext.save()
        dismiss()
    }
}
