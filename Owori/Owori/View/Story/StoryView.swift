//
//  StoryView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryView: View {
    // MARK: PROPERTIES
    /// - true : 앨범형 / false : 리스트형
    @State private var buttonSet: Bool = true
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                AlbumListButton(buttonSet: $buttonSet)
                Spacer()
                SortMenu()
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            ScrollView {
                if buttonSet {
                    StoryListView()
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                } else {
                    StoryAlbumView()
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
        }
    }
}


// MARK: PREVIEWS
struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
