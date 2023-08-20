//
//  PhotosPickerButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/10.
//

import SwiftUI
import PhotosUI

struct PhotosPickerButton: View {
    
    
    @Binding var selectedItems: [PhotosPickerItem]
    @Binding var selectedImages: [UIImage]
    
    var body: some View {
        PhotosPicker(selection: $selectedItems, maxSelectionCount: 10 ,matching: .any(of: [.images, .not(.videos)])) {
            Image(systemName: "plus")
                .foregroundColor(Color.oworiGray300)
                .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                )
        }
        .onChange(of: selectedItems) { newValues in
            Task {
                selectedImages = []
                for value in newValues {
                    if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                        selectedImages.append(image)
                    }
                }
            }
        }
    }
}

struct PhotosPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerButton(selectedItems: .constant([]), selectedImages: .constant([]))
    }
}
