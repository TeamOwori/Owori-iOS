//
//  StoryDetailContentSection.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct StoryDetailContentSection: View {
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ContentTitle(isFavorite: $isFavorite, storyInfo: $storyInfo)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
            ContentText(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
        }
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
        }
    }
}

struct StoryDetailContentSection_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailContentSection(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}

// MARK: - ContentTitle

private struct ContentTitle: View {
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text((storyInfo.start_date ?? "nil") + " - " + (storyInfo.end_date ?? "nil"))
                    .foregroundColor(Color.oworiGray600)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                FavoriteButton(isFavorite: $isFavorite, storyInfo: $storyInfo)
            }
            HStack(alignment: .bottom, spacing: 16) {
                Text(storyInfo.title ?? "nil")
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 20, weight: .bold))
                Text("by \(storyInfo.writer ?? "nil")")
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 12, weight: .regular))
            }
        }
        .onAppear {
            isFavorite = storyInfo.is_liked ?? false
        }
    }
}

struct ContentTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentTitle(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "20230707", end_date: "20230708")))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}

// MARK: - FavoriteButton

private struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    var body: some View {
        Button {
            isFavorite.toggle()
            storyViewModel.toggleHeart(user: userViewModel.user, storyId: storyInfo.story_id!) {
                storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: storyInfo.story_id!) { storyInfo in
                    self.storyInfo = storyInfo
                }
            }
        } label: {
            VStack {
                Image(isFavorite ? "FavoriteFill" : "FavoriteUnfill")
            }
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo()))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}



// MARK: - ContentText

private struct ContentText: View {
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

