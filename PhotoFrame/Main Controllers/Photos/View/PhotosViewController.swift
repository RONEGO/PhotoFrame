//
//  PhotosViewController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 06.07.2022.
//

import Foundation
import UIKit

protocol PhotosViewControllerInterface: AnyObject {
	func viewDelegate(showError error: Error )
	func viewDelegate(showMessage message: String )
	
	func viewDelegateReloadCollection()
}

final class PhotosViewController: ViewController<PhotosContentView> {
	
	// MARK: - From super class
	override var fullScreen: Bool {
		return false
	}
	
	// MARK: - Public properties
	public let presenter: PhotosViewPresenterInterface = PhotosViewPresenter()
	public var indexForDelete 	= Set<Int>() {
		didSet {
			navigationItem.leftBarButtonItem?.isEnabled = !indexForDelete.isEmpty
		}
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupAddButton()
		setupDeleteButton()
		setupDelegates()
		presenter.presenterFetchData()
	}
	
	// MARK: - Private functions
	private func setupAddButton() {
		let button = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
									 style: .done,
									 target: self,
									 action: #selector(handleAddButton(_:)))
		button.tintColor = .supportColor
		navigationItem.rightBarButtonItem = button
	}
	
	private func setupDeleteButton() {
		let button = UIBarButtonItem(image: UIImage(systemName: "trash"),
									 style: .done,
									 target: self,
									 action: #selector(handleDeleteButton(_:)))
		button.tintColor = .red
		navigationItem.leftBarButtonItem = button
	}
	
	private func setupDelegates() {
		presenter.delegate = self
		contentView.collectionView.delegate		= self
		contentView.collectionView.dataSource	= self
	}
}

// MARK: - Seletors
extension PhotosViewController {
	
	@objc
	private func handleAddButton( _ button: UIBarButtonItem ) {
		AccessService.checkPhotoLibraryPremission(openVC: { [weak self] success in
			DispatchQueue.main.async {
				if success {
					guard let self = self else { return }
					let imagePicker = ControllersFactory.create(of: .imagePicker(delegate: self))
					self.present(imagePicker, animated: true)
				} else {
					let alert = AlertFactory.create(of: .openAppSettings(title: "The application needs access to photos to continue"))
					self?.present(alert, animated: true)
				}
			}
		})
	}
	
	
	@objc
	private func handleDeleteButton( _ button: UIBarButtonItem ) {
		let action:  ((UIAlertAction) -> Void) = { [weak self] _ in
			guard let self = self else {
				return
			}
			self.presenter.presenter(deleteImagesAtIndexes: self.indexForDelete.map { $0 } )
		}
		
		let alert = AlertFactory.create(of: .actionAlert(title: "Delete \(indexForDelete.count) photo(s)?",
														 actionTitle: "Delete", actionHandler: action))
		present(alert, animated: true)
	}
}

extension PhotosViewController: PhotosViewControllerInterface {
	func viewDelegate(showError error: Error) {
		let alert = AlertFactory.create(of: .showError(error: error))
		present(alert, animated: true)
	}
	
	func viewDelegate(showMessage message: String) {
		let alert = AlertFactory.create(of: .timerMessage(message: message))
		present(alert, animated: true)
	}
	
	func viewDelegateReloadCollection() {
		self.indexForDelete.removeAll()
		contentView.collectionView.reloadData()
	}
}
