//
//  MP4Player.swift
//  KATOO
//
//  Created by wangfangshuai on 2021/8/5.
//

import Foundation
import AVFoundation
import UIKit

public class MP4Player {
    private var player: AVPlayer?
    private var playlayer: AVPlayerLayer?
    private var playEndNotificationToken: NotificationToken?
    private var mp4RequestId: String?
    public var mp4Url: String? = "https://file.vieka.life/40b977df/template/pgc/20210520182339/ce8499a6f5b04fbf8565dd8f06bcffc2.mp4"
    public var md5: String? = nil
    private var isPlaying: Bool = false
    private var superView: UIView
    
    public init(superView: UIView) {
        self.superView = superView
    }
    
    public func playMP4(downloadedCallback: (() -> Void)? = nil) {
        if let url = mp4Url, url != "" {
            mp4RequestId = FileDownloadKit.videoDownloader.download(url: url, md5: md5) { [weak self] (result) in
                guard let self = self else { return }
                guard url == self.mp4Url else { return }
                switch result {
                case .success(let desURL):
                    downloadedCallback?()
                    if self.isPlaying {
                        return
                    }
                    self.isPlaying = true
                    self.stopMp4()
                    
                    self.player = AVPlayer(url: desURL)
                    self.playlayer = AVPlayerLayer(player: self.player)
                    if let layer = self.playlayer {
                        layer.videoGravity = .resizeAspectFill
                        layer.frame = self.superView.bounds
                        self.superView.layer.addSublayer(layer)
                        self.player?.isMuted = true
                        self.player?.play()
                        self.playEndNotificationToken = NotificationCenter.default.addObserver(name: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil, using: { [weak self] notification in
                            guard let self = self else { return }
                            if let item = notification.object as? AVPlayerItem {
                                item.seek(to: .zero, completionHandler: nil)
                                self.player?.play()
                            }
                        })
                    }
                case .failure(_):
                    self.isPlaying = false
                    self.stopMp4()
                    break
                }
            }
        }
        
    }
    
    public func stopMp4AndPlayStatusSet() {
        stopMp4()
        isPlaying = false
    }
    
    public func resetPlayingStatus() {
        isPlaying = false
    }
    
    public func stopMp4() {
        self.playEndNotificationToken = nil
        if let requestId = mp4RequestId  {
            FileDownloadKit.videoDownloader.cancel(requestId: requestId)
        }
        if let layer = self.playlayer {
            layer.removeFromSuperlayer()
            self.playlayer = nil
        }
        if self.player != nil {
            self.player?.pause()
            self.player?.replaceCurrentItem(with: nil)
            self.player = nil
        }
        
        if let sublayers: [CALayer] = self.superView.layer.sublayers {
            for layer in sublayers {
                if let playlayerTmp = layer as? AVPlayerLayer {
                    playlayerTmp.removeFromSuperlayer()
                }
            }
        }
    }
}
