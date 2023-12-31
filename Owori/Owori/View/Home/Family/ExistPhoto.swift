//
//  ExistPhoto.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct ExistPhoto: View {
    @State private var imageName: String = "TestImage9"
    @State private var photoDescription: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: UIScreen.main.bounds.width * 1.25, height: UIScreen.main.bounds.height * 0.64)
                        .background(
                            ZStack {
                                Color.black
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill /* .fit */)
                                    .clipped()
                            }
                        )
                        .cornerRadius(12)
                    HStack {
                            Text(photoDescription)
                                .font(Font.custom("Pretendard", size: UIScreen.main.bounds.width * 0.05))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .top)
                    }
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width)
                    Spacer()
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            
                        } label: {
                            Image("Trash")
                                .padding(5)
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("Download")
                                .padding(5)
                                .frame(width: 24, height: 24)
                        }
                        Spacer()
                        NavigationLink {
                            AddFamilyPhoto()
                        } label: {
                            Image("Edit")
                                .padding(5)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackCancel())
        }
    }
}

struct ExistPhoto_Previews: PreviewProvider {
    static var previews: some View {
        ExistPhoto()
    }
}
