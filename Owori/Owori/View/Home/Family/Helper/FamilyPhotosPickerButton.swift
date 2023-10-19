//
//  FamilyPhotosPickerButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/21.
//

import SwiftUI
import YPImagePicker

struct FamilyPhotosPickerButton: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        Button {
            isImagePickerPresented.toggle()
        } label: {
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
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePickerView(selectedImage: $selectedImage, onComplete: { image in
                if let selectedImage = image {
                    familyViewModel.uploadFamilyImage(user: userViewModel.user, image: selectedImage) { uploadedProfileImageUrl in
                        familyViewModel.lookUpHomeView(user: userViewModel.user) {}
                    }
                }
            })
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
