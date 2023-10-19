//
//  AddFamilyPhoto.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct AddFamilyPhoto: View {
    @State private var photoisOn: Bool = false
    @State private var photoDescription: String = ""
    @State private var isFamilyInitialPhotoActive = false
    var contentPlaceholder: String = "어떤 사진인가요? 짧게 기록을 남겨봐요"
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("사진 하나를 올려봐요")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color.oworiGray700)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.oworiGray300)
                        }
                    }
                }
                .padding(.bottom,50)
                VStack(alignment: .leading) {
                    Text("사진 설명(선택)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color.oworiGray700)
                    VStack{
                        ZStack(alignment: .topLeading) {
                            TextEditor(text:  $photoDescription)
                                .onChange(of: photoDescription) { newText in
                                    if newText.count > 50 {
                                        photoDescription = String(newText.prefix(50))
                                    }
                                }
                            if photoDescription.isEmpty {
                                Text(contentPlaceholder)
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
                            }
                        }
                        HStack {
                            Spacer()
                            Text("\(photoDescription.count)/50")
                                .foregroundColor(Color.oworiGray300)
                                .font(Font.custom("Pretendard", size: 12))
                                .kerning(0.18)
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.oworiGray300)
                    }.frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                }
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
                }.padding(.top,100)
                    .disabled(photoisOn.description.isEmpty || photoDescription.isEmpty)
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("사진 올리기")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct AddFamilyPhoto_Previews: PreviewProvider {
    static var previews: some View {
        AddFamilyPhoto()
    }
}


