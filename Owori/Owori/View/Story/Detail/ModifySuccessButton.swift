//
//  ModifySuccessButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/20.
//

import SwiftUI

struct ModifySuccessButton: View {
    @Binding var storyInfo: Story.StoryInfo
    //DatePicker
    @Binding var startDate: Date
    
    //DatePicker
    @Binding var endDate: Date
    
    @Binding var title: String
    
    @Binding var content: String
    
    @Binding var storyImages: [String]
    
    
    @Binding var selectedImages: [UIImage]
    
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var isActiveStoryModifyView: Bool
    
    
    // 자료형 임시 설정
//    @State private var storyInfo: [String: Any] = [:]
    @State private var storyInfoDictionary: [String: Any] = [:]
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            if !selectedImages.isEmpty {
                storyViewModel.uploadStoryImages(user: userViewModel.user, images: selectedImages) { uploadedStoryImagesUrl in
                    
                    storyImages = uploadedStoryImagesUrl
                    print("storyImages : \(storyImages)")
                    
                    storyInfoDictionary = storyViewModel.createStoryInfoToUpdateDictionary(storyId: storyInfo.story_id!,startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                    
                    print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                    print("실행 됨1")
                    storyViewModel.updateStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                        
                        print("실행 됨2")
                        
                        storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                            print("실행 됨3")
                            
                            stories = storyViewModel.getStories()
                            storiesForCollection = storyViewModel.getStoriesForCollection()
                            print("[getStoryTest Record]\(stories)")
                            print("[getStoriesForcollection] : \(storiesForCollection)")
                            
                            // 로직 통일 및 수정 요망
                            storyDetailViewIsActive = false
                            isActiveStoryModifyView = false

                        }
                        
                    }
                    
                }
            } else {
                storyInfoDictionary = storyViewModel.createStoryInfoToUpdateDictionary(storyId: storyInfo.story_id!, startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                storyViewModel.updateStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                    
                    storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                        stories = storyViewModel.getStories()
                        storiesForCollection = storyViewModel.getStoriesForCollection()
                        print("[getStoryTest Record]\(stories)")
                        print("[getStoriesForcollection] : \(storiesForCollection)")
                        
                        storyDetailViewIsActive = false
                        isActiveStoryModifyView = false

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
        // 나중에 설정하기
//        .disabled(false)
    }
}

struct ModifySuccessButton_Previews: PreviewProvider {
    static var previews: some View {
        ModifySuccessButton(storyInfo: .constant(Story.StoryInfo()), startDate: .constant(Date()), endDate: .constant(Date()), title: .constant("TEST"), content: .constant("TEST"), storyImages: .constant([]), selectedImages: .constant([]), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), isActiveStoryModifyView: .constant(false))
    }
}
