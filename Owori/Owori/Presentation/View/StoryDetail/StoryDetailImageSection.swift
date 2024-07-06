//
//  StoryDetailImageSection.swift
//  Owori
//
//  Created by kyungsoolee on 7/6/24.
//

import SwiftUI

struct StoryDetailImageSection: View {
    @Binding var storyInfo: Story.StoryInfo
    @Binding var currentIndex: Int
    var body: some View {
        VStack {
            ImageTabView(storyInfo: $storyInfo, currentIndex: $currentIndex)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                .clipped()
            // Optional 언래핑 하기..
            if !storyInfo.story_images!.isEmpty {
                HorizontalImageScrollView(images: storyInfo.story_images ?? [], currentIndex: $currentIndex)
            }
        }
    }
}

#Preview {
    StoryDetailImageSection(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: ["LOVE", "CRY", "DefaultImage"], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), currentIndex: .constant(0))
        .environmentObject(UserViewModel())
        .environmentObject(StoryViewModel())
}


// MARK: - ImageTabView

private struct ImageTabView: View {
    @Binding var storyInfo: Story.StoryInfo
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if !(storyInfo.story_images ?? []).isEmpty {
                TabView(selection: $currentIndex) {
                    ForEach(0 ..< (storyInfo.story_images?.count ?? 0), id: \.self) { index in
                        NavigationLink {
                            ZoomImages(currentIndex: $currentIndex, storyInfo: storyInfo)
                        } label: {
                            DetailImageCell(image: storyInfo.story_images![index])
                        }
                    }
                }
            } else {
                DetailImageCell(image: "DefaultImage")
            }
            if !(storyInfo.story_images ?? []).isEmpty {
                CurrentImageOrder(images: (storyInfo.story_images ?? []), currentIndex: $currentIndex)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            print("[ImageTabView] : \(storyInfo)")
        }
    }
}

struct ImageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTabView(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), currentIndex: .constant(1))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}

// MARK: - CurrentImageOrder

private struct CurrentImageOrder: View {
    var images: [String]
    @Binding var currentIndex: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .foregroundColor(Color.oworiDarkGray)
            .frame(width: 47, height: 34)
            .overlay(
                Text("\(currentIndex + 1) / \(images.count)")
                    .foregroundColor(.white)
                    .font(.subheadline)
            )
    }
}

struct CurrentImageOrder_Previews: PreviewProvider {
    static var previews: some View {
        CurrentImageOrder(images: ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"], currentIndex: .constant(0))
    }
}

//// MARK: - HorizontalScrollView
//
//struct HorizontalImageScrollView: View {
//    var images: [String]
//    @Binding var currentIndex: Int
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(0 ..< images.count, id: \.self) { index in
//                    Button {
//                        currentIndex = index
//                    } label: {
//                        VStack(spacing: 0) {
//                            VStack {
//                                DetailImageCell(image: images[index])
//                                    .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6 * 4 / 5)
//                                    .clipped()
//                                    .cornerRadius(4, corners: .topLeft)
//                                    .cornerRadius(4, corners: .topRight)
//                            }
//                            VStack {
//                                Rectangle()
//                                    .foregroundColor(currentIndex == index ? Color.oworiOrange : .clear)
//                                    .frame(height: 4)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
//        }
//    }
//}
//
//struct HorizontalImageScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalImageScrollView(images: ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"], currentIndex: .constant(0))
//    }
//}

