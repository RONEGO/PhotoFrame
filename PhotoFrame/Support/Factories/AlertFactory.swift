//
//  AlertFactory.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

final class AlertFactory {
	enum alertType {
		case openAppSettings(title: String)
		case actionAlert(title: String,
						 actionTitle: String,
						 actionHandler: ((UIAlertAction) -> Void) )
		case showError(error: Error)
		case timerMessage(message: String)
	}
	
	
	// MARK: - Class functions
	class func create(of type: alertType) -> UIAlertController {
		
		switch type {
		case .openAppSettings(let title):
			let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
			alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
				guard let urlSettings = URL(string: UIApplication.openSettingsURLString) else {
					return
				}
				UIApplication.shared.open(urlSettings)
			}))
			return alert
			
		case .showError(let error):
			let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Close", style: .destructive))
			
			return alert
			
		case .timerMessage(let message):
			let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
				alert.dismiss(animated: true)
			}
			
			return alert
			
		case .actionAlert(let title, let actionTitle, let actionHandler):
			let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
			alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: actionHandler))
			
			return alert
			
		}
		
	}
}
