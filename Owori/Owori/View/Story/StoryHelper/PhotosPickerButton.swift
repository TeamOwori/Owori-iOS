//
//  PhotosPickerButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/10.
//

import SwiftUI
import PhotosUI

struct PhotosPickerButton: View {
    @State private var isImagePickerPresented: Bool = false
    @Binding var selectedImages: [UIImage]
    
    var body: some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
            Image(systemName: "plus")
                .foregroundColor(Color.oworiGray300)
                .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                )
        }
        .sheet(isPresented: $isImagePickerPresented) {
            MultiImagePickerView(selectedImages: $selectedImages)
        }
    }
}

struct PhotosPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotosPickerButton(selectedImages: .constant([]))
    }
}
