//
//  ImageService.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

final class ImageService {
	
	private static var imagesMap: [Date: UIImage] = [:]
	
	class func getImage( _ info: ImageInfo, completion: @escaping (UIImage?) -> () ) {
		if let date = info.added,
			let image = imagesMap[date] {
			completion(image)
		} else {
			DispatchQueue.global(qos: .userInteractive).async {
				if let data = info.image,
				   let image = UIImage(data: data) {
					DispatchQueue.main.async {
						completion(image)
						if let date = info.added {
							imagesMap.updateValue(image, forKey: date)
						}
					}
				} else {
					DispatchQueue.main.async {
						completion(nil)
					}
				}
			}
		}
	}
}
