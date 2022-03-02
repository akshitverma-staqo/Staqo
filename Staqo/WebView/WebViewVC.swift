//
//  WebViewVC.swift
//  OQ
//
//  Created by Bennett University on 21/01/21.
//

import UIKit
import WebKit
import MSAL

import ANActivityIndicator

class WebViewVC: UIViewController, UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate {
    @IBOutlet weak var lblLinkRedirect: UILabel!
    @IBOutlet weak var webView: WKWebView!
    weak var timer: Timer?
    @IBOutlet weak var loaderView: UIView!
    var header:HeaderView!
    @IBOutlet weak var herderView: HeaderView!
    @IBOutlet weak var loaderImage: UIImageView!
    var url: URL!
    var linkName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        header = HeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:70))
        header.delegate = self
        herderView.addSubview(header)
        loaderView.isHidden = false
        webView.uiDelegate = self
        loaderView.layer.cornerRadius = 10
        lblLinkRedirect.text = linkName
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        DispatchQueue.main.async {
            ANActivityIndicatorPresenter.shared.showIndicator(CGSize(width: 50, height: 50), message: "", messageFont: UIFont.systemFont(ofSize: 14), messageTopMargin: 2, animationType: .ballBeat, color: UIColor(red: 27.0/255, green: 173.0/255, blue: 185.0/255, alpha: 1.0), padding: 2, displayTimeThreshold: nil, minimumDisplayTime: nil)
            self.timer = Timer.scheduledTimer(timeInterval: 40.0, target: self, selector: #selector(self.sayLoader), userInfo: nil, repeats: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        header.BtnMenu.setImage(UIImage(named: "backArrow"), for: .normal)
        header.btnProfile.isHidden = true
        header.btnLogout.isHidden = true
        header.btnNotiyCount.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frame = navigationAction.targetFrame,
           frame.isMainFrame {print("click1")
            return nil
        }
        print("click2")
        ANActivityIndicatorPresenter.shared.showIndicator(CGSize(width: 50, height: 50), message: "", messageFont: UIFont.systemFont(ofSize: 14), messageTopMargin: 2, animationType: .ballBeat, color: UIColor(red: 27.0/255, green: 173.0/255, blue: 185.0/255, alpha: 1.0), padding: 2, displayTimeThreshold: nil, minimumDisplayTime: nil)
        self.loaderView.isHidden=false
        webView.load(navigationAction.request)
        return nil
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            loaderView.isHidden = webView.estimatedProgress == 1
            //ActivityIndicator.sharedInstance.hideActivityIndicator() = webView.estimatedProgress == 1
            if webView.estimatedProgress == 1{
                ANActivityIndicatorPresenter.shared.hideIndicator()
                webView.isHidden = false
            }
            
            print("stop loading")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish loading")
        ANActivityIndicatorPresenter.shared.hideIndicator()
        self.loaderView.isHidden = true
        DispatchQueue.main.async {
            //ANActivityIndicatorPresenter.shared.showIndicator()
            ANActivityIndicatorPresenter.shared.hideIndicator()
            self.loaderView.isHidden = true
        }
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Set the indicator everytime webView started loading
        print("start loading")
        DispatchQueue.main.async {
            //ANActivityIndicatorPresenter.shared.showIndicator()
            ANActivityIndicatorPresenter.shared.showIndicator(CGSize(width: 50, height: 50), message: "", messageFont: UIFont.systemFont(ofSize: 14), messageTopMargin: 2, animationType: .ballBeat, color: UIColor(red: 27.0/255, green: 173.0/255, blue: 185.0/255, alpha: 1.0), padding: 2, displayTimeThreshold: nil, minimumDisplayTime: nil)
        }
        
        
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("faild loading")
        DispatchQueue.main.async {
            //ANActivityIndicatorPresenter.shared.showIndicator()
            ANActivityIndicatorPresenter.shared.hideIndicator()
            self.loaderView.isHidden = true
        }
    }
    
    
    
    @objc func sayLoader()
    {
        NSLog("Stop loader...")
        DispatchQueue.main.async {
            //ANActivityIndicatorPresenter.shared.showIndicator()
            ANActivityIndicatorPresenter.shared.hideIndicator()
            self.loaderView.isHidden = true
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
    
  
    
}

extension WebViewVC: HeaderViewDelegate{
    func btnMenuTapped(sender: UIButton) {
        timer?.invalidate()
        _ = navigationController?.popViewController(animated: true)

    }
    
    func btnProfileTapped(sender: UIButton) {
        timer?.invalidate()
        let vc = Constant.getViewController(storyboard: Constant.kHomeStoryboard, identifier: Constant.kEmpVC, type: EmpVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func btnLogoutTapped(sender: UIButton) {
        timer?.invalidate()
        
        let vc = Constant.getViewController(storyboard: Constant.kNotification, identifier: Constant.kNotificationVC, type: NotificationVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
