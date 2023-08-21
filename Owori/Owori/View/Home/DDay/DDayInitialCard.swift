//
//  DDayInitialCard.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct DDayInitialCard: View {
    
    @Binding var isAddDdayViewActive: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.oworiMain.ignoresSafeArea()
            
            NavigationLink {
                WriteDDay()
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 12)
//                                .inset(by: 0.5)
//                                .stroke(Color.gray/*300*/, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
//                        )
                    VStack(spacing: 25) {
                        Text("D-day를 추가해봐요")
                            .foregroundColor(Color.oworiGray500)
                            .frame(width: 260, height: 140)
                    }
                    
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DDayCard_Previews: PreviewProvider {
    static var previews: some View {
        DDayInitialCard(isAddDdayViewActive: .constant(false))
    }
}
