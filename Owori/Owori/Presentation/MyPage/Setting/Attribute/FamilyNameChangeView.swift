//
//  FamilyNameChangeView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct FamilyNameChangeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var familyGroupName: String = ""
    
    var body: some View {
        ZStack {
            Color.oworiMain.opacity(0.3).ignoresSafeArea()
            VStack {
                Text("변경할 가족 그룹명을 입력해주세요")
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
                VStack{
                    HStack {
                        Text("가족 그룹명")
                            .font(
                                Font.custom("Pretendard", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color.oworiGray500)
                        TextField("", text: $familyGroupName)
                            .onChange(of: familyGroupName) { newText in
                                if newText.count >= 10 {
                                    familyGroupName = String(newText.prefix(10))
                                }
                            }
                        Text("\(familyGroupName.count)/10")
                            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                            .foregroundColor(.gray)
                    }
                    .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                    .padding(.leading,0)
                    .padding(.trailing,0)
                    .foregroundColor(.gray)
                    Text("숫자, 특수문자, 이모티콘 모두 사용 가능")
                        .font(
                            Font.custom("Pretendard", size: 12)
                                .weight(.medium)
                        )
                        .kerning(0.18)
                        .foregroundColor(Color.oworiGray400)
                }
                .frame(width: UIScreen.main.bounds.width*0.8,height: UIScreen.main.bounds.height*0.1, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .background(.white)
                .cornerRadius(12)
            }
        }
        .onAppear {
            familyGroupName = familyViewModel.family.family_group_name ?? "familyName"
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    familyViewModel.changeFamilyName(user: userViewModel.user, family_group_name: familyGroupName) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image("Check")
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}

struct FamilyNameChangeView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyNameChangeView()
    }
}
