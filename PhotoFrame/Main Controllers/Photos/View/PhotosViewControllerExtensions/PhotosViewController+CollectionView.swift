//
//  PhotosViewController+CollectionView.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId,
													  for: indexPath) as! PhotosCollectionViewCell
		let info = presenter.images[indexPath.row]
		cell.setupCell(with: info,
					   isForDeletion: indexForDelete.contains(indexPath.row) )
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
		
		if indexForDelete.contains(indexPath.row) {
			indexForDelete.remove(indexPath.row)
		} else {
			indexForDelete.insert(indexPath.row)
		}
		cell.setupCell(with: presenter.images[indexPath.row],
					   isForDeletion: indexForDelete.contains(indexPath.row))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.bounds.width / 3 - 2
		return CGSize(width: width, height: width * 1.25)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1.0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 2.5
	}
	
}
