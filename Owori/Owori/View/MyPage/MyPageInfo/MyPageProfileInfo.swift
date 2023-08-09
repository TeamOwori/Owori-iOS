//
//  MyPageProfileInfo.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI

//MARK: API 받아올 때 수정해야하는 부분
struct MyPageProfileStyle: Identifiable {
    
    let id: UUID
    let profileImage: String
    let nickname: String
    let birth: String
    let myColor: String


}

struct MyPageProfileInfo: View {
    let temp1: [String] = ["닉네임", "생년월일", "마이컬러"]
    
    let test1: [MyPageProfileStyle] = [MyPageProfileStyle(id: UUID(),profileImage: "ProfileImage", nickname: "쥐렁이", birth: "2000-04-22",myColor: "Ellipse 92")]
    
    var body: some View {
 
        VStack(alignment: .leading, spacing: 40) {
            //닉네임
            HStack(alignment: .center, spacing: 20) {
                
                Text("닉네임\t")
                    .font(Font.custom("Pretendard", size: 14)
                        .weight(.medium))
                    .foregroundColor(Color.oworiGray500)
                
                Text("쥐렁이")
                    .font(Font.custom("Pretendard", size: 16)
                        .bold())
                    .foregroundColor(Color.oworiGray700)
            }
            
            
            HStack(alignment: .center, spacing: 20) {
                Text("생년월일\t")
                    .font(Font.custom("Pretendard", size: 14)
                        .weight(.medium)
                    )
                    .foregroundColor(Color.oworiGray500)
                
                Text("2000 - 04 - 22")
                    .font(Font.custom("Pretendard", size: 16)
                        .bold())
                    .foregroundColor(Color.oworiGray700)
                
            }
            
            
            HStack(alignment: .center, spacing: 16) {
                Text("마이 컬러\t")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.oworiGray500)
                
                Image("Ellipse 92")
                    .frame(width: 24, height: 24)
                
            }
            
        }
    }
}

struct MyPageProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfileInfo()
    }
}
