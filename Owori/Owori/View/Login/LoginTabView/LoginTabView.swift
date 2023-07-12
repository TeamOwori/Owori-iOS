//
//  LoginTabView.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

// MARK: PROPERITES
//for each에 1,2,3,4,5 -> fill된 거랑, 안 된거랑 해서 for each 돌리고

struct LoginTabView: View {
    var body: some View {
        
        HStack(alignment: .top) {
            
//            NumberIndicator()
            Image("Focused")
            .frame(width: 22, height: 22)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 60)
            .padding(.bottom, 0)
            
        }
        .padding()
        
    }
}

struct LoginTabView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTabView()
    }
}
