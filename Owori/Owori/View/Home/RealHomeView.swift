//
//  RealHomeView.swift
//  Owori
//
//  Created by 신예진 on 8/1/23.
//

import SwiftUI

struct RealHomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    //    @State private var familyInfo = Family()
    @State private var myPageViewIsActive: Bool = false
    
    //    @State private var notificationViewIsActive: Bool = false
    //
    
    @Binding var emotionalBadgeViewIsActive: Bool
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        ZStack {
            Color.oworiMain.edgesIgnoringSafeArea(.all)
            
            VStack {
                //MARK: Header 설정
                HStack {
                    HStack {
                        Text(familyViewModel.family.family_group_name ?? "Error")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                            .background(Color.oworiMain)
                        
                        
                        Spacer()
                        
                        //신고하기 버튼
                        NavigationLink {
                            //신고하기 버튼 누르면 나와야 되는 뷰
                            ReportView()
                            
                        } label: {
                            Image("Report")
                                .foregroundColor(Color.black)
                                .frame(width: 25, height: 25)
                            
                        }
                        
                        // 나중에 구현
//                        //종 버튼
//                        NavigationLink {
//                            // 종 버튼이 눌리면 종 버튼이 떠야됨
//                            //                            notificationViewIsActive = true
//                            HomeNotificationView()
//                        } label: {
//                            Image("Bell")
//                                .frame(width: 25, height: 25)
//                            
//                        }
                        
                        
                        
                        //스마일 버튼
                        Button {
                            // 스마일버튼이 눌리면 종 버튼이 떠야됨
                            userViewModel.lookupProfile() {
                                myPageViewIsActive = true
                            }
                                
                        } label: {
                            Image("smile")
                                .frame(width: 25, height: 25)
                            
                        }
                    }
                    
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                //MARK: 프로필 뷰 띄우기
                ProfileView(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive)
                
                ScrollView {
                    DDayInitialCard()
                    
                    //MARK: FamilyAlbumView
                    FamilyInitialPhoto()
                        .padding(EdgeInsets(top: 50, leading: 30, bottom: 50, trailing: 30))
                }
                .padding(.top, 50)
                
            }
        }
        .navigationDestination(isPresented: $myPageViewIsActive) {
            MyPageProfile(isLoggedIn: $isLoggedIn)
        }
    }
}

struct RealHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealHomeView(emotionalBadgeViewIsActive: .constant(false), isLoggedIn: .constant(true))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
