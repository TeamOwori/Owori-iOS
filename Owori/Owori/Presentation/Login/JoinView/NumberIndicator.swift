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
    let numberFocused: [ImageResource] = [.focused1, .focused2, .focused3, .focused4]
    let numberUnfocused: [ImageResource] = [.unfocused1, .unfocused1, .unfocused3, .unfocused4]
    
    var body: some View {
        if 0 < currentIndex && currentIndex <= 4 {
            ZStack {
                Image(.indicatorLine)
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
