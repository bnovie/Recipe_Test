//
//  MyAsyncImage.swift
//  Recipe_Test
//
//  Created by Brian Novie on 9/11/24.
//

import SwiftUI

struct AsyncThumbnail: View {
    let url:URL?
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            EmptyView()
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    AsyncThumbnail(url: URL(string: "https:\\www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"), size:48)
}
