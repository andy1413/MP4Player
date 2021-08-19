//
//  MP4CollectionViewOptimize.swift
//  KATOO
//
//  Created by wangfangshuai on 2021/8/19.
//

import Foundation

public class MP4CollectionViewOptimize {
    private var isLoading = false
    private var isSliding = false
    private weak var collectionView: UICollectionView?
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    @objc func ifNotLoadingNoSlidingThenVisiableCellPlayMP4(delay: TimeInterval = 0.1) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if !self.isLoading && !self.isSliding {
                self.visiableCellPlayMp4()
            }
        }
    }
    
    func visiableCellPlayMp4() {
        guard let collectionView = collectionView else { return }
        let visibleCells = collectionView.visibleCells
        for visibleCell in visibleCells {
            if visibleCell is PlayMP4Control {
                let cell = visibleCell as! PlayMP4Control
                cell.playMP4()
            }
        }
    }
    
    func visiableCellStopMp4() {
        guard let collectionView = collectionView else { return }
        let visibleCells = collectionView.visibleCells
        for visibleCell in visibleCells {
            if visibleCell is PlayMP4Control {
                let cell = visibleCell as! PlayMP4Control
                cell.stopMP4AndPlayStatusSet()
            }
        }
    }
    
    public func collectionView(willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.isSliding && !self.isLoading {
            if let cell = cell as? PlayMP4Control {
                cell.playMP4()
            }
        }
    }
    
    public func collectionView(didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PlayMP4Control {
            cell.stopMP4AndPlayStatusSet()
        }
    }
    
    public func scrollViewWillBeginDragging() {
        isSliding = true
    }
    
    public func scrollViewDidEndDecelerating() {
        isSliding = false
        self.ifNotLoadingNoSlidingThenVisiableCellPlayMP4(delay: 0.3)
    }
    
    public func scrollViewDidEndDragging(willDecelerate decelerate: Bool) {
        if (!decelerate) {
            isSliding = false
            self.ifNotLoadingNoSlidingThenVisiableCellPlayMP4()
        }
    }
}

public protocol PlayMP4Control {
    func playMP4()
    func stopMP4AndPlayStatusSet()
}
