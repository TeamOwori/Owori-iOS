////
////  JoinView.swift
////  Owori
////
////  Created by 신예진 on 7/12/23.
////
//
//import SwiftUI
//
//// MARK: PROPERITES
////for each에 1,2,3,4,5 -> fill된 거랑, 안 된거랑 해서 for each 돌리고
//
//struct JoinView: View {
//    @State private var currentIndex: Int = 1
//    
//    // First
//    @State private var nickname: String = ""
//    
//    // Second
//    @State private var birthDateText: String = ""
//    @State private var previousBirthDateText: String = ""
//    
//    // Third
//    @State private var familyName: String = ""
//    
//    // Fourth
//    @State private var inviteCode: String = ""
//    
//    // -----------------
//    var body: some View {
//        JoinNickname(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
//    }
//}
//
//
//struct JoinView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinView()
//    }
//}
