//
//  ShowingCollectionViewCell.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import UIKit

class ShowingCollectionViewCell: UICollectionViewCell {
	// MARK: - Static properties
	public static let reuseId: String = "ShowingCollectionViewCell"
	
	// MARK: - UI entities
	private var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}()
	
	private var backgroundImage: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = .systemGray5
		
		let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
		blurView.translatesAutoresizingMaskIntoConstraints	= false
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurView.alpha = 0.95
		
		imageView.addSubview(blurView)
		imageView.addConstraints([
			blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
			blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
			blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
		])
		/*
		 
		 let blurEffect = UIBlurEffect(style: style)
		 let blurEffectView = UIVisualEffectView(effect: blurEffect)
		 blurEffectView.frame = bounds
		 blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		 blurEffectView.alpha = 0.75
		 insertFullSubview(blurEffectView,
						   at: 0)
		 */
		
		return imageView
	}()
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		backgroundColor = .white
		clipsToBounds	= true
		
		addSubview(backgroundImage)
		addSubview(imageView)
		
		setupContraints()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image 		= nil
		backgroundImage.image 	= nil
	}
	
	// MARK: - Public functions
	public func setupCell(withImageInfo info: ImageInfo) {
		ImageService.getImage(info) { [weak self] image in
			if let image = image {
				self?.imageView.image 		= image
				self?.backgroundImage.image	= image
			}
		}
	}
	
	// MARK: - Private functions
	private func setupContraints() {
		addConstraints([
			
			// Main image
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			// Back image
			backgroundImage.topAnchor.constraint(equalTo: topAnchor),
			backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
			backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
