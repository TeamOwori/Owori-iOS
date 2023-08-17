//
//  RecordSuccessButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/11.
//

import SwiftUI

struct RecordSuccessButton: View {
    //DatePicker
    @Binding var startDate: Date
    
    //DatePicker
    @Binding var endDate: Date
    
    @Binding var title: String
    
    @Binding var content: String
    
    @Binding var storyImages: [String]
    
    
    @Binding var selectedImages: [UIImage]
    
    @Binding var stories: [Story.StoryInfo]
    
    
    // 자료형 임시 설정
    @State private var storyInfo: [String: Any] = [:]
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
                    
                    storyInfoDictionary = storyViewModel.createStoryInfoToDictionary(startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                    
                    print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                    storyViewModel.createStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                        
                        storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                            
                            stories = storyViewModel.getStories()
                            print("[getStoryTest Record]\(stories)")
                            print("[getStoriesForcollection] : \(storyViewModel.getStoriesForCollection())")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                }
            } else {
                storyInfoDictionary = storyViewModel.createStoryInfoToDictionary(startDate: startDate, endDate: endDate, title: title, content: content, storyImages: storyImages)
                print("storyInfo 작성 테스트 : \(storyInfoDictionary)")
                storyViewModel.createStory(user: userViewModel.user, storyInfo: storyInfoDictionary) {
                    
                    stories = storyViewModel.getStories()
                    print("[getStoryTest Record]\(stories)")
                    print("[getStoriesForcollection] : \(storyViewModel.getStoriesForCollection())")
                    self.presentationMode.wrappedValue.dismiss()
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
        .disabled(false)
    }
}

struct RecordSuccessButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordSuccessButton(startDate: .constant(Date()), endDate: .constant(Date()), title: .constant("TEST"), content: .constant("TEST"), storyImages: .constant([]), selectedImages: .constant([]), stories: .constant([]))
    }
}
