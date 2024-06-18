//
//  TextModifiers.swift
//  Lab4SwiftUi
//
//  Created by Juan jose Morales on 19/6/24.
//

import Foundation
import SwiftUI

struct UserInfoLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white.opacity(0.8))
            .foregroundColor(.black)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct UserInfoText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white.opacity(0.8))
            .foregroundColor(.black)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
