import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
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
            Form {
                Section {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .frame(maxWidth: .infinity)
                        } else {
                            ContentUnavailableView("Tap to add a photo", systemImage: "photo")
                                .frame(height: 200)
                        }
                    }
                }
                
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $foodDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section {
                    Toggle("Vegetarian", isOn: $isVegetarian)
                    
                    Stepper("Serves \(servingSize)", value: $servingSize, in: 1...20)
                }
                
                Section("Location") {
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text(location.address)
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("Availability") {
                    Stepper("Available for \(expirationHours) hours", value: $expirationHours, in: 1...24)
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
