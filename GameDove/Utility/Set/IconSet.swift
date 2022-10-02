//
//  IconSet.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

struct IconSet {
    static let sideMenu = UIImage(systemName: "list.triangle") // 사이드 메뉴
    static let calendar = UIImage(systemName: "calendar.badge.clock") // 인기작 기간
    static let search = UIImage(systemName: "magnifyingglass") // 검색
    static let down = UIImage(systemName: "chevron.down") // 플랫폼 변경 (아래로 내리기)
    
    static let trayDown = UIImage(systemName: "tray.and.arrow.down.fill") // 보관하기
    static let share = UIImage(systemName: "square.and.arrow.up") // 공유하기
    
    static let xmark = UIImage(systemName: "xmark") // 창 닫기
    static let trash = UIImage(systemName: "trash.fill") // 삭제
    static let check = UIImage(systemName: "checkmark") // 체크 옵션
    static let reload = UIImage(systemName: "arrow.triangle.2.circlepath") // 새로고침
}

struct TabBarIconSet {
    static let rating = UIImage(systemName: "crown") // 인기작
    static let ratingSelected = UIImage(systemName: "crown.fill")
    
    static let newly = UIImage(systemName: "gamecontroller") // 신작
    static let newlySelected = UIImage(systemName: "gamecontroller.fill")
    
    static let upcoming = UIImage(systemName: "books.vertical") // 출시예정작
    static let upcomingSelected = UIImage(systemName: "books.vertical.fill")
}

struct SideMenuIconSet {
    static let storage = UIImage(systemName: "tray.full") // 보관함
    static let setting = UIImage(systemName: "gearshape") // 설정
}
