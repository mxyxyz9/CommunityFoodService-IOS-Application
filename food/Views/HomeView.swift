import SwiftUI
import SwiftData
import PhotosUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var foodPosts: [FoodPost]
    @State private var isNewPostExpanded = false
    @State private var location: Location?
    
    // New post form states
    @State private var title = ""
    @State private var foodDescription = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var isVegetarian = false
    @State private var servingSize = 2
    @State private var expirationHours = 4
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if let location = location {
                    LocationHeader(location: location)
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        DisclosureGroup(
                            isExpanded: $isNewPostExpanded,
                            content: {
                                newPostForm
                            },
                            label: {
                                Label("Share Food", systemImage: "plus.circle.fill")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                            }
                        )
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        ForEach(foodPosts) { post in
                            FoodPostCard(post: post)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Food Share")
        }
        .onAppear {
            // TODO: Implement location fetching
            self.location = Location(latitude: 37.7749, longitude: -122.4194, address: "San Francisco, CA")
        }
    }
    
    private var newPostForm: some View {
        VStack(spacing: 16) {
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
            
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            
            TextField("Description", text: $foodDescription, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(3...6)
            
            Toggle("Vegetarian", isOn: $isVegetarian)
            
            Stepper("Serves \(servingSize)", value: $servingSize, in: 1...20)
            
            if let location = location {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text(location.address)
                        .foregroundColor(.secondary)
                }
            }
            
            Stepper("Available for \(expirationHours) hours", value: $expirationHours, in: 1...24)
            
            Button(action: createPost) {
                Text("Share Food")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(title.isEmpty || foodDescription.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(title.isEmpty || foodDescription.isEmpty)
        }
        .padding(.top)
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
            location: location ?? Location(latitude: 37.7749, longitude: -122.4194, address: "San Francisco, CA"),
            expirationDate: Calendar.current.date(byAdding: .hour, value: expirationHours, to: Date()) ?? Date(),
            userId: "user123" // TODO: Replace with actual user ID
        )
        
        modelContext.insert(post)
        try? modelContext.save()
        
        // Reset form
        title = ""
        foodDescription = ""
        selectedItem = nil
        selectedImageData = nil
        isVegetarian = false
        servingSize = 2
        expirationHours = 4
        isNewPostExpanded = false
    }
}

struct LocationHeader: View {
    let location: Location
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            Text(location.address)
                .font(.subheadline)
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct FoodPostCard: View {
    let post: FoodPost
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = post.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(post.foodDescription)
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                Label("\(post.servingSize) servings", systemImage: "person.2.fill")
                Spacer()
                Label(post.isVegetarian ? "Veg" : "Non-Veg", 
                      systemImage: post.isVegetarian ? "leaf.fill" : "fork.knife")
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2)
    }
}
