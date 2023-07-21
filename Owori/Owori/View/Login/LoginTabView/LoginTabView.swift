//
//  LoginTabView.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

// MARK: PROPERITES
//for each에 1,2,3,4,5 -> fill된 거랑, 안 된거랑 해서 for each 돌리고

struct LoginTabView: View {
    @State private var nickname: String = ""
    
    // -----------------
    @State private var birthDateText: String = ""
    @State private var previousBirthDateText: String = ""
    @State private var familyName: String = ""
    
    
    
    // -----------------
    
    @State private var textInput: String = ""
    @State private var currentIndex: Int = 0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if 0 < currentIndex {
                    Button {
                        currentIndex = currentIndex - 1
                        // 왜 그런지 모르겠는데 더블클릭 하면 뷰가 한박자 늦게 반영될 때가 있어서
                        // 0보다 작아지면 0으로 처리하도록 해놨습니다.
                        if currentIndex < 0 {
                            currentIndex = 0
                        }
                    } label: {
                        Text("<")
                    }
                }
                
                NumberIndicator(currentIndex: $currentIndex)
                    .padding(.top, 60)
                TabView(selection: $currentIndex) {
                    VStack(alignment: .leading) {
                        Text("오월이에서 사용할\n닉네임을 입력해주세요.")
                            .font(.title)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        Text("닉네임")
                            .foregroundColor(Color.oworiGray500)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        HStack {
                            TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $nickname)
                            // 텍스트가 변경될 때마다 글자 수 확인
                                .onChange(of: nickname) { newText in
                                    if newText.count > 7 {
                                        nickname = String(newText.prefix(7))
                                    }
                                }
                            Text("\(nickname.count)/7")
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                        
                        Button {
                            if !nickname.isEmpty {
                                currentIndex = currentIndex + 1
                            }
                        } label: {
                            Text("확인")
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .tag(0)
                    
                    // --------------------
                    
                    VStack(alignment: .leading) {
                        Text("생년월일 8자리를 입력해주세요")
                            .font(.title)
                            .bold()
                        Text("원활한 서비스를 위해 생년월일이 필요해요\n매년 오월이가 생일을 챙겨줄게요!")
                            .foregroundColor(Color.oworiGray500)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        HStack {
                            Text("생년월일  ")
                            TextField("yyyy-mm-dd", text: $birthDateText)
                                .keyboardType(.numberPad)
                                .onChange(of: birthDateText) { newValue in
                                    // 사용자가 입력한 값을 변환하는 로직을 구현
                                    
                                    if newValue.count > 8 {
                                        birthDateText = String(newValue.prefix(8))
                                    }
                                }
                            
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                        
                        Button {
                            if birthDateText.count >= 8 {
                                currentIndex = currentIndex + 1
                            }
                        } label: {
                            Text("확인")
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .tag(1)
                    
                    // --------------------
                    
                    VStack(alignment: .leading) {
                        Text("우리 가족\n그룹명을 정해주세요.")
                            .font(.title)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        Text("가족 그룹명")
                            .foregroundColor(Color.oworiGray500)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        HStack {
                            TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $familyName)
                            // 텍스트가 변경될 때마다 글자 수 확인
                                .onChange(of: familyName) { newText in
                                    if newText.count > 10 {
                                        familyName = String(newText.prefix(10))
                                    }
                                }
                            Text("\(familyName.count)/10")
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                        
                        Button {
                            if !familyName.isEmpty {
                                currentIndex = currentIndex + 1
                            }
                        } label: {
                            Text("확인")
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .tag(2)
                    
                    // --------------------
                    
                    VStack(alignment: .leading) {
                        Text("가족 연결을 해주세요.")
                            .font(.title)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        Text("초대코드 받았나요?\n없다면 가족들에게 초대코드를 보내봐요!")
                            .foregroundColor(Color.oworiGray500)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .tag(3)
                    
                    
                    // --------------------
                    
                    VStack(alignment: .leading) {
                        Text("오월이에서 사용할\n닉네임을 입력해주세요.")
                            .font(.title)
                            .bold()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                        Text("닉네임")
                            .foregroundColor(Color.oworiGray500)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        HStack {
                            TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $textInput)
                            // 텍스트가 변경될 때마다 글자 수 확인
                                .onChange(of: textInput) { newText in
                                    if newText.count > 7 {
                                        textInput = String(newText.prefix(7))
                                    }
                                }
                            Text("\(textInput.count)/7")
                        }
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .tag(4)
                    
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: geometry.size.height * 0.4)
                
                
            }
        }
    }
    
}

struct LoginTabView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTabView()
    }
}
