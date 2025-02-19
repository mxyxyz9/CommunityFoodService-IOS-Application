import SwiftUI

struct ProfileView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingSettings = false

    // TODO: Replace with actual user data
    let mockUser = (
        name: "John Doe",
        streak: 7,
        totalDonations: 15
    )

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)

                        VStack(alignment: .leading) {
                            Text(mockUser.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("🔥 \(mockUser.streak) day streak")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section("Statistics") {
                    HStack {
                        Image(systemName: "gift.fill")
                            .foregroundColor(.green)
                        Text("Total Donations")
                        Spacer()
                        Text("\(mockUser.totalDonations)")
                            .fontWeight(.semibold)
                    }

                    ShareStreakButton(streak: mockUser.streak)
                }

                Section("Preferences") {
                    Toggle("Dark Mode", isOn: $isDarkMode)

                    Button(action: { showingSettings = true }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
                }

                Section {
                    Button(action: {
                        // TODO: Implement sign out
                    }) {
                        HStack {
                            Text("Sign Out")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
        // Apply the preferred color scheme based on the toggle state
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}

struct ShareStreakButton: View {
    let streak: Int

    var body: some View {
        Button(action: {
            // TODO: Implement share functionality
        }) {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.blue)
                Text("Share Streak")
                Spacer()
                Text("\(streak) days")
                    .fontWeight(.semibold)
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    NavigationLink("Update Profile") {
                        Text("Profile Update Form")
                    }
                    NavigationLink("Notification Preferences") {
                        Text("Notification Settings")
                    }
                }

                Section("About") {
                    Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
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
}
