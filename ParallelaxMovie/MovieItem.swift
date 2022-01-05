//
//  MovieItem.swift
//  ParallelaxMovie
//
//  Created by Ierchenko Anna  on 12/20/21.
//

import SwiftUI

struct MovieItem: View {
    let movie: Movie
    let screenSize: CGSize
    let width: CGFloat
    
    var body: some View {
        GeometryReader { reader in
            
            //adding  scale effect
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping: CGFloat = 4.5
            let percentage = abs(distance / (screenSize.width / 2) / damping - 1)
            
            VStack {
                Image(movie.imgString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .shadow(color: .black.opacity(0.6), radius: 14, y: 10)
                Text(movie.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                //star raiting
                HStack(spacing: 5) {
                    ForEach(1 ..< 6) { i in
                        Image(systemName: i <= movie.rating ? "star.fill" : "star")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .scaleEffect(percentage)
            }
        
        .frame(width: width)
        .frame(maxHeight: .infinity)
  //      .background(Color.red)
        
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
