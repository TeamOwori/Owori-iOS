//
//  ReportView.swift
//  Owori
//
//  Created by 신예진 on 8/13/23.
//

import SwiftUI

struct ReportView: View {
    
    //MARK: checkForReport
    
    //욕설/인신공격
    @State private var checkForabusivepersonalattack = false
    //개인정보노출
    @State private var checkForpersonalinformationdisclosure = false
    //음란성/선정성
    @State private var checkForobscenesensational = false
    //타인 어플 이용
    @State private var checkForusingotherapps = false
    //기타
    @State private var checkForother = false
    
    @State private var content: String = ""
    
    var contentPlaceholder: String = "신고 내용을 상세히 기입해주세요. (필수)"
    
    var isButtonEnabled: Bool {
        return (checkForabusivepersonalattack ||
                checkForpersonalinformationdisclosure ||
                checkForobscenesensational ||
                checkForusingotherapps ||
                checkForother) && !content.isEmpty
    }
    
    var body: some View {
        
        VStack{
            
            VStack(alignment: .leading){
                
                //첫번째 클릭
                HStack{
                    
                    //욕설 인신공격
                    HStack{
                        Button {
                            checkForabusivepersonalattack.toggle()
                        } label: {
                            if checkForabusivepersonalattack == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.trailing,16)
                        
                        Text("욕설/인신공격")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 50)
                    
                    //개인정보노출
                    HStack{
                        Button {
                            checkForpersonalinformationdisclosure.toggle()
                        } label: {
                            if checkForpersonalinformationdisclosure == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.trailing,16)
                        
                        Text("개인정보노출")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.bottom, 15)
                
                //두번째 클릭
                HStack{
                    
                    //음란성/선정성
                    HStack{
                        Button {
                            checkForobscenesensational.toggle()
                        } label: {
                            if checkForobscenesensational == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.trailing,16)
                        
                        Text("음란성/선정성")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 50)
                    
                    //타인 어플 이용
                    HStack{
                        Button {
                            checkForusingotherapps.toggle()
                        } label: {
                            if checkForusingotherapps == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.trailing,16)
                        
                        Text("타인어플이용")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.bottom, 15)
                
                //세번째 클릭 - 기타
                HStack{
                    
                    //음란성/선정성
                    HStack{
                        Button {
                            checkForother.toggle()
                        } label: {
                            if checkForother == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.trailing,16)
                        
                        Text("기타")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                
                
                
            }
            .padding(.bottom,50)
            
            
            ZStack(alignment: .topLeading) {
                
                // MARK: 글자 제한 - JoinNickName 코드 참고
                TextEditor(text:  $content)
                    .frame(width: 284, height: 200)
                    .onChange(of: content) { newText in
                        if newText.count > 500 {
                            content = String(newText.prefix(500))
                        }
                    }
                if content.isEmpty {
                    Text(contentPlaceholder)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
                }
            }.padding(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300)
                }
            
            
            
            Button{
                
            } label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(12)
                        .frame(width: 295, height: 48)
                        .foregroundColor(isButtonEnabled ? Color.oworiOrange : Color.oworiGray200)
                    
                    Text("신고하기")
                        .font(Font.custom("Pretendard", size: 18)  .weight(.semibold))
                        .foregroundColor(isButtonEnabled ? Color.white : Color.oworiGray400)
                }
            }
            .offset(y: UIScreen.main.bounds.height * 0.1)
            .disabled(!isButtonEnabled)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("신고하기")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.black)
            }
        }
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
