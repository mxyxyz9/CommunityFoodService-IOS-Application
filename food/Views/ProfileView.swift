import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingSettings = false
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false

    // TODO: Replace with actual user data
    let mockUser = (
        name: "John Doe",
        streak: 7,
        totalDonations: 15
    )

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
                                .frame(width: 250, height: 250)
                                .blur(radius: 70)
                                .offset(x: -120, y: -50)
                            Circle()
                                .fill(Color.purple.opacity(0.05))
                                .frame(width: 300, height: 300)
                                .blur(radius: 80)
                                .offset(x: 150, y: 100)
                        } : nil
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Profile header with glassmorphism
                        profileHeaderSection
                        
                        // Statistics section
                        statisticsSection
                        
                        // Preferences section
                        preferencesSection
                        
                        // Sign out button
                        signOutButton
                    }
                    .padding(.top)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Profile")
        }
        // Apply the preferred color scheme based on the toggle state
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6)) {
                isAnimating = true
            }
        }
    }
    
    // MARK: - UI Components
    
    // MARK: - Reusable Background Components
    private var profileHeaderBackground: some View {
        // Extract the complex background into a separate view
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
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private var statisticsSectionBackground: some View {
        // Reusable background for statistics and preferences sections
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
    
    private var settingsSectionBackground: some View {
        // Reusable background for settings sections
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
    
    private var profileHeaderSection: some View {
        VStack {
            HStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(colorScheme == .dark ? 
                              Color.blue.opacity(0.15) : 
                              Color.blue.opacity(0.1))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 70))
                        .foregroundColor(colorScheme == .dark ? 
                                        Color.blue.opacity(0.9) : 
                                        .blue)
                }
                .scaleEffect(isAnimating ? 1 : 0.8)
                .opacity(isAnimating ? 1 : 0)
                .shadow(color: colorScheme == .dark ? 
                       Color.black.opacity(0.3) : 
                       Color.black.opacity(0.1), 
                       radius: colorScheme == .dark ? 10 : 5)

                VStack(alignment: .leading, spacing: 8) {
                    Text(mockUser.name)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .foregroundColor(colorScheme == .dark ? 
                                           Color.orange.opacity(0.9) : 
                                           .orange)
                        Text("\(mockUser.streak) day streak")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(colorScheme == .dark ? 
                                           Color.secondary.opacity(0.9) : 
                                           .secondary)
                    }
                }
                .offset(x: isAnimating ? 0 : -20)
                .opacity(isAnimating ? 1 : 0)
                
                Spacer()
            }
            .padding(20)
        }
        .background(
            profileHeaderBackground
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Statistics Section
    private var statisticsSection: some View {
        VStack(spacing: 16) {
            Text("Statistics")
                .font(.system(.headline, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            VStack(spacing: 15) {
                // Donations stat
                HStack {
                    Image(systemName: "gift.fill")
                        .font(.system(size: 18))
                        .foregroundColor(colorScheme == .dark ? 
                                       Color.green.opacity(0.9) : 
                                       .green)
                        .frame(width: 30)
                    Text("Total Donations")
                        .font(.system(.body, design: .rounded))
                    Spacer()
                    Text("\(mockUser.totalDonations)")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.horizontal, 20)
                    .opacity(colorScheme == .dark ? 0.5 : 0.8)
                
                // Share streak button
                ShareStreakButton(streak: mockUser.streak)
            }
            .background(
                statisticsSectionBackground
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(colorScheme == .dark ? 
                           Color.white.opacity(0.08) : 
                           Color.white.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
    
    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack(spacing: 16) {
            Text("Preferences")
                .font(.system(.headline, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            VStack(spacing: 15) {
                // Dark mode toggle with enhanced styling
                HStack {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .font(.system(size: 18))
                        .foregroundColor(isDarkMode ? 
                                       (colorScheme == .dark ? Color.purple.opacity(0.9) : .purple) : 
                                       (colorScheme == .dark ? Color.orange.opacity(0.9) : .orange))
                        .frame(width: 30)
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .font(.system(.body, design: .rounded))
                        .toggleStyle(SwitchToggleStyle(tint: colorScheme == .dark ? 
                                                     Color.blue.opacity(0.9) : .blue))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.horizontal, 20)
                    .opacity(colorScheme == .dark ? 0.5 : 0.8)
                
                // Settings button with enhanced styling
                Button(action: { showingSettings = true }) {
                    HStack {
                        Image(systemName: "gear")
                            .font(.system(size: 18))
                            .foregroundColor(colorScheme == .dark ? 
                                           Color.blue.opacity(0.9) : 
                                           .blue)
                            .frame(width: 30)
                        Text("Settings")
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(colorScheme == .dark ? 
                                           Color.secondary.opacity(0.9) : 
                                           .secondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
            }
            .background(
                settingsSectionBackground
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(colorScheme == .dark ? 
                           Color.white.opacity(0.08) : 
                           Color.white.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
    
    // MARK: - Sign Out Button
    private var signOutButton: some View {
        Button(action: {
            // TODO: Implement sign out
        }) {
        HStack {
            Text("Sign Out")
                .font(.system(.body, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(colorScheme == .dark ? 
                               Color.red.opacity(0.9) : 
                               .red)
            Spacer()
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(colorScheme == .dark ? 
                               Color.red.opacity(0.9) : 
                               .red)
        }
        .padding(20)
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
        .padding(.horizontal)
    }
}

struct ShareStreakButton: View {
    let streak: Int
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            // TODO: Implement share functionality
        }) {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 18))
                    .foregroundColor(colorScheme == .dark ? 
                                   Color.blue.opacity(0.9) : 
                                   .blue)
                    .frame(width: 30)
                Text("Share Streak")
                    .font(.system(.body, design: .rounded))
                Spacer()
                Text("\(streak) days")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Background Views
    private var settingsSectionBackground: some View {
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
                                .frame(width: 250, height: 250)
                                .blur(radius: 70)
                                .offset(x: -120, y: -50)
                            Circle()
                                .fill(Color.purple.opacity(0.05))
                                .frame(width: 300, height: 300)
                                .blur(radius: 80)
                                .offset(x: 150, y: 100)
                        } : nil
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Account section
                        settingsSection(title: "Account") {
                            settingsLink(icon: "person.fill", title: "Update Profile") {
                                Text("Profile Update Form")
                            }
                            
                            Divider().padding(.horizontal)
                            
                            settingsLink(icon: "bell.fill", title: "Notification Preferences") {
                                Text("Notification Settings")
                            }
                        }
                        
                        // About section
                        settingsSection(title: "About") {
                            Link(destination: URL(string: "https://example.com/terms")!) {
                                settingsRow(icon: "doc.text.fill", title: "Terms of Service")
                            }
                            
                            Divider().padding(.horizontal)
                            
                            Link(destination: URL(string: "https://example.com/privacy")!) {
                                settingsRow(icon: "lock.shield.fill", title: "Privacy Policy")
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Helper function to create settings sections
    private func settingsSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                content()
            }
            .background(
                settingsSectionBackground
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(colorScheme == .dark ? 
                           Color.white.opacity(0.08) : 
                           Color.white.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
    

    
    // Helper function to create navigation links
    private func settingsLink<Destination: View>(icon: String, title: String, @ViewBuilder destination: () -> Destination) -> some View {
        NavigationLink(destination: destination()) {
            settingsRow(icon: icon, title: title)
        }
    }
    
    // Helper function to create consistent row styling
    private func settingsRow(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(colorScheme == .dark ? 
                               Color.blue.opacity(0.9) : 
                               .blue)
                .frame(width: 30)
            Text(title)
                .font(.system(.body, design: .rounded))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(colorScheme == .dark ? 
                               Color.secondary.opacity(0.9) : 
                               .secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}
}
