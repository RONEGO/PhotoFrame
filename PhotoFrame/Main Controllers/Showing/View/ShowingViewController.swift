//
//  ShowingViewController.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation
import UIKit

protocol ShowingViewControllerInterface: AnyObject {
	// functions
	/// Open next image
	func viewDelegateNextPage()
	
	/// Float for progress view (between 0.0 and 1.0)
	func viewDelegate(setProgressTimer progress: Float, animation: Bool)
	
	/// Called when imags loaded
	func viewDelegate(refreshedWithError error: Error?)
}

final class ShowingViewController: ViewController<ShowingContentView> {
	
	// MARK: - Public properties
	let presenter: ShowingViewPresenterInterface = ShowingViewPresenter()
	
	// MARK: - Private properties
	private var selectedRow: Int = 0
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupDelegates()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let indexPaths = contentView.collectionView.indexPathsForVisibleItems
		if indexPaths.count > 1 {
			guard let min = indexPaths.min() else {
				return
			}
			contentView.collectionView.scrollToItem(at: min,
													at: .top,
													animated: true)
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		refreshFeed()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter.stopTimer()
	}
	
	// MARK: - Public functions
	public func newIndexPathSelected( _ indexPath: IndexPath ) {
		if presenter.images.count > 1 {
			selectedRow = indexPath.row
			presenter.resetTimer(pausedTimer: nil)
		}
	}
	
	// MARK: - Private functions
	private func refreshFeed() {
		presenter.refreshFeed()
	}
	
	private func setupDelegates() {
		presenter.delegate						= self
		
		contentView.collectionView.delegate 	= self
		contentView.collectionView.dataSource	= self
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapPause))
		tap.numberOfTapsRequired = 2
		contentView.collectionView.addGestureRecognizer(tap)
	}
}

// MARK: - Selectors
extension ShowingViewController {
	
	@objc
	private func handleDoubleTapPause() {
		presenter.changeTimerState { played in
			contentView.showStateAnimation(forPlay: played)
		}
	}
	
}


// MARK: - Work with presenter
extension ShowingViewController: ShowingViewControllerInterface {
	
	func viewDelegate(refreshedWithError error: Error?) {
		if let error = error {
			let alert = AlertFactory.create(of: .showError(error: error))
			present(alert, animated: true)
			
		} else {
			contentView.collectionView.reloadData()
			if presenter.images.isEmpty || presenter.images.count < 2 {
				contentView.progressView.setProgress(0, animated: false)
			} else {
				presenter.resetTimer(pausedTimer: nil)
			}
			
			if !presenter.images.isEmpty {
				hideAlertFormIfNeeded()
				contentView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
														at: .top, animated: true)
			} else {
				showAlertFormIfNeeded(subtitle: "They can be uploaded on the Photos screen",
									  backColor: .mainColor)
			}
		}
	}
	
	func viewDelegate(setProgressTimer progress: Float, animation: Bool) {
		contentView.progressView.setProgress(progress, animated: animation)
	}

	func viewDelegateNextPage() {
		let visibleNow: Int = contentView.collectionView.indexPathsForVisibleItems.sorted().first?.row ?? 0
		if visibleNow != selectedRow {
			selectedRow = visibleNow
		}
		
		selectedRow += 1
		if selectedRow > presenter.images.count - 1 {
			selectedRow = 0
		}
		
		contentView.collectionView.scrollToItem(at: IndexPath(row: selectedRow, section: 0),
												at: .top,
												animated: true)
	}
}
