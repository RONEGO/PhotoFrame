//
//  File.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

extension ViewController {
	private var tagValue: Int {
		return 1001
	}
	
	func showAlertFormIfNeeded(title: String = "You don't have any uploaded photos :(",
							   subtitle: String,
							   backColor: UIColor ) {
		guard contentView.subviews.first(where: { $0.tag == tagValue }) == nil else {
			return
		}
		
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.tag = tagValue
		view.backgroundColor 	= backColor
		view.tintColor			= .white
		
		let height: CGFloat 	= 75
		let padding: CGFloat	= 25
		
		view.frame = CGRect(x: contentView.bounds.width * 0.05,
							y: contentView.bounds.height,
							width: contentView.bounds.width * 0.9,
							height: height)
		view.clipsToBounds = true
		view.layer.cornerRadius = height * 0.35
		
		let stack = UIStackView(frame: CGRect(x: view.bounds.width * 0.05,
											  y: 0,
											  width: view.bounds.width * 0.9,
											  height: view.bounds.height))
		stack.alignment 	= .center
		stack.distribution	= .fill
		stack.axis			= .horizontal
		stack.spacing		= 10
		
		let labelsStack = UIStackView()
		labelsStack.axis			= .vertical
		labelsStack.distribution	= .fill
		labelsStack.alignment		= .leading
		labelsStack.spacing 		= 5
		
		let titleLabel = UILabel()
		titleLabel.text 			= title
		titleLabel.textColor		= .white
		titleLabel.font				= .boldSystemFont(ofSize: 14)
		titleLabel.numberOfLines 	= 0
		
		let subtitleLabel = UILabel()
		subtitleLabel.text 			= subtitle
		subtitleLabel.textColor		= .white
		subtitleLabel.font			= .systemFont(ofSize: 14)
		subtitleLabel.numberOfLines = 0
		
		labelsStack.addArrangedSubview(titleLabel)
		labelsStack.addArrangedSubview(subtitleLabel)
		
		let alertImage = UIImageView(frame: CGRect(x: 0, y: 0, width: height * 0.65, height: height * 0.65))
		alertImage.contentMode 	= .scaleAspectFit
		alertImage.image		= UIImage(systemName: "xmark.circle.fill")
		
		stack.addArrangedSubview(alertImage)
		stack.addArrangedSubview(labelsStack)
		
		view.addSubview(stack)
		
		UIView.animate(withDuration: 0.2) {
			view.transform = view.transform.translatedBy(x: 0, y: -(height + padding))
		}
		
		contentView.addSubview(view)
	}
	
	
	func hideAlertFormIfNeeded() {
		if let view = contentView.subviews.first(where: { $0.tag == tagValue }) {
			let remain = contentView.bounds.height - view.frame.minY
			UIView.animate(withDuration: 0.2) {
				view.alpha = 0
				view.transform = view.transform.translatedBy(x: 0, y: remain)
			} completion: { _ in
				view.removeFromSuperview()
			}
		}
	}
}
