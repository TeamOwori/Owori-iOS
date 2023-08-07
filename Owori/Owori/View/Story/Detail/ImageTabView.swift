//
//  ImagesScrollView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct ImageTabView: View {
//    @Binding var images: [String]
//    var images: [String]
    @Binding var storyInfo: Story.StoryInfo
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $currentIndex) {
                ForEach(storyInfo.story_images!, id: \.self) { image in
                    NavigationLink {
                        ZoomImages(storyInfo: storyInfo)
                    } label: {
                        DetailImageCell(image: image)
                    }
                }
            }
            if !storyInfo.story_images!.isEmpty {
                CurrentImageOrder(images: storyInfo.story_images!, currentIndex: $currentIndex)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            print("[ImageTabView] : \(storyInfo)")
        }
    }
}

//struct ImagesScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageTabView(images: [], storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"), currentIndex: .constant(0))
//            .environmentObject(UserViewModel())
//            .environmentObject(StoryViewModel())
//    }
//}
