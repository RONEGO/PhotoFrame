//
//  TabBarViewController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		if let index = tabBar.items?.firstIndex(of: item) {
			if index == 0 {
				tabBar.tintColor	= .mainColor
			} else {
				tabBar.tintColor	= .supportColor
			}
		}
	}
}
