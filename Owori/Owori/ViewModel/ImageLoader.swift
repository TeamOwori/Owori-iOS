////
////  ImageLoader.swift
////  Owori
////
////  Created by Kyungsoo Lee on 2023/08/17.
////
//
//import SwiftUI
//import Combine
//
//class ImageLoader: ObservableObject {
//    @Published var image: UIImage?
//
//    private var cancellable: AnyCancellable?
//
//    func loadImage(from url: URL) {
//        if let cachedImage = ImageCache.shared.getImage(for: url) {
//            self.image = cachedImage
//        } else {
//            cancellable = URLSession.shared.dataTaskPublisher(for: url)
//                .map(\.data)
//                .compactMap { UIImage(data: $0) }
//                .receive(on: DispatchQueue.main)
//                .sink(receiveCompletion: { _ in },
//                      receiveValue: { [weak self] image in
//                          ImageCache.shared.saveImage(image, for: url)
//                          self?.image = image
//                      })
//        }
//    }
//}
//
//struct RemoteImage: View {
//    @ObservedObject private var imageLoader = ImageLoader()
//    private let url: URL
//
//    init(url: URL) {
//        self.url = url
//    }
//
//    var body: some View {
//        Image(uiImage: imageLoader.image ?? UIImage())
//            .resizable()
//            .onAppear {
//                imageLoader.loadImage(from: url)
//            }
//    }
//}
