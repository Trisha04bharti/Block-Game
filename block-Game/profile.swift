//
//  profile.swift
//  block-Game
//
//  Created by Vikram Kumar on 14/03/26.
//

import SwiftUI

struct SettingsView: View {
    @State private var username = ""
    @State private var notificationsOn = true
    @State private var selectedTheme = 0
    @State private var quantity : Int = 0

    let themes = ["Light", "Dark", "System"]

    var body: some View {
        NavigationStack {
            Form {
                // Section 1 — Profile
                Section("Profile") {
                    TextField("Username", text: $username)
                }

                // Section 2 — Preferences
                Section("Preferences") {
                    Toggle("Notifications", isOn: $notificationsOn)

//                    Picker("Theme", selection: $selectedTheme) {
//                        ForEach(themes, id: \.self) { theme in
//                            Text(theme)
//                        }
//                    }
                    
                    Picker("Theme", selection: $selectedTheme) {
                        Text("Day").tag(0)
                        Text("Night").tag(1)
                        Text("Noon").tag(2)
                    }
                    .pickerStyle(.segmented)
                    
                    Section("Numbers") {
                           Stepper("Quantity: \(quantity)", value: $quantity, in: 1...99)
                       }
                    
                }

                // Section 3 — Action with footer note
                Section {
                    Button("Save Changes") {
                        print("Saved!")
                    }
                } footer: {
                    Text("Your preferences are saved locally on this device.")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
