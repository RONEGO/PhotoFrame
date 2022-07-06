//
//  ShowingContentView.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

final class ShowingContentView: UIView {
	
	// MARK: - Public properties
	public var collectionView: UICollectionView = {
		let layout		= UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		let collection 	= UICollectionView(frame: .zero,
										   collectionViewLayout: layout)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.contentInsetAdjustmentBehavior = .never
		collection.showsVerticalScrollIndicator	= false
		collection.alwaysBounceVertical			= true
		collection.isPagingEnabled				= true
		collection.backgroundColor				= .clear
		return collection
	}()
	
	public var progressView: UIProgressView = {
		let progress = UIProgressView()
		progress.translatesAutoresizingMaskIntoConstraints	= false
		progress.progressTintColor	= .supportColor
		progress.trackTintColor		= .clear
		
		progress.setProgress(0, animated: false)
		return progress
	}()
	
	private var backGroundForProgress: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints	= false
		let gradient = CAGradientLayer()
		gradient.colors		= [UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.clear.cgColor]
		gradient.locations	= [0.0, 1.0]
		gradient.startPoint	= CGPoint(x: 0.5, y: 1)
		gradient.endPoint	= CGPoint(x: 0.5, y: 0)
		view.layer.insertSublayer(gradient, at: 0)
		
		return view
	}()
	
	// MARK: - Lifecycle
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		backgroundColor = .clear
		
		addSubview(collectionView)
		addSubview(backGroundForProgress)
		addSubview(progressView)
		
		setupContraints()
		setupCollectionView()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		backGroundForProgress.layer.sublayers?.forEach({ layer in
			if layer is CAGradientLayer {
				layer.frame = backGroundForProgress.bounds
			}
		})
	}
	
	// MARK: - Private functions
	private func setupContraints() {
		addConstraints([
			// Collection view
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			// BackGround for progress
			backGroundForProgress.heightAnchor.constraint(equalToConstant: 75),
			backGroundForProgress.bottomAnchor.constraint(equalTo: bottomAnchor),
			backGroundForProgress.leadingAnchor.constraint(equalTo: leadingAnchor),
			backGroundForProgress.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			// Progress
			progressView.centerXAnchor.constraint(equalTo: backGroundForProgress.centerXAnchor),
			progressView.widthAnchor.constraint(equalTo: backGroundForProgress.widthAnchor, multiplier: 0.75),
			progressView.centerYAnchor.constraint(equalTo: backGroundForProgress.centerYAnchor, constant: 15)
		])
	}
	
	private func setupCollectionView() {
		collectionView.register(ShowingCollectionViewCell.self,
								forCellWithReuseIdentifier: ShowingCollectionViewCell.reuseId)
	}
}

// MARK: - Animations
extension ShowingContentView {
	public func showStateAnimation(forPlay play: Bool) {
		let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
		image.alpha			= 0.0
		image.image 		= UIImage(systemName: play ? "play.circle.fill" : "pause.circle.fill")
		image.center 		= center
		image.tintColor		= .white.withAlphaComponent(0.85)
		image.contentMode 	= .scaleAspectFit
		
		UIView.animate(withDuration: 0.2) {
			image.alpha		= 1.0
			image.transform	= image.transform.scaledBy(x: 1.2, y: 1.2)
		} completion: { _ in
			UIView.animate(withDuration: 0.5) {
				image.alpha = 0.0
				image.transform	= image.transform.scaledBy(x: 0.5, y: 0.5)
			} completion: { _ in
				image.removeFromSuperview()
			}

		}

		
		addSubview(image)
	}
}
