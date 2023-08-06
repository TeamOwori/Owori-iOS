//
//  RealHomeView.swift
//  Owori
//
//  Created by 신예진 on 8/1/23.
//

import SwiftUI

struct RealHomeView: View {
    
    
    var body: some View {
        ZStack {
            Color.oworiMain.ignoresSafeArea()
            
            VStack{
                
                //MARK: Header 설정
                HStack{
                    HStack{
                        Text("우당탕탕 우리가족❤️")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .background(Color.oworiMain)
                    }
                    
                    Spacer()
                    
                    HStack{
                        //종 버튼
                        Button {
                            // 종 버튼이 눌리면 종 버튼이 떠야됨
                        } label: {
                            Image("Bell")
                                .frame(width: 25, height: 25)
                            
                        }
                        
                        //스마일 버튼
                        Button {
                            // 스마일버튼이 눌리면 종 버튼이 떠야됨
                        } label: {
                            Image("smile")
                                .frame(width: 25, height: 25)
                            
                        }
                    }
                    
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                //MARK: 프로필 뷰 띄우기
                ProfileView()
                    .padding(.bottom, 50)
                
                
                Button {
                    //클릭하면 움직여야지
                } label: {
                    DDayInitialCard()
                    
                    
                }
                
                
                //MARK: FamilyAlbumView
                FamilyInitialPhoto()
                    .padding(EdgeInsets(top: 50, leading: 30, bottom: 50, trailing: 30))
                
            }
        }
    }
}

struct RealHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealHomeView()
    }
}
