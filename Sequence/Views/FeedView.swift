//
//  FeedView.swift
//  Sequence
//
//  Created by Vitaliy Voronok on 29.04.2020.
//  Copyright © 2020 Vitaliy Voronok. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: "Search")
                List(viewModel.feedData) { item in
                    NavigationLink(destination: self.destination(name: item.name), label: {
                        Text(item.name)
                    })
                }
            }
            .navigationBarTitle("Feeds")
        }
    }
    
    private func destination(name: String) -> AnyView {
        switch name {
        case "Array":
            return AnyView(ArrayView())
        case "Set":
            return AnyView(SetView())
        case "Dictionary":
            return AnyView(DictionaryView())
        case "SuffixArray":
            return AnyView(SuffixArrayView())
        default:
            return AnyView(EmptyView())
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
