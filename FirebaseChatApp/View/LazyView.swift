//
//  LazyView.swift
//  FirebaseChatApp
//
//  Created by khawlah khalid on 19/12/2021.
//

import SwiftUI


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

