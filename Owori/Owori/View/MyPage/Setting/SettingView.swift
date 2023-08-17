//
//  SettingView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct SettingView: View {
    // + 자동 로그인 여부
    @State private var autoLogin: Bool = false
    // + 알림 ON/OFF 여부
    @State private var allowedNotification: Bool = false
    
    @State private var showAlert = false
    
    @State private var showAlert1 = false
    
    @State private var FamilyNameChangeViewIsActive:Bool = false
    
    @State private var InviteViewIsActive:Bool = false
    
//    init() {
//        // 커스텀된 네비게이션바 배경색 설정
//        let coloredNavigationBar = UINavigationBarAppearance()
//        coloredNavigationBar.backgroundColor = UIColor(Color.oworiMain)
//
//        // 스크롤 할 떄, 스크롤하지 않을 때의 색상 적용
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavigationBar
//        // 일반(스크롤하지 않을 떄)
//        UINavigationBar.appearance().standardAppearance = coloredNavigationBar
//    }
    
    var body: some View {
        
        List {
            Group {
                //MARK: 맞춤설정
                Section {
                    HStack {
                        Text("자동 로그인")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.oworiGray700)
                            .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                        Spacer()
                        Toggle("", isOn: $autoLogin)
                            .toggleStyle(CustomToggle())
                    }
                    
                    Button(action: {
                        FamilyNameChangeViewIsActive = true
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("가족 그룹명 변경")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.oworiGray600)
                                
                                Text("행복한 우리가족")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.oworiGray400)
                            }
                            .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            
                            Image("Right")
                                .frame(width: 24, height: 24)
                        }
                    }

                    Button(action: {
                        // 버튼이 클릭되었을 때 수행할 동작 추가
                        InviteViewIsActive = true
                    }) {
                        HStack {
                            Text("초대하기")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            
                            Spacer()
                            
                            Image("Right")
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                } header: {
                    Text("맞춤설정")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                
                //MARK: 고객센터
                Section {
                    
                    Button(action: {
                        if let url = URL(string: "https://zeroexn.notion.site/813fd6f55a294c16ad7b07ee44635816") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("자주 묻는 질문")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSesA798lWnFIvWzekmc6WsMRIbKuyL3oS0x5mIaVFE1ot_vtQ/viewform?usp=sf_link") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("개발자에게 피드백 보내기")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                } header: {
                    Text("고객센터")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                
                //MARK: 앱 정보
                Section {
                    
                    Button(action: {
                        if let url = URL(string: "https://zeroexn.notion.site/86e355e9c415493695784ca02a3b329e") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("이용약관")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://zeroexn.notion.site/2abdc0d3fa724b32bc4db75b34eade45") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("개인정보 처리 방침")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://zeroexn.notion.site/e5db73c8565b47dfbaa7010880f32caf") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("오픈소스 라이센스")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                    
                    HStack{
                        Text("버전정보")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.oworiGray600)
                            .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                        
                        Spacer()
                        
                        Text("1.0.1")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.oworiGray600)
                            .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                    }
                    
                } header: {
                    Text("앱 정보")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                
                //MARK: About 오월이
                Section {
                    Button(action: {
                        if let url = URL(string: "https://www.instagram.com/owori_official/?igshid=MzRlODBiNWFlZA%3D%3D") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("오월이 인스타그램")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            Spacer()
                            Image("Right")
                        }
                    }
                } header: {
                    Text("About 오월이")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                
                
                //MARK: 기타
                Section {
                    Button(action: {
                        showAlert = true
                    }) {
                        HStack {
                            Text("로그아웃")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            
                            Spacer()
                            
                            Button{
                                showAlert = true
                            }label:{
                                Image("Right")
                            }.alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("로그아웃"), message: Text("로그아웃 하시겠습니까?"),
                                    primaryButton: .default(
                                        Text("취소")
                                    ),
                                    secondaryButton: .destructive(
                                        Text("로그아웃")
                                    )
                                )
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("로그아웃"), message: Text("로그아웃 하시겠습니까?"),
                            primaryButton: .default(
                                Text("취소")
                            ),
                            secondaryButton: .destructive(
                                Text("로그아웃")
                            )
                        )
                    }
                    
<<<<<<< Updated upstream
                    Button{

                    }label:{
                        HStack{
=======
                    Button(action: {
                        showAlert1 = true
                    }) {
                        HStack {
>>>>>>> Stashed changes
                            Text("탈퇴하기")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.oworiGray600)
                                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
                            
                            Spacer()

                            Button{
                                showAlert1 = true
                            }label:{
                                Image("Right")
                            }
                            .alert(isPresented: $showAlert1) {
                                Alert(
                                    title: Text("탈퇴하기"), message: Text("탈퇴하시겠습니까?"),
                                    primaryButton: .default(
                                        Text("취소")
                                    ),
                                    secondaryButton: .destructive(
                                        Text("탈퇴하기")
                                    )
                                )
                            }
                        }
                    }
                    .alert(isPresented: $showAlert1) {
                        Alert(
                            title: Text("탈퇴하기"), message: Text("탈퇴하시겠습니까?"),
                            primaryButton: .default(
                                Text("취소")
                            ),
                            secondaryButton: .destructive(
                                Text("탈퇴하기")
                            )
                        )
                    }
                } header: {
                    Text("기타")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 1.5, bottom: 0, trailing: 10))
            }
            .listRowBackground(Color.oworiMain.opacity(0.3))
            .cornerRadius(12)
        }
//        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                BackButton()
//            }
            ToolbarItem(placement: .principal) {
                    Text("설정")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color.black)
            }
        }
        .background(Color.oworiMain)
            .navigationDestination(isPresented: $FamilyNameChangeViewIsActive) {
                        FamilyNameChangeView()
                    }
            .navigationDestination(isPresented: $InviteViewIsActive) {
                        InviteView()
                    }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
