//
//  PhotosContentView.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

final class PhotosContentView: UIView {
	
	// MARK: - Public UI
	public var collectionView: UICollectionView = {
		let layout		= UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		let collection 	= UICollectionView(frame: .zero,
										   collectionViewLayout: layout)
		collection.translatesAutoresizingMaskIntoConstraints = false
		collection.contentInsetAdjustmentBehavior = .never
		collection.showsVerticalScrollIndicator	= false
		collection.backgroundColor				= .white
		return collection
	}()
	
	// MARK: - Lifecycle
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		backgroundColor = .red
		
		addSubview(collectionView)
		
		setupConstraints()
		setupCollectionView()
	}
	
	// MARK: - Private functions
	private func setupConstraints() {
		
		addConstraints([
			// Collection view
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
	}
	
	private func setupCollectionView() {
		collectionView.register(PhotosCollectionViewCell.self,
								forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId)
	}
}
