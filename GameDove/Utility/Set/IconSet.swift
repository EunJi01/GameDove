//
//  IconSet.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

struct IconSet {
    static let platformList = UIImage(systemName: "list.triangle") // 플랫폼 리스트 메뉴
    static let calendar = UIImage(systemName: "calendar.badge.clock") // 인기작 기간
    static let search = UIImage(systemName: "magnifyingglass") // 검색
    
    static let xmark = UIImage(systemName: "xmark") // 창 닫기
    static let archivebox = UIImage(systemName: "archivebox") // 보관함 저장
}

struct TabBarIconSet {
    static let rating = UIImage(systemName: "crown") // 인기작
    static let ratingSelected = UIImage(systemName: "crown.fill")
    
    static let newly = UIImage(systemName: "gamecontroller") // 신작
    static let newlySelected = UIImage(systemName: "gamecontroller.fill")
    
    static let upcoming = UIImage(systemName: "books.vertical") // 출시예정작
    static let upcomingSelected = UIImage(systemName: "books.vertical.fill")
    
    static let setting = UIImage(systemName: "gearshape") // 설정
    static let settingSelected = UIImage(systemName: "gearshape.fill")
}
