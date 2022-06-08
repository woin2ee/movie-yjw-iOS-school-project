//
//  SearchMovieViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/03.
//

import UIKit
import WebKit

class SearchMovieViewController: UIViewController, DefaultWebView {
    @IBOutlet weak var webView: WKWebView!
    
    let defaultUrlString = "https://m.naver.com"
    var movieName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadWebView() {
        guard let movieName = movieName else {
            return loadDefaultPage()
        }
        
        let searchUrlString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=\(movieName)"
        guard
            let encodedSearchUrlString = searchUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedSearchUrlString)
        else {
            return loadDefaultPage()
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
