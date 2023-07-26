//
//  StoryViewHeader.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct StoryViewHeader: View {
    @State private var familyName: String = "우리가족 추억저장소"
    var body: some View {
        HStack(alignment: .bottom) {
            Text(familyName)
                .font(.title3)
                .bold()
            Spacer()
            NavigationLink {
//                StorySearchView()
            } label: {
                Image("Search")
            }
            
        }
        .frame(height: .infinity)
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(Color.oworiMain)
        
    }
}

struct StoryViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        StoryViewHeader()
    }
}
