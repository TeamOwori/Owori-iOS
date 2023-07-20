//
//  CustomToggle.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct CustomToggle: ToggleStyle {
    private let width = 30
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            ZStack(alignment: configuration.isOn ? .leading : .trailing) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 30, height: 18)
                    .foregroundColor(configuration.isOn ? Color.oworiGray300 : Color.oworiOrange)
                Circle()
                    .frame(width: 14, height: 14, alignment: .leading)
                    .padding(2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                    }
            }
        }
    }
}
