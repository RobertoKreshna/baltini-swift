//
//  CustomToast.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import Foundation
import Toast_Swift

class CustomToast {
    static func showErrorToast(msg: String, sender: UIViewController){
        var style = ToastStyle()
        style.backgroundColor = UIColor.toastFail
        style.messageColor = UIColor.white
        style.messageFont = UIFont(name: "Futura-Medium", size: 12)!
        sender.view.makeToast(msg, duration: 2.0, position: .bottom, style: style)
    }
    
    static func showSuccessToast(msg: String, sender: UIViewController){
        var style = ToastStyle()
        style.backgroundColor = UIColor.toastSuccess
        style.messageColor = UIColor.white
        style.messageFont = UIFont(name: "Futura-Medium", size: 12)!
        sender.view.makeToast(msg, duration: 2.0, position: .bottom, style: style)
    }
    
    static func showGrayToast(msg: String, sender: UIViewController) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.brandGray
        style.messageColor = UIColor.black
        style.messageFont = UIFont(name: "Futura-Medium", size: 12)!
        sender.view.makeToast(msg, duration: 2.0, position: .bottom, style: style) { didTap in
            if didTap {
                CommonStore.shared.removeLatest()
            }
        }
    }
}
