import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var searchText = ""
    @State private var isVegetarianOnly = false
    @State private var selectedDistance = 5
    @State private var minimumServings = 1
    
    let distanceOptions = [1, 2, 5, 10]
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchFilters(
                    isVegetarianOnly: $isVegetarianOnly,
                    selectedDistance: $selectedDistance,
                    minimumServings: $minimumServings,
                    distanceOptions: distanceOptions
                )
                
                // TODO: Implement search results
                Text("Search results will appear here")
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .searchable(text: $searchText, prompt: "Search for food")
            .navigationTitle("Search")
        }
    }
}

struct SearchFilters: View {
    @Binding var isVegetarianOnly: Bool
    @Binding var selectedDistance: Int
    @Binding var minimumServings: Int
    let distanceOptions: [Int]
    
    var body: some View {
        VStack(spacing: 16) {
            Toggle("Vegetarian Only", isOn: $isVegetarianOnly)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Distance")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Picker("Distance", selection: $selectedDistance) {
                    ForEach(distanceOptions, id: \.self) { distance in
                        Text("\(distance)km")
                            .tag(distance)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Minimum Servings")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Stepper("Serves \(minimumServings)", value: $minimumServings, in: 1...20)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
    }
}
