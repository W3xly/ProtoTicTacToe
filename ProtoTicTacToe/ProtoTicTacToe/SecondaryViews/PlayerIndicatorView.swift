//
//  PlayerIndicatorView.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI

struct PlayerIndicatorView: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(systemImageName == "multiply" ? .red : .blue)
    }
}

struct PlayerIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIndicatorView(systemImageName: "multiply")
    }
}
