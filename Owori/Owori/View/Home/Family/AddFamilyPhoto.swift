//
//  AddFamilyPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct AddFamilyPhoto: View {
    // FamilyInitialPhoto 클릭 시 Navigate 됨
    // 사진이 들어왔을 때 -> 올리기 버튼 활성화
    @State private var photoisOn: Bool = false
    // ExistPhoto
    @State private var photoDescription: String = ""
    
    @State private var isFamilyInitialPhotoActive = false
    
    var body: some View {
        
        VStack(spacing: 50) {
            VStack(alignment: .leading, spacing: 10) {
                
                Text("사진 하나를 올려봐요")
                    .font( Font.custom("Pretendard", size: 18)
                        .weight(.semibold))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                        )
                    
                    Button{
                        //MARK: 사진 올리는 버튼 - API 연동
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.oworiGray300)
                        
                    }
                    
                }
            }.padding(.top,50)

            
            VStack(alignment: .leading) {
                
                Text("사진 설명(선택)")
                    .font( Font.custom("Pretendard", size: 18)
                        .weight(.semibold))
                
                VStack {
//                MARK: 글자 제한 - JoinNickName 코드 참고
                    TextField("어떤 사진인가요?짧게 기록을 남겨봐요",text:  $photoDescription)
                        .onChange(of: photoDescription) { newText in
                            if newText.count > 50 {
                                photoDescription = String(newText.prefix(50))
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("\(photoDescription.count)/50")
                            .foregroundColor(Color.oworiGray300)
                            .font(Font.custom("Pretendard", size: 12))
                            .kerning(0.18)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                }
                .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300)
                }
                
//                ZStack {
//                    RoundedRectangle(cornerRadius: 12)
//                        .foregroundColor(.white)
//                        .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .inset(by: 0.5)
//                                .stroke(Color.oworiGray300)
//                        )
//
//                    //MARK: 글자 제한 - JoinNickName 코드 참고
//                    TextField("어떤 사진인가요?짧게 기록을 남겨봐요",text:  $photoDescription)
//                        .onChange(of: photoDescription) { newText in
//                            if newText.count > 50 {
//                                photoDescription = String(newText.prefix(50))
//                            }
//                        }
//                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
//                        .offset(y:-20)
//                        .offset(x:40)
//
//                    Text("\(photoDescription.count)/50")
//                        .foregroundColor(Color.oworiGray300)
//                        .font(Font.custom("Pretendard", size: 12))
//                        .kerning(0.18)
//                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 0))
//                        .offset(y:60)
//                        .offset(x:100)
//
//                }
            }
            
            
            Button{
                if !photoDescription.isEmpty && photoisOn {
                    isFamilyInitialPhotoActive = true
                } else {
                    isFamilyInitialPhotoActive = false
                }
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .frame(width: 295, height: 48)
                        .foregroundColor(Color.oworiOrange)
                    Text("올리기")
                        .font(Font.custom("Pretendard", size: 18)  .weight(.semibold))
                        .foregroundColor(.white)
                }.disabled(photoisOn.description.isEmpty || photoDescription.isEmpty)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("사진 올리기")
                    .font(.title3)
                    .bold()
            }
        }
    }
}

struct AddFamilyPhoto_Previews: PreviewProvider {
    static var previews: some View {
        AddFamilyPhoto()
    }
}


