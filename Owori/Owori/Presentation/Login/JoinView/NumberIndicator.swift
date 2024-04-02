//
//  NumberIndicator.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct NumberIndicator: View {
    let numbers: [String] = ["0", "1", "2", "3", "4"]
    @Binding var currentIndex: Int
    let numberFocused: [String] = ["Focused1","Focused2","Focused3","Focused4","Focused5"]
    let numberUnfocused: [String] = ["Unfocused1","Unfocused2","Unfocused3","Unfocused4","Unfocused5"]
    
    var body: some View {
        if 0 < currentIndex && currentIndex <= 4 {
            ZStack {
                Image("NavigatorLine")
                HStack(spacing: 30) {
                    ForEach(0 ..< numbers.count, id: \.self) { index in
                        if index != 0 {
                            if currentIndex == index {
                                Image(numberFocused[index-1])
                                    .frame(width: 20, height: 20)
                                
                            } else {
                                Image(numberUnfocused[index-1])
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct NumberIndicator_Previews: PreviewProvider {
    static var previews: some View {
        NumberIndicator(currentIndex: .constant(1))
    }
}
