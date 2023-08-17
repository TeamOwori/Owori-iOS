//
//  Recomment.swift
//  Owori
//
//  Created by 신예진 on 8/17/23.
//

import SwiftUI

struct Recomment: View {
    
    // MARK: PROPERTIES
    /// - [임시] 리스트의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    private var lists = ["1", "2"]
    private var renickname = ["쥐렁이","끼룩꾹꾸"]
    private var recomment = ["그니까 근데 공원에서 오빠 여친 얘기 너무 웃겼어ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ","아 진짜 --;; 그거 흑역사야.. 다 잊어버려!!!"]
    private var retime = ["55분 전","50분 전"]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            ForEach(0..<lists.count, id: \.self) { index in
                 
                Text(renickname[index])
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.oworiOrange)
                
                Text(recomment[index])
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color.oworiGray700)
                
                HStack(alignment: .center, spacing: 9) {
                    Text(retime[index])
                        .font(.system(size: 12, weight: .medium))
                        .kerning(0.18)
                        .foregroundColor(Color.oworiGray300)
                    
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: 10)
                    .background(Color.oworiGray200)
                    
                    Button{
                        
                    }label: {
                        Text("삭제하기")
                            .font(.system(size: 12, weight: .medium))
                            .kerning(0.18)
                            .foregroundColor(Color.oworiGray400)
                    }
                    
                    Button{
                        
                    }label: {
                        Text("수정하기")
                            .font(.system(size: 12, weight: .medium))
                            .kerning(0.18)
                            .foregroundColor(Color.oworiGray400)
                        
                    }
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width,alignment: .leading)


            }
            
            
    }
}

struct Recomment_Previews: PreviewProvider {
    static var previews: some View {
        Recomment()
    }
}
