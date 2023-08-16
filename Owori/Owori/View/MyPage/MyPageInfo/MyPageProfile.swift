//
//  MyPageProfile.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct MyPageProfile: View {
    
    @State private var editMyPageIsActive: Bool = false
//    @State private var settingViewIsActive: Bool = false
    
    var body: some View {
        
        if editMyPageIsActive {
            EditMyPage(editMyPageIsActive: $editMyPageIsActive)
        } else {
            ScrollView {
                
                VStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: UIScreen.main.bounds.height * 0.4)
                    
                    MyPageProfilePhoto()
                        .offset(y: -60)
                    
                }
                
                VStack(alignment: .leading)  {
                    
                    MyPageProfileInfo()
                        .padding(.top,-30)
                    
                    HStack{
                        MyPageStoryInfo()
                            .padding(.top,30)
                            .padding(.bottom, 50)
                    }
                    
                }
                
                Spacer()
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationTitle(Text(""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
                        NavigationLink {
                            //설정으로 넘어가게
    //                        settingViewIsActive = true
                            SettingView()
                        } label: {
                            Image("Setting")
                                .frame(width: 25, height: 25)

                        }
    //
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
