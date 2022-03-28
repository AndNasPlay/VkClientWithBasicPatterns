//
//  LoginViewController.swift
//  VkClientWithBasicPatterns
//
//  Created by Андрей Щекатунов on 22.09.2021.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKUIDelegate {

	private(set) lazy var webView: WKWebView = {
		let webConfiguration = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: webConfiguration)
		webView.uiDelegate = self
		webView.translatesAutoresizingMaskIntoConstraints = false
		return webView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		webView.navigationDelegate = self
		setupUI()
		self.navigationController?.navigationBar.isHidden = true
		var components = URLComponents()
		components.scheme = "https"
		components.host = "oauth.vk.com"
		components.path = "/authorize"
		components.queryItems = [
			URLQueryItem(name: "client_id", value: "7568757"),
			URLQueryItem(name: "scope", value: "262150"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
			URLQueryItem(name: "response_type", value: "token"),
			URLQueryItem(name: "v", value: "5.131")
		]
		guard let componentsUrl = components.url else { return }
		let request = URLRequest(url: componentsUrl)
		webView.load(request)
	}

	func setupUI() {
		self.view.backgroundColor = .white
		self.view.addSubview(webView)

		NSLayoutConstraint.activate([
			webView.topAnchor
				.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			webView.leftAnchor
				.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
			webView.bottomAnchor
				.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
			webView.rightAnchor
				.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
		])
	}
}

extension LoginViewController: WKNavigationDelegate {
	func webView(
		_ webView: WKWebView,
		decidePolicyFor navigationResponse: WKNavigationResponse,
		decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
	) {
		guard let url = navigationResponse.response.url,
			  url.path == "/blank.html",
			  let fragment = url.fragment else { decisionHandler(.allow); return }
		let params = fragment
			.components(separatedBy: "&")
			.map { $0.components(separatedBy: "=") }
			.reduce([String: String]()) { result, param in
				var dict = result
				let key = param[0]
				let value = param[1]
				dict[key] = value
				return dict
			}

		guard let token = params["access_token"],
			  let userIdString = params["user_id"],
			  let userIdInt = Int(userIdString) else {
			decisionHandler(.allow)
			return
		}

		UserSettings.shared.token = token
		UserSettings.shared.userId = userIdInt

		let vc = VkTabBarController()
		vc.modalPresentationStyle = .fullScreen
		self.present(vc, animated: true, completion: nil)

		decisionHandler(.cancel)
	}
}
