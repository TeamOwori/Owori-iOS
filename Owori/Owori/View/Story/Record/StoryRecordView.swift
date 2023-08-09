//
//  StoryRecordView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/07.
//

import SwiftUI

struct StoryRecordView: View {
    
    //DatePicker
    @State private var startDate = Date()
    
    //DatePicker
    @State private var endDate = Date()
    
    @State private var title: String = ""
    
    @State private var content: String = ""
    
    
    // 자료형 임시 설정
    @State private var storyInfo: [String: Any] = [:]
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var contentPlaceholder: String = "추억을 기록해봐요:) 500자까지 입력할 수 있어요"
    
    var body: some View {
        VStack {
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
                    
                    Button{
                        //MARK: 사진 올리는 버튼 - API 연동
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.oworiGray300)
                            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                    }
                }
            }
            
            
            
            Button {
                // story_images 임시
                // date 포멘 변경 임시
                storyInfo = [
                    "start_date": /*"\(startDate)"*/"2021-12-12",
                    "end_date": /*"\(endDate)"*/"2021-12-12",
                    "title": "\(title)",
                    "content": "\(content)",
                    "story_images": []
                    ]
                print("storyInfo 작성 테스트 : \(storyInfo)")
                storyViewModel.createStory(user: userViewModel.user, storyInfo: storyInfo)
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
        StoryRecordView()
    }
}
