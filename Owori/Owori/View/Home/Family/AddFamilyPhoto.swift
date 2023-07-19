//
//  AddFamilyPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct AddFamilyPhoto: View {
    @State private var photoDescription: String = ""
    @State var photos: [PhotoInfo] = [
        PhotoInfo(name: "1"),
        PhotoInfo(name: "2"),
        PhotoInfo(name: "3"),
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer(minLength: 50)
                    Text("사진 하나를 올려봐요")
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.semibold)
                        )
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(.gray, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                        Image(systemName: "plus")
                            .foregroundColor(Color.gray/*300*/)
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("사진 설명(선택)")
                        .font(
                            Font.custom("Pretendard", size: 18)
                                .weight(.semibold)
                        )
                    VStack(alignment: .trailing, spacing: 12) {
                        TextEditor(text: $photoDescription)
                            .cornerRadius(12)
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.15)
                            //.background(Color.green)
                        Text("\(photoDescription.count)/50")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.gray/*200*/)
                            .opacity(0.5)
                    )
                }
                .padding(.bottom, 125)
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .cornerRadius(12)
                            .frame(width: 295, height: 48)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 116)
                            .padding(.vertical, 11.5)
                        Text("올리기")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.primary)
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
