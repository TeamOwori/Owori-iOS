//
//  MyPageProfile.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct MyPageProfile: View {
    
    @State private var editMyPageIsActive: Bool = false
    @State private var settingViewIsActive: Bool = false
    
    var body: some View {
        
        VStack{
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height * 0.4)
            
            MyPageProfilePhoto()
                .offset(y: -60)
            
            VStack(alignment: .leading, spacing: 40) {
                
                VStack(alignment: .leading, spacing: 16)  {
                    
                    MyPageProfileInfo()
                    
                    HStack{
                        MyPageStoryInfo()
                    }
                    
                }
            }
//            .frame(width: 298, alignment: .leading)
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        //이렇게 말고
//        .navigationDestination(isPresented: $editMyPageIsActive) {
//            EditMyPage()
//        }
//        .navigationDestination(isPresented: $settingViewIsActive) {
//            SettingView()
//        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                
                HStack{
                    
                    Button {
                        //edit 버튼 누르면 작동
                        editMyPageIsActive = true
                    } label: {
                        Image("Edit")
                            .frame(width: 25, height: 25)
                        
                    }
                    
                    //설정
                    Button {
                        //설정으로 넘어가게
                        settingViewIsActive = true
                    } label: {
                        Image("Setting")
                            .frame(width: 25, height: 25)
                        
                    }
                    
                }
                
            }
        }
    }
}



struct MyPageProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfile()
    }
}
