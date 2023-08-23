//
//  DDayCardView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/23.
//

import SwiftUI

struct DDayCardView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    var scheduleIndex: Int


    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {

                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Text(familyViewModel.family.dday_schedules?[scheduleIndex].dday ?? "")
                            .font(.title)
                            .bold()
                            .foregroundColor(familyViewModel.family.dday_schedules?[scheduleIndex].dday == "D-DAY" ? Color.orange : Color.black)

                        if familyViewModel.family.dday_schedules?[scheduleIndex].schedule_type == "INDIVIDUAL" {
                            Circle()
                                .foregroundColor(Color.colorFromString(familyViewModel.family.dday_schedules?[scheduleIndex].color ?? "CLEAR"))
                                .frame(width: 24, height: 24)
                            Text(familyViewModel.family.dday_schedules?[scheduleIndex].nickname ?? "error")
                        } else {
                            Circle()
                                .foregroundColor(Color.colorFromString("ORANGE"))
                                .frame(width: 24, height: 24)
                            Text("가족")
                        }
                    }


                    Spacer()

                    Text("\(familyViewModel.family.dday_schedules?[scheduleIndex].start_date ?? "") ~ \(familyViewModel.family.dday_schedules?[scheduleIndex].end_date ?? "")") // 임시
                        .font(Font.custom("Pretendard", size: 10))
                        .kerning(0.18)

                    Spacer()

                    Text(familyViewModel.family.dday_schedules?[scheduleIndex].title ?? "")
                        .font(.title2)
                        .bold()
                    Spacer()

                    Text(familyViewModel.family.dday_schedules?[scheduleIndex].content ?? "")
                        .font(.subheadline)
                        .foregroundColor(Color.oworiGray500)
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))

            }
            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21, alignment: .leading)
            .cornerRadius(12)

            Button {
                // 디데이 카드 삭제
                familyViewModel.deleteFamilySchedule(user: userViewModel.user, scheduleId: familyViewModel.family.dday_schedules?[scheduleIndex].schedule_id ?? "") {
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
}

struct DDayCardView_Previews: PreviewProvider {
    static var previews: some View {
        DDayCardView(scheduleIndex: 0)
    }
}
