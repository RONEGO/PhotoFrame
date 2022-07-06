//
//  ControllersFactory.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

final class ControllersFactory {
	// MARK: - Typealiases
	typealias pickerDelegate = (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
	
	// MARK: - Type
	enum controllerType {
		case navigationBar
		
		case mainShowing
		case mainPhotos
		
		case imagePicker(delegate: pickerDelegate )
		
		var title: String {
			switch self {
			case .mainShowing:
				return "Showing"
				
			case .mainPhotos:
				return "Photos"
				
			default:
				return "Error"
			}
		}
		
		var image: UIImage? {
			switch self {
			case .mainShowing:
				return UIImage(systemName: "photo.on.rectangle")
				
			case .mainPhotos:
				return UIImage(systemName: "plus.square.on.square")
				
			default:
				return nil
			}
		}
		
		var imageSelected: UIImage? {
			switch self {
			case .mainShowing:
				return UIImage(systemName: "photo.fill.on.rectangle.fill")
				
			case .mainPhotos:
				return UIImage(systemName: "plus.square.fill.on.square.fill")
				
			default:
				return nil
			}
		}
	}
	
	// MARK: - Class functions
	class func create(of type: controllerType) -> UIViewController {
		let backGroundColor: UIColor = .black
		
		switch type {
		case .navigationBar:
			let tabBar = TabBarViewController()
			tabBar.tabBar.isTranslucent	= false
			tabBar.tabBar.tintColor		= .mainColor
			tabBar.tabBar.barTintColor	= backGroundColor
			tabBar.view.backgroundColor = backGroundColor
			
			
			let bars: [controllerType] = [.mainShowing, .mainPhotos]
			tabBar.setViewControllers(bars.map({ typeVC in
				let vc = ControllersFactory.create(of: typeVC)
				vc.title = typeVC.title
				
				return vc
			}), animated: true)
			
			if let items = tabBar.tabBar.items {
				items.enumerated().forEach { item in
					let type = bars[item.offset]
					item.element.image 			= type.image
					item.element.selectedImage	= type.imageSelected
				}
				
			}
			
			return tabBar
			
		case .mainShowing:
			let vc = ShowingViewController()
			vc.view.backgroundColor = backGroundColor
			return vc
			
		case .mainPhotos:
			let vc = PhotosViewController()
			vc.title				= controllerType.mainPhotos.title
			vc.view.backgroundColor	= .white
			
			let nc = PhotosNavigationController(rootViewController: vc)
			
			return nc
			
		case .imagePicker(let delegate):
			let imagePicker = UIImagePickerController()
			imagePicker.delegate 				= delegate
			imagePicker.sourceType				= .photoLibrary
			imagePicker.allowsEditing			= false
			imagePicker.modalPresentationStyle 	= .formSheet
			
			return imagePicker
		}
	}
	
	
}
