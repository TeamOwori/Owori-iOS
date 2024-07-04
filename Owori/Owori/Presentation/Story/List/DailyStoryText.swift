//
//  DailyStoryText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryText: View {
    var storyTitle: String
    var storyContent: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(storyTitle)
                .font(.title3)
                .bold()
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(1)
            Text(storyContent)
                .font(.body)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(2)
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
            .font(.footnote)
        }
    }
}

struct DailyStoryText_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryText(storyTitle: "TEST", storyContent: "TEST")
    }
}
