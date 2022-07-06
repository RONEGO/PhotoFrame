//
//  PhotosViewController+ImagePicker.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)
		if let image = info[.originalImage] as? UIImage {
			presenter.presenter(addImageToDB: image)
		}
	}
}
