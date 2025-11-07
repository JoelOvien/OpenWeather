//
//  ViewController.swift
//  OpenWeather
//
//  Created by Joel Ovienloba on 07/11/2025.
//

import UIKit

class SplashViewController: UIViewController {
	
	// MARK: - UI Elements
	@IBOutlet weak var appNameLabel: UILabel!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		navigateToHome()
	}
	
	// MARK: - Setup
	private func setupUI() {
		view.backgroundColor = UIColor.systemBlue
		appNameLabel?.text = "Weather App"
		appNameLabel?.textColor = .white
		appNameLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
		
		activityIndicator?.color = .white
		activityIndicator?.startAnimating()
	}
	
	// MARK: - Navigation
	private func navigateToHome() {
		DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.splashDuration) { [weak self] in
			self?.performSegue(withIdentifier: "showHome", sender: nil)
		}
	}
}



