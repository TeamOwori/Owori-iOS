//
//  CommentsView.swift
//  Owori
//
//  Created by 신예진 on 8/17/23.
//

import SwiftUI

struct CommentsView: View {
    
    @State private var commentsPlaceholder: String = "가족에게 댓글을 남겨보세요 :)"
    @State private var title: String = ""
    @State private var content: String = ""
    
    //로직 수정 필요
    var body: some View {
        
//        Divider()
//            .frame(height: 1)
//            .overlay(Color.oworiGray200)
//
        ZStack{
            //글자제한 50자
            TextEditor(text:  $content)
                .onChange(of: content) { newText in
                    if newText.count > 30 {
                        content = String(newText.prefix(30))
                    }
                }
            if content.isEmpty {
                Text(commentsPlaceholder)
                    .foregroundColor(Color.oworiGray300)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 60)
        .background(.white)
        .overlay(
            Rectangle()
                .inset(by: 0.5)
                .stroke(Color.oworiGray200, lineWidth: 1)
        )
        
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
