//
//  AuthErrorCodeExtension.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 30.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import Firebase

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "Эта почта уже используется другой учетной записью"
        case .userNotFound:
            return "Учетная запись не найдена для указанного пользователя. Пожалуйста, проверьте и попробуйте еще раз"
        case .userDisabled:
            return "Ваша учетная запись была отключена. Пожалуйста, свяжитесь со службой поддержки."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Пожалуйста, введите корректный адрес электронной почты."
        case .networkError:
            return "Ошибка сети. Пожалуйста, попробуйте еще раз."
        case .weakPassword:
            return "Ваш пароль слишком слаб. Пароль должен быть длиной не менее 6 символов."
        case .wrongPassword:
            return "Ваш пароль неверен. Пожалуйста, попробуйте еще раз или используйте \"Забыли пароль\", чтобы сбросить свой пароль"
        default:
            return "Произошла неизвестная ошибка"
        }
    }
}
