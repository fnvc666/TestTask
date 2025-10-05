//
//  WebViewWrapper.swift
//  TestTask
//
//  Created by Pavel Pavel on 05/10/2025.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    @ObservedObject var vm: BrowserViewModel
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: Context) -> WKWebView {
        let wv = WKWebView()
        context.coordinator.attach(webView: wv)
        
        Task { @MainActor in vm.beginLoading() }
        wv.load(URLRequest(url: vm.startURL))
        
        vm.goBack = { [weak wv, weak vm] in
            wv?.goBack()
            Task { @MainActor in vm?.updateNavAvailability(from: wv) }
        }
        
        vm.goFwd = { [weak wv, weak vm] in
            wv?.goForward()
            Task { @MainActor in vm?.updateNavAvailability(from: wv) }
        }
        
        vm.reload = { [weak wv] in wv?.reload() }
        
        vm.loadStarted = { [weak vm] in
            Task { @MainActor in
                vm?.beginLoading()
            }
        }
        
        return wv
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // MARK: - Coordinator
    final class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebViewWrapper
        private weak var webView: WKWebView?
        
        init(_ parent: WebViewWrapper) {
            self.parent = parent
        }
        
        func attach(webView: WKWebView) {
            self.webView = webView
            webView.navigationDelegate = self
        }
        
        // MARK: - Delegate
        func webView(_ webView: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.vm.beginLoading()
                self?.parent.vm.updateNavAvailability(from: webView)
            }
        }
        
        func webView(_ webView: WKWebView, didCommit: WKNavigation!) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.vm.setEstimatedProgress(0.5)
                self?.parent.vm.updateNavAvailability(from: webView)
            }
        }
        
        func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.vm.finishLoadingOK()
                self?.parent.vm.updateNavAvailability(from: webView)
            }
        }
        
        func webView(_ webView: WKWebView, didFail: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.vm.finishLoadingFail(error.localizedDescription)
                self?.parent.vm.updateNavAvailability(from: webView)
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.vm.finishLoadingFail(error.localizedDescription)
                self?.parent.vm.updateNavAvailability(from: webView)
            }
        }
    }
}
