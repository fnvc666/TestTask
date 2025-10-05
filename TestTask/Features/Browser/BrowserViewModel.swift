//
//  BrowserViewModel.swift
//  TestTask
//
//  Created by Pavel Pavel on 04/10/2025.
//

import SwiftUI
import WebKit

final class BrowserViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var canBack = false
    @Published var canFwd = false
    @Published var progress: Double = 0
    @Published var lastError: String? = nil
    
    var goBack: () -> Void = { }
    var goFwd: () -> Void = { }
    var reload: () -> Void = { }
    var loadStarted: () -> Void = { }
    
    let startURL = URL(string: "https://www.google.com")!
    
    func back() { goBack() }
    func forward() { goFwd() }
    func refresh() { reload() }
    
    func retry() {
        lastError = nil
        reload()
    }
    
    func updateNavAvailability(from wv: WKWebView?) {
        guard let wv else { canBack = false; canFwd = false; return }
        canBack = wv.canGoBack
        canFwd = wv.canGoForward
    }
    
    func beginLoading() {
        isLoading = true
        lastError = nil
        progress = 0.1
    }
    
    func setEstimatedProgress(_ p: Double) {
        withAnimation(.easeOut(duration: 0.2)) {
            progress = p
        }
    }
    
    func finishLoadingOK() {
        withAnimation(.easeOut(duration: 0.3)) {
            progress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            withAnimation(.easeIn(duration: 0.2)) {
                self?.isLoading = false
                self?.progress = 0
            }
        }
    }
    
    func finishLoadingFail(_ message: String) {
        lastError = message
        isLoading = false
        progress = 0
    }
}
