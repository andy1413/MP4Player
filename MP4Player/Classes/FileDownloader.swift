//
//  File.swift
//  KATOO
//
//  Created by wangfangshuai on 2021/8/5.
//

import Foundation
import FileDownloadKit
import Alamofire

public struct FileDownloadKit {
    static let videoSaveUrl: URL = {
        let path = NSHomeDirectory() + "/Documents/preview_video_mp4"
        return URL.init(fileURLWithPath: path, isDirectory: true)
    }()
    static public let videoDownloader: FileDownloader = {
        cleanVideoDir()
        let downloader = FileDownloader.init(saveDirectory: videoSaveUrl)
        return downloader
    }()
    
    static func cleanVideoDir() {
        try? FileManager.default.removeItem(at: videoSaveUrl)
    }
}

extension FileDownloader {
    @discardableResult
    open func download(url: String, md5: String? = nil, completion: @escaping (Result<URL, AFError>) -> Void) -> String? {
        guard let url = URL(string: url) else {
            completion(.failure(AFError.invalidURL(url: url)))
            return nil
        }
        return download(url: url, timeoutInterval: 100, progress: nil, completion: completion, md5: md5)
    }
}
