//
//  CustomToast.swift
//  baltini-swift
//
//  Created by Roberto Kreshna on 27/10/23.
//

import Foundation
import Toast_Swift
import TTGSnackbar

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
    
    static func showGrayUndoToast(msg: String, sender: UIViewController) {
        let snackbar = TTGSnackbar()
        snackbar.backgroundColor = .brandGray
        snackbar.customContentView = getUndoToastContent(msg: msg, close: snackbar.dismiss)
        snackbar.duration = .middle
        snackbar.show()
    }
    
    static func getUndoToastContent(msg: String, close: @escaping () -> Void ) -> UIStackView {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.backgroundColor = .brandGray
        stackview.axis = .horizontal
        stackview.spacing = 8
        
        let label = UILabel()
        label.text = msg
        label.textColor = .black
        label.font = UIFont(name: "Futura-Medium", size: 12)!
        label.numberOfLines = 0
        
        let undo = CustomButton.createUnderlinedButton(title: "UNDO", action: UIAction(handler: { action in
            CommonStore.shared.removeLatest()
            close()
        }))
        
        let close = CustomButton.createImageButton(imageName: "icCloseSmall", tapped: UIAction(handler: { action in
            close()
        }))
        
        stackview.addArrangedSubview(label)
        stackview.addArrangedSubview(undo)
        stackview.addArrangedSubview(close)
        
        return stackview
    }
}
