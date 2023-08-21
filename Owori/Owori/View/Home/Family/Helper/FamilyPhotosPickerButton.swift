//
//  FamilyPhotosPickerButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/21.
//

import SwiftUI
import PhotosUI

struct FamilyPhotosPickerButton: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    var body: some View {
        PhotosPicker(selection: $selectedItems, maxSelectionCount: 1 ,matching: .any(of: [.images, .not(.videos)])) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                VStack(spacing: 25) {
                    Text("사진 자유롭게 올리는 공간이에요!\n가족사진을 올려보는건 어떨까요?")
                        .foregroundColor(.gray)
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                }
            }
        }
        .onChange(of: selectedItems) { newValues in
            Task {
                selectedImages = []
                for value in newValues {
                    if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                        selectedImages.append(image)
                        familyViewModel.uploadFamilyImage(user: userViewModel.user, image: image) { uploadedProfileImageUrl in
                            
                            familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FamilyPhotosPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        FamilyPhotosPickerButton()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
