////
////  StoryDetailCommentSection.swift
////  Owori
////
////  Created by kyungsoolee on 7/6/24.
////
//
//import SwiftUI
//
//struct StoryDetailCommentSection: View {
//    @State private var commentsPlaceholder: String = "가족에게 댓글을 남겨보세요 :)"
//    @State private var title: String = ""
//    @State private var content: String = ""
//    
//    var body: some View {
//        ZStack {
//            TextEditor(text:  $content)
//                .onChange(of: content) { newText in
//                    if newText.count > 30 {
//                        content = String(newText.prefix(30))
//                    }
//                }
//            if content.isEmpty {
//                Text(commentsPlaceholder)
//                    .foregroundColor(Color.oworiGray300)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: 60)
//        .background(.white)
//        .overlay(
//            Rectangle()
//                .inset(by: 0.5)
//                .stroke(Color.oworiGray200, lineWidth: 1)
//        )
//    }
//}
//
//#Preview {
//    StoryDetailCommentSection()
//}
//
//// MARK: - Comment
//
//private struct Comment: View {
//    @State private var nickname = "여왕님"
//    @State private var comment = "울 딸 엄마도 너무 재밌었어~ 사진 잘찍었네"
//    @State private var time = "1시간 전"
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 5) {
//            Text(nickname)
//                .font(.system(size: 14, weight: .medium))
//                .foregroundColor(Color.oworiOrange)
//            Text(comment)
//                .font(.system(size: 15, weight: .medium))
//                .foregroundColor(Color.oworiGray700)
//            HStack(alignment: .center, spacing: 9) {
//                Text(time)
//                    .font(.system(size: 12, weight: .medium))
//                    .kerning(0.18)
//                    .foregroundColor(Color.oworiGray300)
//                Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 1, height: 10)
//                .background(Color.oworiGray200)
//                Button {
//                } label: {
//                    Text("답글달기")
//                        .font(.system(size: 12, weight: .medium))
//                        .kerning(0.18)
//                        .foregroundColor(Color.oworiGray400)
//                }
//            }
//        }
//        .frame(maxWidth: UIScreen.main.bounds.width,alignment: .leading)
//    }
//}
//
//struct Comment_Previews: PreviewProvider {
//    static var previews: some View {
//        Comment()
//    }
//}
//
