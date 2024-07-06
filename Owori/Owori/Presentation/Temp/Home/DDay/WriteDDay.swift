//
//  WriteDDay.swift
//  Owori
//
//  Created by 신예진 on 8/5/23.
//

import SwiftUI

struct WriteDDay: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    //화면으로 돌아가기
    @State private var isAddDdayViewActive = false
    
    //가족 탭
    @State private var checkForFirstTab = true
    
    //고삼이 탭
    @State private var checkForSecondTab = false
    
    @State private var scheduleType: String = ""
    
    @State private var title: String = ""
    
    @State private var content: String = ""
    
    //DatePicker
    @State private var startDate = Date()
    
    //DatePicker
    @State private var endDate = Date()
    
    //DDayToggle
    @State private var DDayToggle = true
    
    //AlarmToggle
    @State private var AlarmToggle = true
    
    @State private var scheduleId: String = ""
    
    var scheduleInfo: Family.Schedule = Family.Schedule()
    
    var body: some View {
        VStack {
            
            //MARK: 가족 탭 선택
            HStack{
                
                if scheduleId == "" {
                    //가족
                    Button{
                        checkForFirstTab = true
                        checkForSecondTab = false
                        
                    } label: {
                        Text("가족")
                            .font(.title3)
                            .foregroundColor(checkForFirstTab ? Color.white : Color.oworiGray300)
                            .frame(width: 80,height: 30)
                    }
                    .background {
                        if checkForFirstTab {
                            Color.oworiOrange
                        } else {
                            Color.oworiGray100
                        }
                    }
                    .cornerRadius(12)
                    
                    //자신
                    Button{
                        checkForFirstTab = false
                        checkForSecondTab = true
                        
                    } label: {
                        Text("\(userViewModel.user.member_profile?.nickname ?? "error")")
                            .font(.title3)
                            .foregroundColor(checkForSecondTab ? Color.white : Color.oworiGray300)
                            .frame(width: 80,height: 30)
                        
                    }
                    .background {
                        if checkForSecondTab {
                            Color.colorFromString(userViewModel.user.member_profile?.color ?? "None")
                        } else {
                            Color.oworiGray100
                        }
                    }
                    .cornerRadius(12)
                } else {
                    if scheduleType == "FAMILY" {
                        //가족
                        Button{
                            checkForFirstTab = true
                            checkForSecondTab = false
                            
                        } label: {
                            Text("가족")
                                .font(.title3)
                                .foregroundColor(checkForFirstTab ? Color.white : Color.oworiGray300)
                                .frame(width: 80,height: 30)
                        }
                        .background {
                            if checkForFirstTab {
                                Color.oworiOrange
                            } else {
                                Color.oworiGray100
                            }
                        }
                        .cornerRadius(12)
                    } else if scheduleType == "INDIVIDUAL" {
                        //자신
                        Button{
                            checkForFirstTab = false
                            checkForSecondTab = true
                            
                        } label: {
                            Text("\(userViewModel.user.member_profile?.nickname ?? "error")")
                                .font(.title3)
                                .foregroundColor(checkForSecondTab ? Color.white : Color.oworiGray300)
                                .frame(width: 80,height: 30)
                            
                        }
                        .background {
                            if checkForSecondTab {
                                Color.colorFromString(userViewModel.user.member_profile?.color ?? "None")
                            } else {
                                Color.oworiGray100
                            }
                        }
                        .cornerRadius(12)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width*0.8,height: 60,alignment: .center)
            .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30))
            TextField("제목을 입력해주세요", text: $title)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .frame(width: UIScreen.main.bounds.width * 0.88, height: UIScreen.main.bounds.height * 0.07)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(Color.oworiGray300)
                }.padding(.bottom,30)
            VStack(alignment: .center, spacing: 24) {
                HStack(alignment: .top,spacing: 16) {
                    DatePicker(
                        "시작일",
                        selection: $startDate,
                        displayedComponents: [.date]
                    )
                    .kerning(-2)
                    .frame(width: UIScreen.main.bounds.width*0.4)
                    DatePicker(
                        "종료일",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )
                    .kerning(-2)
                    .frame(width: UIScreen.main.bounds.width*0.4)
                }.frame(width: UIScreen.main.bounds.width*0.9)
                ZStack(alignment: .bottomTrailing) {
                    TextEditor(text: $content)
                        .onChange(of: content) { newText in
                            if newText.count > 10 {
                                content = String(newText.prefix(10))
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1))
                        )
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height * 0.13)
                    Text("\(content.count)/10")
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
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
        .onAppear {
            print("스케쥴 인포 : \(scheduleInfo)")
            print("스케쥴 아이디 : \(scheduleId)")
            scheduleId = (scheduleInfo.schedule_id)!
            scheduleType = (scheduleInfo.schedule_type)!
            title = (scheduleInfo.title)!
            content = (scheduleInfo.content)!
            startDate = scheduleInfo.start_date == "" ? Date() : (scheduleInfo.start_date?.toDate(dateFormat: "yyyyMMdd"))!
            endDate = scheduleInfo.end_date == "" ? Date() : (scheduleInfo.end_date?.toDate(dateFormat: "yyyyMMdd"))!
            if scheduleType == "INDIVIDUAL" {
                checkForFirstTab = false
                checkForSecondTab = true
            } else if scheduleType == "FANILY" {
                checkForFirstTab = true
                checkForSecondTab = false
            }
            print("스케쥴 인포 : \(scheduleInfo)")
            print("스케쥴 아이디 : \(scheduleId)")
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("작성하기")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.black)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if scheduleInfo.schedule_id == "" {
                        familyViewModel.createSchedule(user: userViewModel.user, schduleInfo: ["start_date": "\(startDate.formatDateToString(format: "yyyyMMdd"))",
                                                                                               "end_date": "\(endDate.formatDateToString(format: "yyyyMMdd"))",
                                                                                               "title": "\(title)",
                                                                                               "content": "\(content)",
                                                                                               "schedule_type": "\(checkForFirstTab ? "FAMILY" : "INDIVIDUAL")",
                                                                                               "dday_option": true,
                                                                                               "alarm_options": []]) { scheduleId in
                            familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } else {
                        print("업데이트 시 스케쥴 아이디 : \(scheduleId)")
                        familyViewModel.updateSchedule(user: userViewModel.user, schduleInfo: ["schedule_id": scheduleId ,
                                                                                               "start_date": "\(startDate.formatDateToString(format: "yyyyMMdd"))",
                                                                                               "end_date": "\(endDate.formatDateToString(format: "yyyyMMdd"))",
                                                                                               "title": "\(title)",
                                                                                               "content": "\(content)",
                                                                                               "dday_option": true,
                                                                                               "alarm_options": []]) { scheduleId in
                            familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                } label: {
                    Image("Check")
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct WriteDDay_Previews: PreviewProvider {
    static var previews: some View {
        WriteDDay(scheduleInfo: Family.Schedule())
    }
}
