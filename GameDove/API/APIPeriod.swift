//
//  RatingViewController+Extension.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import Foundation

let defaultStartDate = "2000-01-01"
let defaultEndDate = "2099-12-31"

enum APIPeriod: String, CaseIterable {
    case all
    case week
    case month
    case halfYear
    case year
    case years3
    
    func periodDate() -> String {
        switch self {
        case .all:
            return defaultStartDate
        case .week:
            return dateFormat(previous: -6)
        case .month:
            return dateFormat(previous: -30)
        case .halfYear:
            return dateFormat(previous: -180)
        case .year:
            return dateFormat(previous: -365)
        case .years3:
            return dateFormat(previous: -(365 * 3))
        }
    }
    
    private func dateFormat(previous: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let startDate = Calendar.current.date(byAdding: .day, value: previous, to: Date()) else {
            print("Period - dateFormat 오류 발생")
            return ""
        }
        
        return formatter.string(from: startDate)
    }
}
