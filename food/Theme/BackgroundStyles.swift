import SwiftUI

struct BackgroundStyles {
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Card Backgrounds
    
    var filterCardBackground: some View {
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
    }
    
    var toggleBackground: some View {
        ZStack {
            // Base blur effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(UIColor.systemBackground).opacity(0.2) : 
                      Color(UIColor.systemBackground).opacity(0.7))
                .blur(radius: colorScheme == .dark ? 0.5 : 0)
            
            // Glassmorphism effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(hex: "1E1E1E").opacity(0.7) : 
                      Color(UIColor.systemBackground).opacity(0.7))
        }
    }
    
    var pickerBackground: some View {
        ZStack {
            // Base blur effect
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? 
                      Color(UIColor.systemBackground).opacity(0.2) : 
                      Color(UIColor.systemBackground).opacity(0.7))
                .blur(radius: colorScheme == .dark ? 0.5 : 0)
            
            // Glassmorphism effect
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? 
                      Color(hex: "1E1E1E").opacity(0.7) : 
                      Color(UIColor.systemBackground).opacity(0.7))
        }
    }
    
    var stepperBackground: some View {
        ZStack {
            // Base blur effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(UIColor.systemBackground).opacity(0.2) : 
                      Color(UIColor.systemBackground).opacity(0.7))
                .blur(radius: colorScheme == .dark ? 0.5 : 0)
            
            // Glassmorphism effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(hex: "1E1E1E").opacity(0.7) : 
                      Color(UIColor.systemBackground).opacity(0.7))
        }
    }
    
    var searchResultBackground: some View {
        ZStack {
            // Base blur effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(UIColor.systemBackground).opacity(0.2) : 
                      Color(UIColor.systemBackground).opacity(0.5))
                .blur(radius: colorScheme == .dark ? 0.5 : 0)
            
            // Glassmorphism effect
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? 
                      Color(hex: "1E1E1E").opacity(0.7) : 
                      Color(UIColor.systemBackground).opacity(0.5))
        }
        .shadow(color: colorScheme == .dark ? 
               Color.black.opacity(0.2) : 
               Color.black.opacity(0.05), 
               radius: colorScheme == .dark ? 10 : 5, x: 0, y: 2)
    }
}