//
//  RecentSearchList.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct RecentSearchList: View {
    
    // MARK: PROPERTIES
    /// - [임시] 리스트의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    private var lists = ["1", "2", "3"]
    
    private var timeImages = "History"
    
    private var closeImages = "SearchTermsClose"
    
    private var searchName = ["동해바다","바다","속초"]
    

    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            
            ForEach(0..<lists.count, id: \.self) { index in
                
                HStack(spacing: 16) {
                    
                    Image(timeImages)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(searchName[index])
                            .font(.headline)
                            .foregroundColor(Color.oworiGray600)
                    }
                    
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Image(closeImages)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.9)
    }
}

struct RecentSearchList_Previews: PreviewProvider {
    static var previews: some View {
        RecentSearchList()
    }
}

