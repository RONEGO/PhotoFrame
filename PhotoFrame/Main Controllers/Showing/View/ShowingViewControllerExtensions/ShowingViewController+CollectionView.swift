//
//  ShowViewController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

extension ShowingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowingCollectionViewCell.reuseId,
													  for: indexPath) as! ShowingCollectionViewCell
		cell.setupCell(withImageInfo: presenter.images[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return view.bounds.size
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		
		if let collectionView = scrollView as? UICollectionView,
		   let firstVisible = collectionView.indexPathsForVisibleItems.first {
			newIndexPathSelected(firstVisible)
		}
	}
}
