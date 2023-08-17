////
////  ImageCache.swift
////  Owori
////
////  Created by Kyungsoo Lee on 2023/08/17.
////
//
//import UIKit
//
//class ImageCache {
//    static let shared = ImageCache()
//
//    private var cache = NSCache<NSString, UIImage>()
//
//    func getImage(for url: URL) -> UIImage? {
//        return cache.object(forKey: url.absoluteString as NSString)
//    }
//
//    func saveImage(_ image: UIImage, for url: URL) {
//        cache.setObject(image, forKey: url.absoluteString as NSString)
//    }
//}
