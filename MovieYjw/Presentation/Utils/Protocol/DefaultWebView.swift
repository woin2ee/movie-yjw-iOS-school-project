//
//  DefaultWebView.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/08.
//

import Foundation
import WebKit

protocol DefaultWebView {
    var webView: WKWebView! { get }
    var defaultUrlString: String { get }
    
    func loadDefaultPage()
}

extension DefaultWebView {
    func loadDefaultPage() {
        guard let url = URL(string: defaultUrlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
