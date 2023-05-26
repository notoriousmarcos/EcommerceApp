//
//  RoundedImageView.swift
//  
//
//  Created by Marcos Vinicius Brito on 01/03/23.
//

import SwiftUI

struct RoundedImageView: View {
    private var image: UIImage?
    private var url: URL?

    init(url: URL) {
        self.url = url
    }

    init(image: UIImage) {
        self.image = image
    }

    init?(stringURL: String) {
        guard let url = URL(string: stringURL) else { return nil }
        self.url = url
    }

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .padding()
                .cornerRadius(16)
        } else {
            AsyncImage(url: url)
                .padding()
                .cornerRadius(16)
        }
    }
}

struct RoundedImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedImageView(url: URL(string: "https://lojaanker.vteximg.com.br/arquivos/ids/155867-1000-1000/A90160A1-TD01-V2.jpg?v=637252540193600000")!)

            RoundedImageView(image: UIImage.add)

            RoundedImageView(stringURL: "https://lojaanker.vteximg.com.br/arquivos/ids/155867-1000-1000/A90160A1-TD01-V2.jpg?v=637252540193600000")
        }
    }
}
