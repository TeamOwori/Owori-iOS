//
//  Canvas.swift
//  Owori
//
//  Created by 드즈 on 2023/07/15.
//

import SwiftUI

struct Canvas<Content : View> : View {
    @EnvironmentObject var UIState: UIStateModel
    
    let content: Content
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.oworiMainColor.edgesIgnoringSafeArea(.all))
    }
}
