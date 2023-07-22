//
//  SettingView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct SettingView: View {
    // + 자동 로그인 여부
    @State var autoLogin: Bool = false
    // + 알림 ON/OFF 여부
    @State var allowedNotification: Bool = false
    
    init() {
        // 커스텀된 네비게이션바 배경색 설정
        let coloredNavigationBar = UINavigationBarAppearance()
        coloredNavigationBar.backgroundColor = UIColor(Color.oworiMainColor)
        
        // 스크롤 할 떄, 스크롤하지 않을 때의 색상 적용
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavigationBar
        // 일반(스크롤하지 않을 떄)
        UINavigationBar.appearance().standardAppearance = coloredNavigationBar
    }
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    Section {
                        HStack {
                            Text("자동 로그인")
                                .foregroundColor(.oworiGray700)
                            Spacer()
                            Toggle("", isOn: $autoLogin)
                                .toggleStyle(CustomToggle())
                        }
                        HStack {
                            Text("알림 ON/OFF")
                                .foregroundColor(.oworiGray700)
                            Spacer()
                            Toggle("", isOn: $allowedNotification)
                                .toggleStyle(CustomToggle())
                        }
                        NavigationLink {
                            FamilyNameChangeView()
                        } label: {
                            VStack(alignment: .leading) {
                                Text("가족 그룹명 변경")
                                    .font(
                                        Font.custom("Pretendard", size: 15)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.oworiGray600)
                                Text("행복한 우리가족")
                                    .font(
                                        Font.custom("Pretendard", size: 12)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.oworiGray400)
                            }
                        }
                        //.foregroundColor(.oworiGray600)
                        NavigationLink {
                            InviteView() // 삭제 예정 - 초대코드 View 겹침
                        } label: {
                            Text("초대하기")
                                .foregroundColor(.oworiGray600)
                        }
                        //.foregroundColor(.oworiGray600)
                    } header: {
                        Text("맞춤설정")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    }
                    Section {
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.notion.com")!)
                            } label: {
                                Text("자주 묻는 질문")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.google.com/intl/ko_kr/forms/about/")!)
                            } label: {
                                Text("개발자에게 피드백 보내기")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                    } header: {
                        Text("고객센터")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    }
                    Section {
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.notion.com")!)
                            } label: {
                                Text("이용약관")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                        
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.notion.com")!)
                            } label: {
                                Text("개인정보 처리 방침")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                        
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.notion.com")!)
                            } label: {
                                Text("오픈소스 라이센스")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                        
                        HStack {
                            Text("버전정보")
                                .foregroundColor(.oworiGray600)
                            Spacer()
                            Text("1.0")
                                .foregroundColor(.oworiGray600)
                        }
                    } header: {
                        Text("앱 정보")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    }
                    Section {
                        HStack {
                            Button {
                                UIApplication.shared.open(URL(string: "https://www.instagram.com/owori_official/")!)
                            } label: {
                                Text("오월이 인스타그램")
                                    .foregroundColor(.oworiGray600)
                            }
                        }
                    } header: {
                        Text("About 오월이")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    }
                    Section {
                        Button {
                            
                        } label: {
                            Text("로그아웃")
                                .foregroundColor(.oworiGray600)
                        }
                        //.foregroundColor(.oworiGray600)
                        Button {
                            
                        } label: {
                            Text("탈퇴하기")
                                .foregroundColor(.oworiGray600)
                        }
                        //.foregroundColor(.oworiGray600)
                    } header: {
                        Text("기타")
                            .font(
                                Font.custom("Pretendard", size: 18)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                    }
                    .navigationBarTitle("설정")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .listRowBackground(Color.oworiMainColor.opacity(0.5))
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
