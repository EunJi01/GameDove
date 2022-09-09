//
//  IconSet.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

struct IconSet {
    static let platformList = UIImage(systemName: "list.triangle") // 플랫폼 리스트 메뉴
    static let setting = UIImage(systemName: "gearshape") // 설정 (즐겨찾기 탭에 배치)
    static let calendar = UIImage(systemName: "calendar.badge.clock") // 인기작 기간
    
    static let preview = UIImage(systemName: "film") // 예고편
}

struct TabBarIconSet {
    static let rating = UIImage(systemName: "crown") // 인기작
    static let ratingSelected = UIImage(systemName: "crown.fill")
    
    static let newly = UIImage(systemName: "gamecontroller") // 신작
    static let newlySelected = UIImage(systemName: "gamecontroller.fill")
    
//    static let  // 검색
//    static let
    
    static let star = UIImage(systemName: "star") // 즐겨찾기
    static let starSelected = UIImage(systemName: "star.fill")
}
