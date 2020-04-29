//
//  FeedViewModel.swift
//  Sequence
//
//  Created by Vitaliy Voronok on 29.04.2020.
//  Copyright © 2020 Vitaliy Voronok. All rights reserved.
//

import Foundation

final public class FeedViewModel: ObservableObject {
    
    // MARK: Properties
    
    private var feedDataProvider: FeedDataProvider
    private var prefixeArray:[(suffix: String, name: String)] = []
    
    private var allItems: [FeedData]
    
    @Published var feedData: [FeedData]
    @Published var searchText : String = "" {
        didSet {
            self.search(text: searchText)
        }
    }
    
    // MARK: Initialization
    
    init(feedDataProvider: FeedDataProvider) {
        self.feedDataProvider = feedDataProvider
        var allItems = feedDataProvider.feedMockData().map {
            $0.name
        }
        allItems.append(contentsOf: Services.algoProvider.all)
        
        let feedAllItems = allItems.map {
                    FeedData(name: $0)
               }
        self.feedData = feedAllItems
        self.allItems = feedAllItems
        
        self.configurePrefixArray(items: allItems)
    }
    
    // MARK: Private
    
    private func search(text: String) {
        if text.isEmpty {
            self.feedData = self.allItems
        } else {
            let result = SubSequenceSearch.search(query: text, suffixArray: prefixeArray).map {
                FeedData(name: $0)
            }
            
            self.feedData = result
        }
        
        self.objectWillChange.send()
    }
    
    private func configurePrefixArray(items: [String]) {
        var array: [(suffix: String, name: String)] = []
        for word in items {
            let sequence = PrefixSequence(string: word)
            for prefix in sequence {
                array.append((suffix: String(prefix), name: word))
            }
        }
        
        array.sort { $0.suffix < $1.suffix }
        
        self.prefixeArray = array
    }
}
