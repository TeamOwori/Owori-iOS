//
//  StoryRecordView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/07.
//

import SwiftUI
import PhotosUI

struct StoryRecordView: View {
    
    //DatePicker
    @State private var startDate = Date()
    
    //DatePicker
    @State private var endDate = Date()
    
    @State private var title: String = ""
    
    @State private var content: String = ""
    
    @State private var storyImages: [String] = []
    
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    @Binding var stories: [Story.StoryInfo]
    
    
    //    // 자료형 임시 설정
    //    @State private var storyInfo: [String: Any] = [:]
    //    @State private var storyInfoDictionary: [String: Any] = [:]
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var contentPlaceholder: String = "추억을 기록해봐요:) 500자까지 입력할 수 있어요"
    
    var body: some View {
        ScrollView {
            //DatePicker
            HStack {
                DatePicker(
                    "시작일",
                    selection: $startDate,
                    displayedComponents: [.date]
                )
                .frame(width: UIScreen.main.bounds.width*0.4)
                Spacer()
                DatePicker(
                    "종료일",
                    selection: $endDate,
                    displayedComponents: [.date]
                )
                .frame(width: UIScreen.main.bounds.width*0.4)
            }
            .padding()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(.title3)
                        .bold()
                        .frame(alignment: .leading)
                    //MARK: 제목입력
                    TextField("제목을 입력해주세요", text: $title)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color.oworiGray300)
                        }
                        .padding(.bottom,30)
                        .lineLimit(nil)
                }
                
                
                
                
                VStack(alignment: .leading) {
                    Text("추억 이야기")
                        .font(.title3)
                        .bold()
                    VStack {
                        ZStack(alignment: .topLeading) {
                            
                            // MARK: 글자 제한 - JoinNickName 코드 참고
                            TextEditor(text:  $content)
                                .frame(height: 200)
                                .onChange(of: content) { newText in
                                    if newText.count > 500 {
                                        content = String(newText.prefix(500))
                                    }
                                }
                            if content.isEmpty {
                                Text(contentPlaceholder)
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Text("\(content.count)/500")
                                .foregroundColor(Color.oworiGray300)
                                .font(Font.custom("Pretendard", size: 12))
                                .kerning(0.18)
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.oworiGray300)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("사진(최대 10장)")
                        .font(.title3)
                        .bold()
                    
                    
                    if selectedImages.isEmpty {
                        PhotosPickerButton(selectedItems: $selectedItems, selectedImages: $selectedImages)
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                PhotosPickerButton(selectedItems: $selectedItems, selectedImages: $selectedImages)
                                
                                if selectedImages.count > 0 {
                                    ForEach(selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            Button {
                
            } label: {
                Text("이미지 업로드 테스트")
            }
            
            
            RecordSuccessButton(startDate: $startDate, endDate: $endDate, title: $title, content: $content, storyImages: $storyImages, selectedImages: $selectedImages, stories: $stories)
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("기록하기")
                    .font(.title3)
                    .bold()
            }
        }
        
    }
}


struct StoryRecordView_Previews: PreviewProvider {
    static var previews: some View {
        StoryRecordView(stories: .constant([]))
    }
}
