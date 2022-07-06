//
//  ShowingViewPresenter.swift
//  PhotoFrame
//
//  Created by Yegor Geronin on 05.07.2022.
//

import Foundation

protocol ShowingViewPresenterInterface: AnyObject {
	// properties
	var delegate: ShowingViewControllerInterface? { get set }
	var images: [ImageInfo] { get set }
	
	// functions
	/// function to reset timer
	func resetTimer(pausedTimer: Float?)
	
	/// function to force stop timer
	func stopTimer()
	
	/// function to change timer state.
	/// completion: (true -> play) (false -> paused)
	func changeTimerState(completion: (Bool) -> () )
	
	func refreshFeed()
}

final class ShowingViewPresenter: ShowingViewPresenterInterface {
	
	// MARK: - Private properties
	// constants
	private let interactor: ImageInfoInteractorInterface = ImageInfoInteractor()
	
	private let maxDuration: Float 	= 5.0
	private	let interval: Float		= 0.05
	
	private var timer: Timer? = nil
	private var curDuration: Float	= 0.0
	private var pausedTimer: Float?	= nil
	
	// MARK: - Interface
	// delegate
	weak var delegate: ShowingViewControllerInterface?
	var images: [ImageInfo] = []
	
	// functions
	func resetTimer(pausedTimer: Float?) {
		stopTimer()
		if let pausedTimer = pausedTimer {
			curDuration = pausedTimer
		} else {
			curDuration = maxDuration
		}
		timer = Timer.scheduledTimer(timeInterval: TimeInterval(interval),
									 target: self,
									 selector: #selector(handleTimer(_:)),
									 userInfo: nil,
									 repeats: true)
		delegate?.viewDelegate(setProgressTimer: 1 - ( curDuration / maxDuration ),
							   animation: false)
	}
	
	func stopTimer() {
		timer?.invalidate()
		pausedTimer = nil
	}
	
	func changeTimerState(completion: (Bool) -> ()) {
		if let pausedTimer = pausedTimer {
			resetTimer(pausedTimer: pausedTimer)
			self.pausedTimer = nil
			completion(true)
		} else {
			stopTimer()
			self.pausedTimer = curDuration
			completion(false)
		}
	}
	
	func refreshFeed() {
		interactor.interactor { result in
			switch result {
			case .success(let images):
				self.images = images
				delegate?.viewDelegate(refreshedWithError: nil)
			case .failure(let error):
				delegate?.viewDelegate(refreshedWithError: error)
			}
		}
	}
	
	
	// MARK: - Selectors
	@objc
	private func handleTimer( _ timer: Timer) {
		curDuration -= interval
		if curDuration.isLessThanOrEqualTo(0.0) {
			curDuration = maxDuration
			DispatchQueue.main.async { [weak self] in
				self?.delegate?.viewDelegateNextPage()
			}
			delegate?.viewDelegate(setProgressTimer: 0.0, animation: false)
		} else {
			delegate?.viewDelegate(setProgressTimer: 1.0 - curDuration / maxDuration, animation: true)
		}
	}
}
