//
//  BrowserView.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI

struct BrowserView: View {
    @StateObject var vm: BrowserViewModel
    @Binding var currentTab: AppTab
    
    var body: some View {
        VStack(spacing: 0) {
            if vm.isLoading {
                ProgressView(value: vm.progress)
                    .progressViewStyle(.linear)
                    .animation(.easeOut(duration: 0.2), value: vm.progress)
                    .padding(.horizontal)
            }
            
            ZStack {
                WebViewWrapper(vm: vm)
                
                if vm.lastError != nil {
                    VStack(spacing: 12) {
                        Text("Не удалось загрузить")
                            .font(.headline)
                        Button("Повторить") {
                            vm.retry()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.background.opacity(0.9))
                }
            }
            
            HStack {
                Button { vm.back() } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!vm.canBack)
                
                Button { vm.forward() } label: {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!vm.canFwd)
                
                Button { vm.refresh() } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
                Spacer()
                
                Button { self.currentTab = .catalog } label: {
                    Text("Закрыть")
                }
            }
            .padding()
        }
        .navigationTitle("Google")
    }
}
