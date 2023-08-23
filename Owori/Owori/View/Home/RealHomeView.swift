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
    
    //    @State private var notificationViewIsActive: Bool = false
    
    //
    @State private var familyImagesTag: Int = 0
    @State private var familyDDayTag: Int = 0
    @State private var timer: Timer? = nil
    
    @Binding var emotionalBadgeViewIsActive: Bool
    @Binding var isLoggedIn: Bool
    @Binding var myPageViewIsActive: Bool
    @Binding var isAddDdayViewActive: Bool
    
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
                        NavigationLink {
                            // 스마일버튼이 눌리면 종 버튼이 떠야됨
                            MyPageProfile(isLoggedIn: $isLoggedIn)
                                .onAppear {
                                    userViewModel.lookupProfile() {}
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
                    TabView(selection: $familyDDayTag) {
                        ForEach(0..<(familyViewModel.family.dday_schedules?.count ?? 0), id: \.self) { index in
                            // dday card view
                            NavigationLink {
                                WriteDDay(scheduleInfo: (familyViewModel.family.dday_schedules?[index])!)
                            } label: {
                                DDayCardView(scheduleIndex: index)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        DDayInitialCard(isAddDdayViewActive: $isAddDdayViewActive)
                            .padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.05, leading: 0, bottom: UIScreen.main.bounds.height * 0.05, trailing: 0))
                    }
                    .tabViewStyle(.page)
                    .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.oworiGray500, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    )
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: UIScreen.main.bounds.width * 0.1, trailing: 0))
                    
                    
                    
                    
                    
                    TabView(selection: $familyImagesTag) {
                        ForEach(0..<(familyViewModel.family.family_images?.count ?? 0), id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                AsyncImage(url: URL(string: familyViewModel.family.family_images?[index] ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                                        .cornerRadius(12)
                                } placeholder: {
                                    Image("DefaultImage")
                                }
                                .tag(index)
                                
                                Button {
                                    familyViewModel.deleteFamilyImage(user: userViewModel.user, imageURL: familyViewModel.family.family_images?[index] ?? "") {
                                        familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                            
                                        }
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color.oworiGray300)
                                }
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                            }
                        }
                        FamilyPhotosPickerButton()
                    }
                    .tabViewStyle(.page)
                    .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.oworiGray500, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    )
                    
                    
                    //                    MARK: FamilyAlbumView
                    //                    FamilyInitialPhoto()
                    //                        .padding(EdgeInsets(top: 50, leading: 30, bottom: 50, trailing: 30))
                }
                
            }
        }
        .onAppear {
            print("schedule : \(familyViewModel.family.dday_schedules?.count ?? 0)")
                timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
                    withAnimation {
                        if (familyViewModel.family.family_images?.count ?? 1) > 0 {
                        familyImagesTag = (familyImagesTag + 1) % (familyViewModel.family.family_images?.count ?? 1) // 다음 탭으로 전환
                    }
                }
            }
        }
        
        
    }
}

struct RealHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealHomeView(emotionalBadgeViewIsActive: .constant(false), isLoggedIn: .constant(true), myPageViewIsActive: .constant(true), isAddDdayViewActive: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
