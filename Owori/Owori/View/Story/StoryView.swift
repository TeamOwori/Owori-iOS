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
                Spacer()
                AlbumListButton(buttonSet: $buttonSet)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
            }
            if buttonSet {
                StoryAlbumView()
            } else {
                StoryListView()
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
