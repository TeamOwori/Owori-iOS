//
//  RecordSuccessButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/11.
//

import SwiftUI

struct RecordSuccessButton: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var title: String
    @Binding var content: String
    @Binding var storyImages: [String]
    @Binding var selectedImages: [UIImage]
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @State private var storyInfo: [String: Any] = [:]
    @State private var storyInfoDictionary: [String: Any] = [:]
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
            if !selectedImages.isEmpty {
                storyViewModel.uploadStoryImages(user: userViewModel.user, images: selectedImages) { uploadedStoryImagesUrl in
                    storyImages = uploadedStoryImagesUrl
                    print("storyImages : \(storyImages)")
                    storyInfoDictionary = storyViewModel.createStoryInfoToDictionary(startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                    print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                    print("실행 됨1")
                    storyViewModel.createStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                        print("실행 됨2")
                        storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                            print("실행 됨3")
                            stories = storyViewModel.getStories()
                            storiesForCollection = storyViewModel.getStoriesForCollection()
                            print("[getStoryTest Record]\(stories)")
                            print("[getStoriesForcollection] : \(storiesForCollection)")
                        }
                    }
                }
            } else {
                storyInfoDictionary = storyViewModel.createStoryInfoToDictionary(startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                storyViewModel.createStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                    storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                        stories = storyViewModel.getStories()
                        storiesForCollection = storyViewModel.getStoriesForCollection()
                        print("[getStoryTest Record]\(stories)")
                        print("[getStoriesForcollection] : \(storiesForCollection)")
                    }
                }
            }
        } label: {
            Text("작성 완료")
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(Color.oworiOrange)
                .cornerRadius(12)
        }
        .onAppear {
            print(startDate)
        }
    }
}

struct RecordSuccessButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordSuccessButton(startDate: .constant(Date()), endDate: .constant(Date()), title: .constant("TEST"), content: .constant("TEST"), storyImages: .constant([]), selectedImages: .constant([]), stories: .constant([]), storiesForCollection: .constant([:]))
    }
}
