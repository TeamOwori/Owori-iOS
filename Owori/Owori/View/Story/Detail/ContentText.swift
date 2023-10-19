//
//  ContentText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentText: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowDeleteAlert: Bool = false
    @State private var isActiveStoryModifyView: Bool = false
    @Binding var storyInfo: Story.StoryInfo
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(storyInfo.content ?? "nil")
                .font(.system(size: 16, weight: .medium))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text("좋아요 \(storyInfo.heart_count ?? 0)")
                    .foregroundColor(Color.oworiGray400)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                if storyInfo.writer ?? "" == userViewModel.user.member_profile?.nickname ?? "" {
                    Button {
                        isShowDeleteAlert = true
                    } label: {
                        Text("삭제하기")
                            .foregroundColor(Color.oworiGray400)
                            .font(.system(size: 12, weight: .regular))
                    }
                    .alert(isPresented: $isShowDeleteAlert) {
                        Alert(
                            title: Text("삭제하기"),
                            message: Text("게시글을 삭제하시겠습니까??"),
                            primaryButton: .destructive(Text("삭제"), action: {
                                storyViewModel.deleteStory(user: userViewModel.user, storyId: storyInfo.story_id ?? "") {
                                    storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                                        stories = storyViewModel.getStories()
                                        print("[Content Text]\(stories)")
                                        storiesForCollection = storyViewModel.getStoriesForCollection()
                                        print("[Content Text1] : \(storiesForCollection)")
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }),
                            secondaryButton: .cancel(Text("취소"), action: {
                            })
                        )
                    }
                    Divider()
                        .frame(width: 1, height: 10)
                        .overlay(Color.oworiGray200)
                    Button {
                        isActiveStoryModifyView = true
                        
                    } label: {
                        Text("수정하기")
                            .foregroundColor(Color.oworiGray400)
                            .font(.system(size: 12, weight: .regular))
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isActiveStoryModifyView) {
            StoryModifyView(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum, isActiveStoryModifyView: $isActiveStoryModifyView)
        }
        .onAppear {
            print(userViewModel.user)
        }
    }
}

struct ContentText_Previews: PreviewProvider {
    static var previews: some View {
        ContentText(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
