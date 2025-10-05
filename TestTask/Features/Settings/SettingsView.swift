//
//  SettingsView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm: SettingsViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Тема") {
                    Picker("Тема", selection: Binding(
                        get: { vm.selected },
                        set: { vm.set($0) }
                    )) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.title).tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Настройки")
        }
    }
}
