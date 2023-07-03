//
//  MovieKeywords.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI
import UI

struct MovieKeywords: View {
    let keywords: [Keyword]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Keywords")
                .titleStyle()
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(keywords) {keyword in
                        NavigationLink(destination: MovieKeywordList(keyword: keyword)) {
                            RoundedBadge(text: keyword.name, color: .steam_background)
                        }
                    }
                }.padding(.leading)
            }
        }
            .listRowInsets(EdgeInsets())
            .padding(.vertical)
    }
}

#if DEBUG
struct MovieKeywords_Previews: PreviewProvider {
    static var previews: some View {
        MovieKeywords(keywords: [Keyword(id: 0, name: "Test")])
    }
}
#endif
