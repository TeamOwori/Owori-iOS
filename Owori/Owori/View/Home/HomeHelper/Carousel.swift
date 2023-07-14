//
//  Carousel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/15.
//

import SwiftUI

struct Carousel<Items : View> : View {
    @EnvironmentObject var UIState: UIStateModel
    
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        
        @ViewBuilder _ items: () -> Items) {
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing /* - 50 */
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
                
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        if (calcOffset != Float(nextOffset)) { calcOffset = Float(activeOffset) + UIState.screenDrag }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset) /* - 50 */)
        .gesture(DragGesture().onChanged {
            //withAnimation(.default) {
            self.UIState.screenDrag = Float($0.translation.width)
            //}
        }.onEnded {
            self.UIState.screenDrag = 0
            
            let translation = $0.translation.width
            let threshold: CGFloat = 50
            
            // Vibration
            let impactVibration = UIImpactFeedbackGenerator(style: .soft)
            impactVibration.impactOccurred()
            
            // Card Swipe Gesture
            if translation < -threshold && self.UIState.activeCard < Int(numberOfItems) - 1 {
                self.UIState.activeCard += 1 // Left Swipe Gesture
            } else if translation > threshold && self.UIState.activeCard > 0 {
                self.UIState.activeCard -= 1 // Right Swipe Gesture
            }
        })
    }
}
