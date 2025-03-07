//
//  LiliPrivacyPolicyViewController.swift
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//

import UIKit
import UIKit
import WebKit

class LiliPrivacyPolicyViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    @objc var url: String?
    let liliPrivacyUrlString = "https://www.termsfeed.com/live/359a631c-8a27-4b02-a933-e5ef3696f244"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        liliInitSubViews()
        liliInitWebView()
        cardessyStartLoadWebView()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    private func liliInitSubViews() {
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .black
        webView.backgroundColor = .black
        webView.isOpaque = false
        webView.scrollView.backgroundColor = .black
        indicatorView.hidesWhenStopped = true
        
        self.backBtn.isHidden = self.url != nil
    }

    private func liliInitWebView() {
        let userContentC = webView.configuration.userContentController
        
        // afevent
        userContentC.add(self, name: "trackWebEventToAF")
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    private func cardessyStartLoadWebView() {
        let urlStr = url ?? liliPrivacyUrlString
        guard let url = URL(string: urlStr) else { return }
        
        indicatorView.startAnimating()
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "trackWebEventToAF" {
            if let dic = message.body as? [String: Any], let event = dic["event"] as? String {
                let da = UserDefaults.standard.value(forKey: "adsData") as? [String] ?? Array()
                if event == da[7], let ur = dic["data"] as? String, let url = URL(string: ur) {
                    UIApplication.shared.open(url)
                } else {
                    liliLogEvent(event, data: dic["data"] as? [String: Any] ?? Dictionary())
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
    
    // MARK: - WKUIDelegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil, let url = navigationAction.request.url {
            UIApplication.shared.open(url)
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
