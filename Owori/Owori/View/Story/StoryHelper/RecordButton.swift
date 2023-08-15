//
//  RecordButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/08.
//

import SwiftUI

struct RecordButton: View {
    @Binding var stories: [Story.StoryInfo]
    
    var body: some View {
        NavigationLink {
            StoryRecordView(stories: $stories)
        } label: {
            Text("기록하기")
                .frame(width: 100, height: 40)
                .foregroundColor(.white)
                .background(Color.oworiOrange)
                .cornerRadius(30)
        }
    }
}

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton(stories: .constant([]))
    }
}
