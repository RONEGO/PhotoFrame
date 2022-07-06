//
//  PhotosNavigationController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

final class PhotosNavigationController: UINavigationController {
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
		navigationBar.titleTextAttributes 	= [.foregroundColor: UIColor.black]
		navigationBar.barTintColor			= .white
		
		setNeedsStatusBarAppearanceUpdate()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
}
