//
//  SearchMovieViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/03.
//

import UIKit
import WebKit

class SearchMovieViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://m.naver.com"
        guard let url = URL(string: urlString) else { return }
        guard
            let koUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let koUrl = URL(string: koUrlString)
        else { return }
        
        let request = URLRequest(url: koUrl)
        webView.load(request)
    }
}
