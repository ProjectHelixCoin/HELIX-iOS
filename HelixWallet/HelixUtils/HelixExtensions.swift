//
//  Extensions.swift
//  BreadWallet
//
//  Created by German Mendoza on 9/22/17.
//  Copyright © 2017 Aaron Voisine. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @objc static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat = 1)->UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func fromHexString(hex:String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.characters.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor.rgb(CGFloat((rgbValue & 0xFF0000) >> 16), green: CGFloat((rgbValue & 0x00FF00) >> 8), blue: CGFloat(rgbValue & 0x0000FF))
    }
    
}

extension UIApplication {
var statusBarView: UIView? {

    if #available(iOS 13.0, *) {
        let tag = 3848245

        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first

        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }

    } else {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}

extension UIView {

    func border(cornerRadius:CGFloat, color:UIColor? = nil){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        
        if let unwrappedColor = color {
            self.layer.borderWidth = 2
            self.layer.borderColor = unwrappedColor.cgColor
        }
    }
}

extension Notification.Name {
    
    static let kReachabilityChangedNotification = Notification.Name("kNetworkReachabilityChangedNotification")
    static let BRWalletBalanceChangedNotification = Notification.Name("BRWalletBalanceChangedNotification")
    static let BRWalletManagerSeedChangedNotification = Notification.Name("BRWalletManagerSeedChangedNotification")
    static let BRPeerManagerSyncStartedNotification = Notification.Name("BRPeerManagerSyncStartedNotification")
    static let BRPeerManagerSyncFinishedNotification = Notification.Name("BRPeerManagerSyncFinishedNotification")
    static let BRPeerManagerSyncFailedNotification = Notification.Name("BRPeerManagerSyncFailedNotification")
    static let BRPeerManagerTxStatusNotification = Notification.Name("BRPeerManagerTxStatusNotification")
}
