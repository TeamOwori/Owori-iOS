//
//  WriteDDay.swift
//  Owori
//
//  Created by 신예진 on 8/5/23.
//

import SwiftUI

struct WriteDDay: View {
    
    //화면으로 돌아가기
    @State private var isAddDdayViewActive = false
    
    //가족 탭
    @State private var checkForFirstTab = false
    
    //고삼이 탭
    @State private var checkForSecondTab = false
    
    @State private var title: String = ""
    
    //DatePicker
    @State private var date = Date()
    
    //DatePicker
    @State private var date1 = Date()
    
    //DDayToggle
    @State private var DDayToggle = true
    
    //AlarmToggle
    @State private var AlarmToggle = true
    
    var body: some View {
        VStack {
            
            //MARK: 가족 탭 선택
            HStack{
                
                //가족
                Button{
                    checkForFirstTab = false
                    
                } label: {
                    Text("가족")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(width: 80,height: 30)
                }
                .background(Color.oworiOrange)
                .cornerRadius(12)
                
                //가족
                Button{
                    checkForFirstTab = true
                    
                } label: {
                    Text("고삼이")
                        .font(.title3)
                        .foregroundColor(.oworiGray300)
                        .frame(width: 80,height: 30)
                    
                }
                .background(Color.oworiGray100)
                .cornerRadius(12)
                
                // 버튼 기능
                Button {
                    checkForFirstTab.toggle()
                } label: {
                    if checkForFirstTab == false {
                        //이러면 여기에 따로 처리해 줄 코드가 없는건가
                        
                    } else {
                        //
                        
                    }
                }
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width*0.8,height: 60,alignment: .center)
            .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
            
            //MARK: 제목입력
            TextField("제목을 입력해주세요", text: $title)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.07)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300)
                }.padding(.bottom,30)
            
            //MARK: DDAY 설정
            VStack(alignment: .center, spacing: 24) {
                
                //DatePicker
                HStack(alignment: .top,spacing: 16) {
                    
                    DatePicker(
                        "시작일",
                        selection: $date,
                        displayedComponents: [.date]
                    ).frame(width: UIScreen.main.bounds.width*0.4)
                    
                    
                    DatePicker(
                        "종료일",
                        selection: $date1,
                        displayedComponents: [.date]
                    ).frame(width: UIScreen.main.bounds.width*0.4)
                    
                }
                
                //DDay - Switch Button
                HStack(alignment: .top,spacing: 16) {
                    Image("DDay")
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 10))
                    
                    
                    Toggle("D-day 기능", isOn: $DDayToggle)
                        .toggleStyle(SwitchToggleStyle(tint: Color.oworiOrange))
                    
                    
                    
                }
                
                //Alarm - Switch Button
                HStack(alignment: .top,spacing: 16) {
                    Image("Alarm")
                        .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 10))
                    
                    
                    Toggle("알림", isOn: $AlarmToggle)
                        .toggleStyle(SwitchToggleStyle(tint: Color.oworiOrange))
                    
                    
                    
                }
                

                
                
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.25)
            .background(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.25)
                    .stroke(Color.oworiGray300)
            )
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                //고민되는게 X버튼이든 체크표시 버튼이든 둘다 누르면 홈화면으로 가야함.전자는 홈뷰로 고대로 돌아가면 되지만, 후자는 뷰가 업데이트 된 상황으로 가야함 -> ?? 질문...!
                            //MARK: HEADER 작성하기
                            HStack(alignment: .center) {
                                
//                                Button {
//                                    //X버튼 누르면 그냥 홈으로 회귀
//                                    isAddDdayViewActive = false
//
//                                } label: {
//                                    Text("X")
//                                        .foregroundColor(.black)
//                                        .bold()
//                                        .frame(width: 30, height: 30)
//                                }
                                BackToLoginButton()

                                Spacer()
                                
                                Text("작성하기")
                                    .font(
                                        Font.custom("Pretendard", size: 20)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                                
                                Spacer()
                                
                                Button {
                                    //View가 업데이트 된 상황에서 홈으로 복귀
                                    isAddDdayViewActive = false
                                } label: {
                                    Image("Check")
                                        .frame(width: 30, height: 30)
                                }
                            }
//                            .frame(width: UIScreen.main.bounds.width*0.9, height: 50, alignment: .center)
//                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
            }
        }

    }
}

struct WriteDDay_Previews: PreviewProvider {
    static var previews: some View {
        WriteDDay()
    }
}
