//
//  Localization.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

struct LocalizationKey {
    // TabBarController
    static let newGames = "new_games"
    static let popularGames = "popular_games"
    static let upcomingGames = "upcoming_games"
    static let storage = "storage"
    static let settings = "settings"
    static let inDetail = "inDetail"

    // DetailsViewController
    static let title = "title"
    static let genres = "genres"
    static let platforms = "platforms"
    static let released = "released"
    static let playtime = "playtime"
    static let metascore = "metacritic"
    static let updated = "updated"
    static let noData = "no_data"
    static let failedImage = "failed_image"
    
    // Period
    static let all = "all"
    static let week = "week"
    static let month = "month"
    static let halfYear = "half_year"
    static let year = "year"
    static let years3 = "3years"
    static let period = [all, week, month, halfYear, year, years3]

    // SearchViewController
    static let searchPlaceholder = "search_placeholder"
    static let noResults = "no_results"
    
    // SettingsViewController
    static let stored = "stored"
    static let failedStore = "failed_store"
    static let mainPlatform = "main_platform"
    static let contact = "contact"
    static let review = "review"
    static let licenses = "licenses"
    static let version = "version"
    static let mailRegistration = "mail_registration"
    static let cancel = "cancel"
    static let changedMainPlatform = "changed_main_platform"
    
    static let errorAlert = "error_alert"
}
