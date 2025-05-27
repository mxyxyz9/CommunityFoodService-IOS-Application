import SwiftUI

struct CustomTabContainer<Content: View>: View {
    @Binding var selectedTab: Int
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                content
            }
            .ignoresSafeArea(edges: .bottom)
            
            // Custom Tab Bar
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 8) // Add some padding from the bottom of the screen
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// Preview provider
struct CustomTabContainer_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabContainer(selectedTab: .constant(0)) {
            Text("Home")
                .tag(0)
            
            Text("Search")
                .tag(1)
            
            Text("Profile")
                .tag(2)
        }
    }
}