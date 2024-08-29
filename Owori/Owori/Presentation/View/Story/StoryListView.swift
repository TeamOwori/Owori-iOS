//
//  StoryListView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryListView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @State private var storyInfo: Story.StoryInfo = Story.StoryInfo()
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack {
            ForEach($stories, id: \.self) { story in
                Button {
                    storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: story.wrappedValue.story_id!) { storyInfo in
                        self.storyInfo = storyViewModel.searchStoryByStoryId(story_id: story.wrappedValue.story_id!)!
                        print("테스트테스트테스트\(story)")
                        storyDetailViewIsActive = true
                    }
                } label: {
                    DailyStoryListCell(storyInfo: story)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.oworiGray200)
                }
                .foregroundColor(.black)
            }
        }
        .onAppear {
            print("리스트 테스트")
            print(stories)
        }
        .navigationDestination(isPresented: $storyDetailViewIsActive) {
            StoryDetailView(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView(stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}

// MARK: - DailyStoryListCell

private struct DailyStoryListCell: View {
    @Binding var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack {
            HStack {
                DailyStoryText(storyTitle: storyInfo.title ?? "Title", storyContent: storyInfo.content ?? "Content")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                Spacer()
                DailyStoryImageCell(storyInfo: $storyInfo)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                    .clipped()
                    .cornerRadius(12)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Text("좋아요 \(storyInfo.heart_count ?? 0)")
                Text("• \(storyInfo.writer ?? "Unknown")")
                Spacer()
                Text((storyInfo.start_date ?? "nil") + " ~ " + (storyInfo.end_date ?? "nil"))
            }
            .foregroundColor(.gray)
            .font(.subheadline)
        }
    }
}

//struct DailyStoryListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyStoryListCell(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")))
//    }
//}

// MARK: - DailyStoryText

private struct DailyStoryText: View {
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

