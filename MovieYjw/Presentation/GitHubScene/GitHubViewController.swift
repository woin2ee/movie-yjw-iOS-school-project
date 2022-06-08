//
//  GitHubViewController.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/08.
//

import UIKit
import WebKit

class GitHubViewController: UIViewController, DefaultWebView {
    let defaultUrlString: String = "https://github.com"
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultPage()
    }
}
