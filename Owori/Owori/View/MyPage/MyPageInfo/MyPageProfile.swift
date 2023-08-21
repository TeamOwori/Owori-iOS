//
//  MyPageProfile.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct MyPageProfile: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var editMyPageIsActive: Bool = false
//    @State private var settingViewIsActive: Bool = false
    @State private var usedColorTupleList: [(String, Any)] = []
    var colorOrder: [String] = ["red", "pink", "yellow", "green", "skyblue", "blue", "purple"]
    
    @Binding var isLoggedIn: Bool
    @Binding var myPageViewIsActive: Bool

    
    
    var body: some View {
        
        if editMyPageIsActive {
            EditMyPage(editMyPageIsActive: $editMyPageIsActive, usedColorTupleList: $usedColorTupleList)
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
                            userViewModel.lookupUnmodifiableColor() { usedColorList in
                                self.usedColorTupleList = colorOrder.compactMap { key in
                                    guard let value = usedColorList[key] else { return nil }
                                    return (key, value)
                                }
                                print(self.usedColorTupleList)
                                
                                editMyPageIsActive = true
                            }
                        } label: {
                            Image("Edit")
                                .frame(width: 25, height: 25)
                            
                        }
                        
                        //설정
                        NavigationLink {
                            //설정으로 넘어가게
    //                        settingViewIsActive = true
                            SettingView(isLoggedin: $isLoggedIn)
                        } label: {
                            Image("Setting")
                                .frame(width: 25, height: 25)

                        }
                    }
                }
            }
        }
    }
}



struct MyPageProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfile(isLoggedIn: .constant(true), myPageViewIsActive: .constant(false))
    }
}
