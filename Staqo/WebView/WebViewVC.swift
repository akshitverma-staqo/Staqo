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
        loaderView.isHidden = true
        //SVProgressHUD.show()
        //SVProgressHUD.setRingRadius(2.0)
        
        webView.navigationDelegate = self
        //let url = URL(string: Constant.kOQPORTAL_LINK)
       
       //let url = URL(string: "signnow-private-cloud://sso_login?refresh_token=" + UserDefaults.standard.getAccessToken() + "&access_token="  + UserDefaults.standard.getAccessToken() + "&hostname=https://esign.oq.com")
        
        
        
        
        
        
        
        
        
        //let param = "MyParam"
        //webView.evaluateJavaScript("redirectToApp(\"hello world\")", completionHandler: nil)

        //webView.stringByEvaluatingJavaScriptFromString("redirectToApp('\(param)')")
        
        webView.evaluateJavaScript("redirectToApp(\(UserDefaults.standard.getAccessToken())), \(UserDefaults.standard.getAccessToken())")  { (result, error) in
                        guard error == nil else {
                            print("there was an error")
                            return
                        }

                        //print(Int(result))
                    }
        
        
       // print(url as Any)
        //loadURL(url: url!)
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
