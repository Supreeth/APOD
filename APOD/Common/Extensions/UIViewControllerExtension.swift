//
//  UIViewControllerExtension.swift
//  APOD
//
//  Created by Supreeth Doddabela on 11/09/2022.
//

import UIKit

extension UIViewController {

    func presentAlert(withTitle title: String, message : String, actions : [String: UIAlertAction.Style], completionHandler: ((UIAlertAction) -> ())? = nil) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            let action = UIAlertAction(title: action.key, style: action.value) { action in
                if completionHandler != nil {
                    completionHandler!(action)
                }
            }
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
