//
//  NumberIndicator.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct NumberIndicator: View {
    let numbers: [String] = ["0", "1", "2", "3", "4", "5"]
    @Binding var currentIndex: Int
    
    
    
    
    var body: some View {
        if 0 < currentIndex && currentIndex <= 5 {
            ZStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.oworiOrange)
                    .frame(width: 140)
                HStack(spacing: 20) {
                    ForEach(0 ..< numbers.count, id: \.self) { index in
                        if index != 0 {
                            if currentIndex == index {
                                Circle()
                                    .foregroundColor(Color.oworiOrange)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Text(numbers[index])
                                            .foregroundColor(.white)
                                    )
                            } else {
                                
                                Circle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Text(numbers[index])
                                            .foregroundColor(.gray)
                                    )
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
