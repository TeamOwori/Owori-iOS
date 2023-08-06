//
//  MyPageStoryInfo.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI

//MARK: API 받아올 때 수정해야하는 부분
struct MyPageStoryStyle: Identifiable {
    
    let id: UUID
    let writtenStory: Int
    let favoriteStory: Int
    let LetterBox: Int

}

struct MyPageStoryInfo: View {
    var body: some View {
        let temp2: [String] = ["작성한 이야기", "좋아하는 이야기", "편지함"]
        
        let test2: [MyPageStoryStyle] = [MyPageStoryStyle(id: UUID(), writtenStory: 1, favoriteStory: 5, LetterBox: 0)]
        
        HStack(alignment: .top, spacing: 16) {
            
            VStack(alignment: .center, spacing: 10) {
                
                Text("1")
                  .font(
                    Font.custom("Pretendard", size: 18)
                      .weight(.semibold)
                  )
                  .foregroundColor(Color.oworiOrange)
                
                Text("작성한 이야기")
                  .font(Font.custom("Pretendard", size: 12))
                  .kerning(0.18)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.oworiGray700)
                
                
            }
            .padding(0)
            .frame(width: 82, alignment: .top)
            .background(.white)
            
            
            VStack(alignment: .center, spacing: 10) {
                
                Text("5")
                  .font(
                    Font.custom("Pretendard", size: 18)
                      .weight(.semibold)
                  )
                  .foregroundColor(Color.oworiOrange)
                
                Text("좋아하는 이야기")
                  .font(Font.custom("Pretendard", size: 12))
                  .kerning(0.18)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.oworiGray700)
                
                
            }
            .padding(0)
            .frame(width: 82, alignment: .top)
            .background(.white)
            
            VStack(alignment: .center, spacing: 10) {
                
                Text("0")
                  .font(
                    Font.custom("Pretendard", size: 18)
                      .weight(.semibold)
                  )
                  .foregroundColor(Color.oworiOrange)
                
                Text("편지함")
                  .font(Font.custom("Pretendard", size: 12))
                  .kerning(0.18)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.oworiGray700)
                
                
            }
            .padding(0)
            .frame(width: 82, alignment: .top)
            .background(.white)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .cornerRadius(12)
    
    }
}

struct MyPageStoryInfo_Previews: PreviewProvider {
    static var previews: some View {
        MyPageStoryInfo()
    }
}
