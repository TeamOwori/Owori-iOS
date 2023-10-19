//
//  StoryRecordView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/07.
//

import SwiftUI
import YPImagePicker

struct StoryRecordView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var storyImages: [String] = []
    @State private var selectedImages: [UIImage] = []
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isDatePickerActive = false
    @State private var isDateOutOfRange = false
    var contentPlaceholder: String = "추억을 기록해봐요:) 500자까지 입력할 수 있어요"
    
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    HStack {
                        DatePicker(
                            "시작일",
                            selection: $startDate,
                            displayedComponents: [.date]
                        )
                        .kerning(0)
                        .padding(.leading,15)
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding(.leading,10)
                    HStack {
                        DatePicker(
                            "종료일",
                            selection: $endDate,
                            displayedComponents: [.date]
                        )
                        .kerning(0)
                        .padding(.trailing,15)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding(.trailing,10)
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top, 15)
                .padding(.bottom, 30)
                if isDatePickerActive && isDateOutOfRange {
                    Text("시작일은 이전 날짜만 선택 가능해요")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.red)
                        .padding(.top, -20)
                }
            }.onChange(of: startDate) { newStartDate in
                let today = Calendar.current.startOfDay(for: Date())
                if newStartDate < today {
                    isDateOutOfRange = false
                } else {
                    isDateOutOfRange = true
                }
            }
            .onChange(of: isDatePickerActive) { newIsActive in
                if !newIsActive {
                    isDateOutOfRange = false
                }
            }
            .onTapGesture {
                isDatePickerActive = true
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(.title3)
                        .bold()
                        .frame(alignment: .leading)
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
                    ScrollView(.horizontal) {
                        HStack {
                            if selectedImages.count > 0 {
                                ForEach(selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                }
                            }
                            PhotosPickerButton(selectedImages: $selectedImages)
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            RecordSuccessButton(startDate: $startDate, endDate: $endDate, title: $title, content: $content, storyImages: $storyImages, selectedImages: $selectedImages, stories: $stories, storiesForCollection: $storiesForCollection)
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitleDisplayMode(.inline)
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
        StoryRecordView(stories: .constant([]), storiesForCollection: .constant([:]))
    }
}
