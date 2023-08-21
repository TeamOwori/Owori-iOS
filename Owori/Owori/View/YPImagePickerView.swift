//
//  YPImagePickerView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/22.
//

import SwiftUI
import YPImagePicker

struct MultiImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    func makeUIViewController(context: Context) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 10 // Set the maximum number of items to select

        let picker = YPImagePicker(configuration: config)
             picker.didFinishPicking { [unowned picker] items, _ in
                 self.selectedImages = items.compactMap { item -> UIImage? in
                     switch item {
                     case .photo(let photo):
                         return photo.image
                     case .video:
                         return nil
                     }
                 }
                 picker.dismiss(animated: true, completion: nil)
             }

        return picker
    }

    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {
        // Do nothing here
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var onComplete: (UIImage?) -> Void  // 추가한 클로저
    
    func makeUIViewController(context: Context) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = true
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.selectedImage = photo.image
                onComplete(photo.image)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {
        // Do nothing here
    }
}
