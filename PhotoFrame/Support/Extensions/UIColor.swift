//
//  UIColor.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

extension UIColor {
	
	// MARK: - Colors
	static let mainColor: UIColor 		= UIColor(red: 162, 	green: 89, 		blue: 172)
	static let supportColor: UIColor	= UIColor(red: 64, 		green: 144, 	blue: 99)
	
	// MARK: - Initializers
	convenience init(red: Int, green: Int, blue: Int) {
		let red: CGFloat 	= CGFloat(red) / 255.0
		let green: CGFloat 	= CGFloat(green) / 255.0
		let blue: CGFloat	= CGFloat(blue) / 255.0
		
		self.init(red: red,
				  green: green,
				  blue: blue,
				  alpha: 1.0)
	}
}
