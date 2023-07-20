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
        VStack {
            HStack {
                NumberIndicator()
            }
        }
    }
}

struct LoginTabView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTabView()
    }
}
