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
    @Published var progrss: Double = 0
    
    var goBack: () -> Void = { }
    var goFwd: () -> Void = { }
    var reload: () -> Void = { }
    var loadStarted: () -> Void = { }
    
    let startURL = URL(string: "https://www.google.com")!
    
    func back() { goBack() }
    func forward() { goFwd() }
    func refresh() { reload() }

    func updateNavAvailability(from wv: WKWebView?) {
        guard let wv else { canBack = false; canFwd = false; return }
        canBack = wv.canGoBack
        canFwd = wv.canGoForward
    }
}
