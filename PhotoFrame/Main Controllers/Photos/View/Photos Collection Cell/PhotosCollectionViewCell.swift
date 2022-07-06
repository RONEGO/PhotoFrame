//
//  PhotosCollectionViewCell.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
	// MARK: - Static properties
	public static let reuseId: String = "PhotosCollectionViewCell"
	
	// MARK: UI Entities
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode	= .scaleAspectFill
		imageView.clipsToBounds = true
		
		return imageView
	}()
	
	private let deletionView: UIView = {
		let mainView: UIView = UIView()
		mainView.translatesAutoresizingMaskIntoConstraints = false
		
		let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
		blur.translatesAutoresizingMaskIntoConstraints = false
		blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode 	= .scaleAspectFit
		image.tintColor		= .white
		image.image			= UIImage(systemName: "trash.circle")
		
		mainView.addSubview(blur)
		mainView.addSubview(image)
		
		mainView.addConstraints([
			blur.topAnchor.constraint(equalTo: mainView.topAnchor),
			blur.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
			blur.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
			blur.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),

			image.centerYAnchor.constraint(equalTo: blur.centerYAnchor),
			image.centerXAnchor.constraint(equalTo: blur.centerXAnchor),
			image.widthAnchor.constraint(equalTo: blur.widthAnchor, multiplier: 0.5),
			image.heightAnchor.constraint(equalTo: blur.widthAnchor, multiplier: 1)
		])
		
		return mainView
	}()
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image 		= nil
		deletionView.isHidden 	= true
	}
	
	
	// MARK: - Lifecycle
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		backgroundColor = .systemGray5
		
		addSubview(imageView)
		addSubview(deletionView)
		
		setupConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	// MARK: - Public functions
	public func setupCell(with info: ImageInfo, isForDeletion forDel: Bool) {
		ImageService.getImage(info) { [weak self] image in
			self?.imageView.image = image
		}
		deletionView.isHidden = !forDel
	}
	
	// MARK: - Private functions
	private func setupConstraints() {
		
		addConstraints([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			deletionView.topAnchor.constraint(equalTo: topAnchor),
			deletionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			deletionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			deletionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
		])
	}
}
