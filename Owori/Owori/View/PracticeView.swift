//
//  PracticeView.swift
//  Owori
//
//  Created by 신예진 on 2023/07/05.
//

//로그인 뷰 연습
import SwiftUI

struct PracticeView: View {
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "person.2.circle.fill")
                    .imageScale(.large)
                    .frame(width: 300, height: 300).padding(.leading)
                
                Spacer()
                    }
                }
            }
        
    }


struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}

//로그인 뷰 피그마 코드 복붙(UIkit)인데??
//var view = UIView()
//view.frame = CGRect(x: 0, y: 0, width: 400, height: 350)
//view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
//
//var parent = self.view!
//parent.addSubview(view)
//view.translatesAutoresizingMaskIntoConstraints = false
//view.widthAnchor.constraint(equalToConstant: 400).isActive = true
//view.heightAnchor.constraint(equalToConstant: 350).isActive = true
//view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: -166.5).isActive = true
//view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: -179).isActive = true
