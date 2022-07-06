//
//  ImageInfo+Interactor.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

protocol ImageInfoInteractorInterface: AnyObject {
	func interactor(fetchData result: (Swift.Result<[ImageInfo], Error>) -> () )
	func interactor(addImage image: UIImage, result: (Swift.Result<ImageInfo, Error>) -> () )
	func interactor(deleteImages images: [ImageInfo], result: (Swift.Result<Bool, Error>) -> () )
}

final class ImageInfoInteractor: ImageInfoInteractorInterface {
	
	// MARK: - Private properties
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	// MARK: - Errors
	enum customError: LocalizedError {
		case errorSaveImage
		case errorCompressImage
		case errorLoadData
		case errorDeleteImage
		
		var errorDescription: String? {
			switch self {
			case .errorSaveImage:
				return "Can't save image"
			case .errorCompressImage:
				return "Can't compress image"
			case .errorLoadData:
				return "Can't fetch images"
			case .errorDeleteImage:
				return "Can't delete this image"
			}
		}
	}
	
	// MARK: - Interface
	func interactor(fetchData result: (Result<[ImageInfo], Error>) -> ()) {
		do {
			let images = try context.fetch(ImageInfo.fetchRequest())
			result(.success(images))
		} catch {
			result(.failure(customError.errorLoadData))
		}
	}
	
	
	func interactor(addImage image: UIImage, result: (Result<ImageInfo, Error>) -> ()) {
		let maxResolution: CGFloat 	= (1280 * 720) // 720p
		let resolution:CGFloat		= image.size.width * image.size.height // image resolution
		
		let compression = maxResolution / resolution
		
		guard let data:Data = image.jpegData(compressionQuality: compression) else {
			result(.failure(customError.errorCompressImage))
			return
		}

		let newImageInfo = ImageInfo(context: context)
		newImageInfo.image 	= data
		newImageInfo.added	= Date()
		newImageInfo.index	= 0

		do {
			try context.save()
			result(.success(newImageInfo))
		} catch {
			result(.failure(customError.errorSaveImage))
		}
	}
	
	func interactor(deleteImages images: [ImageInfo], result: (Result<Bool, Error>) -> ()) {
		images.forEach { image in
			context.delete(image)
		}
		
		do {
			try self.context.save()
			result(.success(true))
		} catch {
			result(.failure(customError.errorDeleteImage))
		}
	}
}
