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
                    Text("우당탕탕 우리가족❤️")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .background(Color.oworiMain)
                    
                    
                    //종 버튼
                    Button {
                        // 종 버튼이 눌리면 종 버튼이 떠야됨
                    } label: {
                        Image("Bell")
                            .frame(width: 25, height: 25)
                            .padding(EdgeInsets(top: 0, leading: 70, bottom: 0, trailing: 0))
                    }
                    
                    //스마일 버튼
                    Button {
                        // 스마일버튼이 눌리면 종 버튼이 떠야됨
                    } label: {
                        Image("smile")
                            .frame(width: 25, height: 25)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }

                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                //MARK: 프로필 뷰 띄우기
                ProfileView()
                    
                
                //MARK: 디데이 뷰 띄우기 - 스크롤이 부자연스러움 수정 봐야될듯
                DDayView()
                    .padding(.top, 50)
                    .padding(.bottom, 50)
                
                
                //MARK: FamilyAlbumView
                VStack(alignment: .center) {
                 
                    Text("사진 자유롭게 올리는 공간이에요!\n가족사진을 올려보는건 어떨까요?")
                      .font(Font.custom("Pretendard", size: 14))
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color.oworiGray500)
                      .frame(width: 213, alignment: .top)
                    
                    Button {
                        //+ 버튼이 뜨면 사진 입력하는 곳으로 넘어가야함
                        
                    } label: {
                        Image("Plus")
                            .frame(width: 25, height: 25)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    }
                    
                }
//                .frame(maxWidth: UIScreen.main.bounds.width*0.5)
                .padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))
                .background(.white)
                .cornerRadius(12)
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                )
            
            }
        }
    }
}

struct RealHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealHomeView()
    }
}
