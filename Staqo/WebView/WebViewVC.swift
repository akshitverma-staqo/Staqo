//
//  WebViewVC.swift
//  Staqo
//
//  Created by SHAILY on 26/02/21.
//

import UIKit
import WebKit
import SVProgressHUD

class WebViewVC: UIViewController {

    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderView.isHidden = false
        SVProgressHUD.show()
        SVProgressHUD.setRingRadius(2.0)
        
        webView.navigationDelegate = self
        let url = URL(string: Constant.kOQPORTAL_LINK)
        loadURL(url: url!)
    }
    func loadURL(url: URL) {
        webView.load(URLRequest(url: url))
        
    }
    

}
extension WebViewVC: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loaderView.isHidden = true

    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loaderView.isHidden = true

    }
}
