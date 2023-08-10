//
//  TextTestView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/07.
//


import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImages.count > 0 {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(selectedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            }
                        }
                    }
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray.opacity(0.6))
                        .padding()
                }
                
                PhotosPicker(selection: $selectedItems, maxSelectionCount: 10 ,matching: .any(of: [.images, .not(.videos)])) {
                    Label("Pick Photo", systemImage: "photo.artframe")
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
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
