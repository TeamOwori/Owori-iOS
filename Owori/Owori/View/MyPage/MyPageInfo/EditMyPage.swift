//
//  EditMyPage.swift
//  Owori
//
//  Created by 신예진 on 8/8/23.
//

import SwiftUI
import PhotosUI

struct EditMyPage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    @State private var nickname: String = ""
    
    @State private var birthday: String = ""
    
    //임시 Color data
    //    @State private var color = ["oworiOrange","oworiPink","oworiYellow","oworiGreen","oworiSkyBlue","oworiBlue","oworiPurple"]selectedColor
    
    //    @State private var isColor: Bool = false
    
    @State private var selectedColor: String = ""
    
    @State private var isShowAlert: Bool = false
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    @Binding var editMyPageIsActive: Bool
    @Binding var usedColorTupleList: [(String, Any)]
    
    var body: some View {
        
        VStack{
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1 ,matching: .any(of: [.images, .not(.videos)])) {
                if selectedImages.isEmpty {
                    AsyncImage(url: URL(string: (userViewModel.user.member_profile?.profile_image) ?? "NONE")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("DefaultImage")
                    }
                } else {
                    // Image+Extension에서 동그랗게 짜르는 함수 구현해도 괜찮을 듯
                    // 사이즈 조절은 다시 해야됨
                    Image(uiImage: selectedImages[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }
                
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
            .offset(y: -60)
            
            VStack(alignment: .leading, spacing: 40) {
                
                VStack(alignment: .leading, spacing: 40) {
                    
                    //MARK: 닉네임
                    HStack(alignment: .center, spacing: 20) {
                        
                        HStack {
                            Text("닉네임")
                            TextField("\(userViewModel.user.member_profile?.nickname ?? "")", text: $nickname)
                            // 텍스트가 변경될 때마다 글자 수 확인
                                .onChange(of: nickname) { newText in
                                    if newText.count > 7 {
                                        nickname = String(newText.prefix(7))
                                    }
                                }
                            Text("\(nickname.count)/7")
                                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                                .foregroundColor(.gray)
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        .foregroundColor(.gray)
                        
                    }
                    
                    //MARK: 생년월일
                    HStack(alignment: .center, spacing: 20) {
                        
                        HStack {
                            Text("생년월일")
                            
                            TextField("\(userViewModel.user.member_profile?.birthday ?? "")", text: $birthday)
                                .onChange(of: birthday) { newText in
                                    if newText.count > 8 {
                                        birthday = String(newText.prefix(8))
                                    }
                                }
                            
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        .foregroundColor(.gray)
                        
                    }
                    
                    //MARK: 마이컬러
                    HStack(alignment: .center, spacing: 20) {
                        
                        HStack {
                            Text("마이 컬러")
                            
                        }
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        .foregroundColor(.gray)
                        
                    }
                    
                    HStack(alignment: .center, spacing: 10) {
                        
                        ForEach(Array(usedColorTupleList), id: \.0) { colorName, used in
                            Button {
                                if selectedColor == colorName.uppercased() {
                                    //                                    isColor = false
                                    //                                    selectedColor = ""
                                    
                                } else if (used as! Int) == 1 {
                                    
                                } else {
                                    //                                    isColor = true
                                    selectedColor = colorName.uppercased()
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.colorFromString(colorName.uppercased()))
                                        .frame(width: 24, height: 24)
                                    
                                    if selectedColor == colorName.uppercased() {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.oworiOrange)
                                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                            .background(
                                                Circle()
                                                    .foregroundColor(.black.opacity(0.4))
                                            )
                                    } else if (used as! Int) == 1 {
                                        Image("Disabled")
                                            .foregroundColor(Color.oworiOrange)
                                            .frame(width: 22, height: 22)
                                    }
                                }
                            }
                        }
                        
                        
                    }.frame(width: UIScreen.main.bounds.width*0.9)
                    
                }
                
                
            }
            .frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
            
            Spacer()
            
        }
        // 키보드 다 쓰고 빈 공간 누르면 키보드 내려가는 기능
        // 그냥 텍스트 있는 뷰에 모두 적용시키면 돼 저거 3줄..
        .onTapGesture {
            self.endTextEditing()
        }
        .onAppear {
            selectedColor = userViewModel.user.member_profile?.color ?? "None"
            print(selectedColor)
            nickname = userViewModel.user.member_profile?.nickname ?? "Nickname"
            birthday = userViewModel.user.member_profile?.birthday ?? "00000000"
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowAlert.toggle()
                } label: {
                    Text("X")
                }
                .alert(isPresented: $isShowAlert) {
                    Alert(
                        title: Text("나가기"),
                        message: Text("편집한 내용이 모두 사라집니다.\n그래도 나가시겠습니까?"),
                        primaryButton: .destructive(Text("나가기"), action: {
                            editMyPageIsActive = false
                        }),
                        secondaryButton: .cancel(Text("취소"), action: {
                            
                        })
                    )
                }
            }
            ToolbarItem(placement: .principal) {
                Text("프로필 편집")
                    .font(
                        Font.custom("Pretendard", size: 20)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //                    // 추후에 selectedImages[0]이 아니라 이미지 단일 값을 넘기도록 변경해야됨.
                    if selectedImages.isEmpty {
                        userViewModel.updateProfile(userInfo: [
                            "nickname": "\(nickname)",
                            "birthday": "\(birthday)",
                            "color": "\(selectedColor)"]) {
                                userViewModel.lookupProfile {
                                    editMyPageIsActive = false
                                    print(selectedColor)
                                    print(userViewModel.user)
                                }
                            }
                    } else {
                        userViewModel.updateProfile(userInfo: [
                            "nickname": "\(nickname)",
                            "birthday": "\(birthday)",
                            "color": "\(selectedColor)"]) {
                                userViewModel.uploadProfileImages(image: selectedImages[0]) { uploadedProfileImageUrl in
                                    userViewModel.lookupProfile {
                                        editMyPageIsActive = false
                                        print(selectedColor)
                                        print(userViewModel.user)
                                    }
                                }
                            }
                    }
                    
                    //                    // 테스트
                    //                    userViewModel.uploadProfileImages(image: selectedImages[0]) { uploadedProfileImagUrl in
                    //                        userViewModel.lookupProfile {
                    //                            editMyPageIsActive = false
                    //                        }
                    //                    }
                    
                } label: {
                    Image("Check")
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct EditMyPage_Previews: PreviewProvider {
    static var previews: some View {
        EditMyPage(editMyPageIsActive: .constant(true), usedColorTupleList: .constant([("red", 1), ("pink", 0), ("yellow", 0), ("green", 0), ("skyblue", 0), ("blue", 0), ("purple", 0)]))
    }
}
