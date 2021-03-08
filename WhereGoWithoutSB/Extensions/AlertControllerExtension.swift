//
//  AlertControllerExtension.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol AlertDisplayer {
  func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
  func displayAlertForgotPassKeys(with title: String, message: String)
}

extension AlertDisplayer where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        alertController.view.tintColor = ColorPalette.blue
        present(alertController, animated: true)
        
    }
    
    
    
    func displayAlertForgotPassKeys(with title: String, message: String) {
        var currentEmail: String? = ""
        let action = UIAlertAction(title: "OK", style: .default)
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Введите почту"
        })
        
        alertController.addAction(UIAlertAction(title: "Отправить", style: .default, handler: { [weak alertController] (_) in
            let textField = alertController?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            currentEmail = textField?.text
            do { Auth.auth().sendPasswordReset(withEmail: currentEmail!) { error in
                    if error == nil{
                        print ("some")
                        self.displayAlert(with: "На вашу почту была отправлена ссылка, перейдя по которой вы сможете сбросить пароль :)", message: "", actions: [action])
                    } else {
                        self.displayAlert(with: "Очень возможно, что вы ввели некорректную почту", message: "", actions: [action])
                        print ("Не удалось отправить на почту письмо для востановления пароля")
                    }
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertController.view.tintColor = ColorPalette.blue
        present(alertController, animated: true)
    }
}



