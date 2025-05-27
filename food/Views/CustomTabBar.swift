import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Environment(\.colorScheme) var colorScheme
    
    // Tab items configuration
    let tabItems = [
        ("Home", "house.fill", "house"),
        ("Search", "magnifyingglass", "magnifyingglass"),
        ("Profile", "person.fill", "person")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabItems.count, id: \.self) { index in
                let item = tabItems[index]
                TabBarButton(
                    text: item.0,
                    icon: selectedTab == index ? item.1 : item.2,
                    isSelected: selectedTab == index,
                    action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = index
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(colorScheme == .dark ? 
                      Color(hex: "1E1E1E").opacity(0.9) : 
                      Color(UIColor.systemBackground).opacity(0.9))
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
        )
        .overlay(
            Capsule()
                .stroke(colorScheme == .dark ? 
                       Color.white.opacity(0.1) : 
                       Color.black.opacity(0.05), lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

struct TabBarButton: View {
    let text: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: isSelected ? 20 : 18))
                    .fontWeight(isSelected ? .bold : .regular)
                
                Text(text)
                    .font(.system(size: 12, weight: isSelected ? .semibold : .medium, design: .rounded))
            }
            .foregroundColor(isSelected ? 
                            (colorScheme == .dark ? Color.white : Color.blue) : 
                            (colorScheme == .dark ? Color.gray.opacity(0.7) : Color.gray))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                isSelected ?
                    Capsule()
                        .fill(colorScheme == .dark ? 
                              Color.blue.opacity(0.2) : 
                              Color.blue.opacity(0.1))
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2) : nil
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview provider
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBar(selectedTab: .constant(0))
        }
        .preferredColorScheme(.light)
        
        VStack {
            Spacer()
            CustomTabBar(selectedTab: .constant(1))
        }
        .preferredColorScheme(.dark)
    }
}