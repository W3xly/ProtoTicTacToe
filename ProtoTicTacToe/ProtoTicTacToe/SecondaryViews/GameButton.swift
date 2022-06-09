//
//  GameButton.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI

struct GameButton: View {
    
    let title: String
    let backgroundColor: Color
    let buttonTap: () -> ()
    
    var body: some View {
        Button {
            buttonTap()
        } label: {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(backgroundColor)
                .cornerRadius(20)
        }
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(title: "PLAY", backgroundColor: .red) {
            print("PLAY")
        }
    }
}
