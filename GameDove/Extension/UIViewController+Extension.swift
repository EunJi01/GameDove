//
//  UIViewController+Extension.swift
//  MemoProject
//
//  Created by 황은지 on 2022/08/31.
//

import UIKit
import MessageUI
import DeviceKit

extension UIViewController {
    
    enum TransitionStyle {
        case present // 네비게이션 없이 Present
        case presentNavigation // 네비게이션 임베드 Present
        case presentFullNavigation // 네비게이션 풀스크린
        case presentOverFull // 팝업용
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            self.present(nav, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        case .presentOverFull:
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        }
    }
    
    func openAppstore(id: Int) {
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id\(id)?action=write-review") else {
            return
        }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    func openWeb(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["hej0102@naver.com"])
            mail.setSubject("게임도브 문의 - ")
            mail.setMessageBody(
            """
            OS Version: \(UIDevice.current.systemVersion)
            Device : \(DeviceKit.Device.current)
            App Viersion: \(Settings.version.rightDetail())
            """, isHTML: false)
            self.present(mail, animated: true)
        } else {
            view.makeToast(LocalizationKey.mailRegistration.localized)
        }
    }
}

