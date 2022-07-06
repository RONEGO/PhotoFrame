//
//  AccessService.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import PhotosUI

final class AccessService {
	class func checkPhotoLibraryPremission(openVC: @escaping (Bool) -> Void ) {
		let status = PHPhotoLibrary.authorizationStatus()
		switch status {
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
				switch status {
				case .authorized, .limited:
					openVC(true)
					
				default:
					openVC(false)
				}
			}
			
		case .denied, .restricted:
			openVC(false)
		case .authorized, .limited:
			openVC(true)
		@unknown default:
			return
		}
	}
}
