//
//  DetailContent.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct DetailContent: View {
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ContentTitle(isFavorite: $isFavorite)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
            
            ContentText()
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
        }
    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(isFavorite: .constant(true))
    }
}
