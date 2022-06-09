//
//  GameSquareView.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .frame(width: proxy.size.width / 5, height: proxy.size.width / 5)
            .foregroundColor(.clear)
            .border(.black, width: 1)
    }
}
