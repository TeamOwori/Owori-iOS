//
//  ZoomImages.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/01.
//

import SwiftUI

struct ZoomImages: View {
    
    // 임시
//    var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    @Binding var currentIndex: Int
    var storyInfo: Story.StoryInfo
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                // storyInfo 적용해야 함.
                TabView(selection: $currentIndex) {
                    ForEach(0 ..< (storyInfo.story_images?.count ?? 0), id: \.self) { index in
                        ZoomDetailImageCell(image: storyInfo.story_images![index])
                    }
                }
                HorizontalImageScrollView(images: storyInfo.story_images ?? [], currentIndex: $currentIndex)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Spacer()
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    BackButton()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("다운로드")
                }
            }
        }
        
    }
}

struct ZoomImages_Previews: PreviewProvider {
    static var previews: some View {
        ZoomImages(currentIndex: .constant(0), storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
