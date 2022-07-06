//
//  PhotosViewPresenre.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

protocol PhotosViewPresenterInterface: AnyObject {
	// properties
	var delegate: PhotosViewControllerInterface? { get set }
	var images: [ImageInfo] { get set }
	
	// functions
	func presenter(addImageToDB image:  UIImage)
	func presenter(deleteImagesAtIndexes indexes: [Int])
	func presenterFetchData()
}

final class PhotosViewPresenter: PhotosViewPresenterInterface {
	// MARK: - Private properties
	private let interactor: ImageInfoInteractorInterface = ImageInfoInteractor()
	
	// MARK: - Interface
	var delegate: PhotosViewControllerInterface?
	var images: [ImageInfo] = []
	
	func presenterFetchData() {
		images.removeAll()
		interactor.interactor { (result: Result<[ImageInfo], Error>) in
			switch result {
			case .success(let images):
				self.images.append(contentsOf: images)
				self.delegate?.viewDelegateReloadCollection()
//				self.delegate?.viewDelegate(changeState: .changeState(for: .show(images: images)))
			case .failure(let error):
				self.delegate?.viewDelegate(showError: error)
			}
		}
	}
	
	func presenter(addImageToDB image:  UIImage) {
		interactor.interactor(addImage: image) { (result: Result<ImageInfo, Error>) in
			switch result {
			case .success(let imageInfo):
				self.images.append(imageInfo)
				self.delegate?.viewDelegateReloadCollection()
				
			case .failure(let error):
				self.delegate?.viewDelegate(showError: error)
			}
		}
	}
	
	func presenter(deleteImagesAtIndexes indexes: [Int]) {
		let imagesToDel: [ImageInfo] = indexes.map {
			return self.images[$0]
		}
		interactor.interactor(deleteImages: imagesToDel) { (res: Result<Bool, Error>) in

			switch res {
			case .success:
				self.presenterFetchData()
			case .failure(let error):
				self.delegate?.viewDelegate(showError: error)
			}
		}
	}
}

