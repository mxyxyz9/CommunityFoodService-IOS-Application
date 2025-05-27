import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        CustomTabContainer(selectedTab: $selectedTab) {
            HomeView()
                .tag(0)
            
            SearchView()
                .tag(1)
            
            ProfileView()
                .tag(2)
        }
        // Hide the default tab bar since we're using our custom one
        .onAppear {
            // Hide the standard tab bar
            UITabBar.appearance().isHidden = true
        }
    }
}

// Preview provider
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
