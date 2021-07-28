//
//  Review.swift
//  Biniva
//
//  Created by Nick Oltyan on 28.07.2021.
//

import StoreKit

enum AppStoreReviewManager {
    
    static func requestReview() {
        SKStoreReviewController.requestReview()
    }

}
