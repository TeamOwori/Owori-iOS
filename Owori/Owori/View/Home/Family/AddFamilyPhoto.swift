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
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer(minLength: 50)
                    Text("사진 하나를 올려봐요")
                        .font( Font.custom("Pretendard", size: 18)  .weight(.semibold))
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                        Image(systemName: "plus") // 이미지로 변경
                            .foregroundColor(Color.oworiGray300)
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("사진 설명(선택)")
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.semibold)
                        )
                    VStack(alignment: .trailing, spacing: 12) {
                        ZStack {
                            TextEditor(text: $photoDescription)
                                .cornerRadius(12)
                                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.15)
                            if photoDescription.isEmpty {
                                Text("어떤 사진인가요? 짧게 기록을 남겨봐요")
                                    .font(Font.custom("Pretendard", size: 15))
                                    .frame(width: 269, height: 109, alignment: .topLeading) // .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.15, alignment: .topLeading)
                                    .foregroundColor(Color.oworiGray300)
//                                    .background(Color.green)
                                
                            }
                        }
                        Text("\(photoDescription.count)/50")
                            .foregroundColor(Color.oworiGray300)
                            .font(Font.custom("Pretendard", size: 12))
                            .kerning(0.18)
                    }
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.oworiGray200)
                            .opacity(0.5)
                    )
                }
//                .padding(.bottom, 125)
                .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                if photoDescription.isEmpty && photoisOn {
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(12)
                                .frame(width: 295, height: 48)
                                .foregroundColor(Color.oworiOrange)
                                .padding(.horizontal, 116)
                                .padding(.vertical, 11.5)
                            Text("올리기")
                                .font(Font.custom("Pretendard", size: 18)  .weight(.semibold))
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(12)
                                .frame(width: 295, height: 48)
                                .foregroundColor(Color.oworiGray200)
                                .padding(.horizontal, 116)
                                .padding(.vertical, 11.5)
                            Text("올리기")
                                .font(
                                    Font.custom("Pretendard", size: 18)
                                        .weight(.semibold)
                                )
                                .foregroundColor(Color.oworiGray400)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
    }
}

struct AddFamilyPhoto_Previews: PreviewProvider {
    static var previews: some View {
        AddFamilyPhoto()
    }
}


