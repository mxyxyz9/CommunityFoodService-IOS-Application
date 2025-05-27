import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchText = ""
    @State private var isVegetarianOnly = false
    @State private var selectedDistance = 5
    @State private var minimumServings = 1
    @State private var isAnimating = false
    
    let distanceOptions = [1, 2, 5, 10]
    
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
                                .fill(Color.purple.opacity(0.05))
                                .frame(width: 250, height: 250)
                                .blur(radius: 70)
                                .offset(x: -120, y: -50)
                            Circle()
                                .fill(Color.blue.opacity(0.05))
                                .frame(width: 300, height: 300)
                                .blur(radius: 80)
                                .offset(x: 150, y: 100)
                        } : nil
                )
                .ignoresSafeArea()
                
                // Main content
                ScrollView {
                    VStack(spacing: 20) {
                        // The filter card with glassmorphism effect
                        SearchFilters(
                            isVegetarianOnly: $isVegetarianOnly,
                            selectedDistance: $selectedDistance,
                            minimumServings: $minimumServings,
                            distanceOptions: distanceOptions
                        )
                        .padding(.horizontal)
                        .background(BackgroundStyles().filterCardBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(colorScheme == .dark ? 
                                       Color.white.opacity(0.08) : 
                                       Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        
                        // Placeholder for search results with enhanced animation for dark mode
                        Text("Search results will appear here")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? Color.secondary.opacity(0.9) : .secondary)
                            .padding()
                            .background(BackgroundStyles().searchResultBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(colorScheme == .dark ? 
                                           Color.white.opacity(0.08) : 
                                           Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .scaleEffect(isAnimating ? 1.02 : 1)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                            .onAppear { isAnimating = true }
                        
                        Spacer()
                    }
                    .padding(.top)
                }
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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            // Vegetarian Toggle with enhanced styling for dark mode
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundColor(.green)
                    .opacity(colorScheme == .dark ? 0.9 : 1)
                Toggle("Vegetarian Only", isOn: $isVegetarianOnly)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(BackgroundStyles().toggleBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(colorScheme == .dark ? 
                           Color.white.opacity(0.08) : 
                           Color.white.opacity(0.2), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            // Distance Picker with modern styling for dark mode
            VStack(alignment: .leading, spacing: 10) {
                Text("Distance")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color.secondary.opacity(0.9) : .secondary)
                
                Picker("Distance", selection: $selectedDistance) {
                    ForEach(distanceOptions, id: \.self) { distance in
                        Text("\(distance) km")
                            .tag(distance)
                    }
                }
                .pickerStyle(.segmented)
                .background(BackgroundStyles().pickerBackground
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(colorScheme == .dark ? 
                               Color.white.opacity(0.08) : 
                               Color.white.opacity(0.2), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Minimum Servings with custom styling for dark mode
            VStack(alignment: .leading, spacing: 10) {
                Text("Minimum Servings")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(colorScheme == .dark ? Color.secondary.opacity(0.9) : .secondary)
                
                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(colorScheme == .dark ? Color.blue.opacity(0.9) : .blue)
                    Stepper("Serves \(minimumServings)", value: $minimumServings, in: 1...20)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(BackgroundStyles().stepperBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(colorScheme == .dark ? 
                               Color.white.opacity(0.08) : 
                               Color.white.opacity(0.2), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding(20)
        // Apply enhanced glassmorphism effect for dark mode
        .background(
            ZStack {
                // Base layer with blur
                RoundedRectangle(cornerRadius: 25)
                    .fill(colorScheme == .dark ? 
                          Color(UIColor.systemBackground).opacity(0.15) : 
                          Color(UIColor.systemBackground).opacity(0.5))
                    .blur(radius: colorScheme == .dark ? 0.5 : 0)
                
                // Glassmorphism effect
                RoundedRectangle(cornerRadius: 25)
                    .fill(colorScheme == .dark ? 
                          Color(hex: "1E1E1E").opacity(0.6) : 
                          Color(UIColor.systemBackground).opacity(0.5))
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(colorScheme == .dark ? 
                                  Color(UIColor.systemBackground).opacity(0.2) : 
                                  Color(UIColor.systemBackground).opacity(0.3))
                            .blur(radius: colorScheme == .dark ? 15 : 10)
                    )
            }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(colorScheme == .dark ? 
                       Color.white.opacity(0.08) : 
                       Color.white.opacity(0.2), lineWidth: 1)
        )
        // Add a subtle shadow with dark mode enhancement
        .shadow(color: colorScheme == .dark ? 
               Color.black.opacity(0.2) : 
               Color.black.opacity(0.1), 
               radius: colorScheme == .dark ? 20 : 15, x: 0, y: 10)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
                .preferredColorScheme(.light)
            SearchView()
                .preferredColorScheme(.dark)
        }
    }
}
