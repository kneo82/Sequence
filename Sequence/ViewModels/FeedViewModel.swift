//
//  FeedViewModel.swift
//  Sequence
//
//  Created by Vitaliy Voronok on 29.04.2020.
//  Copyright © 2020 Vitaliy Voronok. All rights reserved.
//

import Foundation

final public class FeedViewModel: ObservableObject {
    private var feedDataProvider: FeedDataProvider
    
    @Published var feedData: [FeedData]
    
    init(feedDataProvider: FeedDataProvider) {
        self.feedDataProvider = feedDataProvider
        self.feedData = feedDataProvider.feedMockData()
    }
}
