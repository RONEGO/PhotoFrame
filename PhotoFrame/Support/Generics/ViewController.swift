//
//  ViewController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

class ViewController<View: UIView>: UIViewController {
	// MARK: - Super properties
	open var fullScreen: Bool {
		return true
	}
	
	// MARK: - Public properties
	public var contentView: View!
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		contentView = View()
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(contentView)
		view.addConstraints([
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.topAnchor.constraint(equalTo: (fullScreen ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor))
		])
	}
}
