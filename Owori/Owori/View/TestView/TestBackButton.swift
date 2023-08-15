//
//  TestBackButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/16.
//

import SwiftUI

struct TestBackButton: View {
    var label: String
        
        var body: some View {
            Button(action: {
                // Handle back button action if needed
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                    Text(label)
                }
            }
        }
}

struct TestBackButton_Previews: PreviewProvider {
    static var previews: some View {
        TestBackButton(label: "arrow.left.circle.fill")
    }
}
