//
//  MapViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/08.
//

import UIKit
import WebKit

class MapViewController: UIViewController, DefaultWebView {
    @IBOutlet weak var webView: WKWebView!
    
    let defaultUrlString = "https://m.naver.com"
    let urlString = "https://map.naver.com/v5/search/영화관"
    var encodedUrlString: String? {
        urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        guard
            let encodedUrlString = encodedUrlString,
            let url = URL(string: encodedUrlString)
        else {
            return loadDefaultPage()
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
