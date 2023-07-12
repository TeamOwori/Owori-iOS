//
//  NumberIndicator.swift
//  Owori
//
//  Created by 신예진 on 7/12/23.
//

import SwiftUI

struct NumberIndicator: View {
    let numbers: [String] = ["1", "2", "3", "4", "5"]
    
    
    var body: some View {
        ForEach(numbers, id: \.self) { number in
            Circle()
                .foregroundColor(Color.oworiOrange)
                .frame(width: 20, height: 20)
                .overlay(
                Text(number)
                    .foregroundColor(.white)
                )
        }
    }
}

struct NumberIndicator_Previews: PreviewProvider {
    static var previews: some View {
        NumberIndicator()
    }
}
