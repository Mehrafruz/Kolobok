//
//  SingInViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 02.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import Foundation
import Firebase

protocol SignInDelegate: AnyObject{
    func openSignUp()
    func dismissWelcomeView()//MARK: интересная ситуация, нельзя называть одинаково функции 2 разных делегатов от которых наследуется 1 класс, ошибки не будет но и работать не будет 1 из функций
}

class SignInViewController: UIViewController, AlertDisplayer, UserSettingsInput{


    weak var delegate: SignInDelegate?
    private var scrollView = UIScrollView()
    private var goBackButton = UIButton()
    private var loginLabel = UILabel()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private let customLine0 = UITableViewCell()
    private let customLine1 = UITableViewCell()
    private var emailImageView = UIImageView()
    private var lockImageView = UIImageView()
    private var rememberMeButton = UIButton()
    private var rememberMeLabel = UILabel()
    private let forgotPassTextView = UITextView()
    private var signInButton = UIButton()
    private var signUpWithLabel = UILabel()
    private var signUpWithFacebookButton = UIButton()
    private var signUpWithAppleButton = UIButton()
    private let signUpTextView = UITextView()
    private var flag = true
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerForKeyboardNotifikation()
        
        presentationController?.delegate = self
        isModalInPresentation = true
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        setup()
    }
    
    deinit {
        removeForKeyboardNotifikation()
    }
    
    func registerForKeyboardNotifikation(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifikation(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height/3)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    

    func setup(){
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
        setupLabel(label: loginLabel, text: "Вход", fontSize: 40)
        setupLabel(label: rememberMeLabel, text: "Запомнить?", fontSize: 16)
        setupLabel(label: signUpWithLabel, text: "или авторизоваться с", fontSize: 16)
        signUpWithLabel.textColor = ColorPalette.gray
        
        setupImageView(imageView: emailImageView, imageNamed: "envelope.fill")
        setupImageView(imageView: lockImageView, imageNamed: "lock.fill")
        setupTextField(textField: emailTextField, placeholder: "Email")
        setupTextField(textField: passwordTextField, placeholder: "Пароль")
        
        setupButton(button: signInButton, title: "Войти", color: ColorPalette.gray, textColor: UIColor.white)
        setupLittleButton(button: rememberMeButton, image: UIImage(systemName: "square")!, tintColor: ColorPalette.gray)
        setupLittleButton(button: goBackButton, image: UIImage(systemName: "arrow.left")!, tintColor: ColorPalette.black)
        setupLittleButton(button: signUpWithFacebookButton, image: UIImage(named: "facebooklogo")!, tintColor: .white)
        setupLittleButton(button: signUpWithAppleButton, image: UIImage(named: "applelogo")!, tintColor: .white)
        goBackButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        rememberMeButton.addTarget(self, action: #selector(didClickedRememberMeButton), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(didClickedSignInButton), for: .touchUpInside)
        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        setupTextView(textView: forgotPassTextView, text: "Забыли пароль?", value: "forgotPass", location: 0, length: "Забыли пароль?".count)
        setupTextView(textView: signUpTextView, text: "Новый пользователь? Зарегистрироваться.", value: "signUp", location: 20, length: "Новый пользователь? Зарегистрироваться.".count-20)
        
        view.addSubview(scrollView)
        [goBackButton, loginLabel, emailTextField, passwordTextField, emailImageView, lockImageView, rememberMeLabel, rememberMeButton, forgotPassTextView, signInButton, signUpTextView, signUpWithLabel, signUpWithFacebookButton, customLine0, customLine1, signUpWithAppleButton].forEach {
            scrollView.addSubview($0)
        }
        
        addConstraint()
    }
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didClickedRememberMeButton() {
        if flag {
            rememberMeButton.setBackgroundImage( UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flag = false
        } else {
            rememberMeButton.setBackgroundImage( UIImage(systemName: "square"), for: UIControl.State.normal)
            flag = true
//            do{
//                try Auth.auth().signOut()
//            } catch {
//                print ("не удалось выйти из аккаунта")
//            }
        }
    }
    
    @objc
    func didClickedSignInButton() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let reason = "Заполните все поля"
        guard let email = emailTextField.text, email != "" else{
            print ("emailTextField is empty")
            showAlert(reason: reason)
            return
        }
        guard let password = passwordTextField.text, password != "" else{
            print ("passwordTextField is empty")
            showAlert(reason: reason)
            return
        }
        
        if (!email.isEmpty && !password.isEmpty){
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    let currentUserId = Auth.auth().currentUser?.uid
                    self.getInfo(id: currentUserId ?? "", key: "name") { resultString in
                        globalAppUser.id = String(currentUserId ?? "")
                        globalAppUser.name = resultString
                        globalAppUser.email = email
                        self.getInfo(id: currentUserId ?? "", key: "avatarURL") { resultString in
                            globalAppUser.avatarURL = resultString
                            self.saveUser(id: globalAppUser.id, name: globalAppUser.name, email: email, imageData: globalAppUser.avatarURL, rememberUser: !self.flag)
                        }
                    }
                   
                    self.loadFavoritePlaces(currentUserId: currentUserId ?? "")
                    self.loadViewedPlaces(currentUserId: currentUserId ?? "")
                    self.dismiss(animated: true, completion: {
                        self.delegate?.dismissWelcomeView()
                    })
                }
            }
        } else {
            showAlert(reason: reason)
        }
    }
    
    func getInfo(id: String, key: String, completion: @escaping (String) -> Void) {
        var result = ""
        let rootReference = Database.database().reference()
        let nameReference = rootReference.child("users").child(id).child(key)
        nameReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            result = DataSnapshot.value as? String ?? "0"
            completion(result)
        }
    }
    
    func saveUser(id: String, name: String, email: String, imageData: String, rememberUser: Bool){
        self.addUserData(id: id, name: name, email: email, imageData: imageData, rememberUser: rememberUser)
    
    }
    
    func showAlert(reason: String){
        let title = "Ошибка"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
    
    func setupLabel(label: UILabel, text: String, fontSize: CGFloat){
        label.font = UIFont(name: "POEVeticaVanta", size: fontSize)
        //label.layer.zPosition = 1.5
        label.textColor = ColorPalette.black
        label.text = text
        label.textAlignment = .center
    }
    
    func setupTextField(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.font = UIFont(name: "POEVeticaVanta", size: 16)
        textField.textColor = ColorPalette.black
        textField.backgroundColor = UIColor.white
    }
    
    func setupImageView(imageView: UIImageView, imageNamed: String){
        imageView.image = UIImage(systemName: imageNamed)
        imageView.tintColor = ColorPalette.yellow
    }
    
    func setupTextView(textView: UITextView, text: String, value: String, location: Int, length: Int) {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "POEVeticaVanta", size: 16)]
        textView.delegate = self
        textView.backgroundColor = .white
        let text = NSMutableAttributedString(string: text, attributes: attribute as [NSAttributedString.Key : Any])
        text.addAttribute(.link, value: value, range: NSRange(location: location, length: length))
        UITextView.appearance().linkTextAttributes = [ .foregroundColor: ColorPalette.yellow]
        textView.attributedText = text
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 20)
        button.backgroundColor = color
        button.layer.zPosition = 1.5
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.6
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setupLittleButton(button: UIButton, image: UIImage, tintColor: UIColor) {
        let image = image
        button.setBackgroundImage( image, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
    }
    
    func addConstraint(){
        [goBackButton, loginLabel, emailTextField, passwordTextField, emailImageView, lockImageView, rememberMeLabel, rememberMeButton, forgotPassTextView, signInButton, signUpTextView, signUpWithLabel, signUpWithFacebookButton, customLine0, customLine1, signUpWithAppleButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            goBackButton.widthAnchor.constraint(equalToConstant: 30),
            goBackButton.heightAnchor.constraint(equalToConstant: 30),
            goBackButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            goBackButton.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.widthAnchor.constraint(equalToConstant: 250),
            loginLabel.heightAnchor.constraint(equalToConstant: 50),
            loginLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -220)
        ])
        
        NSLayoutConstraint.activate([
            emailImageView.widthAnchor.constraint(equalToConstant: 30),
            emailImageView.heightAnchor.constraint(equalToConstant: 25),
            emailImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -125),
            emailImageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -132)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -130)
        ])
        
        NSLayoutConstraint.activate([
            customLine0.widthAnchor.constraint(equalToConstant: 300),
            customLine0.heightAnchor.constraint(equalToConstant: 0.5),
            customLine0.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            customLine0.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -114)
        ])
        
        NSLayoutConstraint.activate([
            lockImageView.widthAnchor.constraint(equalToConstant: 30),
            lockImageView.heightAnchor.constraint(equalToConstant: 30),
            lockImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -125),
            lockImageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -71)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -70)
        ])
        
        NSLayoutConstraint.activate([
            customLine1.widthAnchor.constraint(equalToConstant: 300),
            customLine1.heightAnchor.constraint(equalToConstant: 0.5),
            customLine1.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            customLine1.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -54)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 150),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 70)
        ])
        
        NSLayoutConstraint.activate([
            rememberMeButton.widthAnchor.constraint(equalToConstant: 40),
            rememberMeButton.heightAnchor.constraint(equalToConstant: 40),
            rememberMeButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -132),
            rememberMeButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            rememberMeLabel.widthAnchor.constraint(equalToConstant: 125),
            rememberMeLabel.heightAnchor.constraint(equalToConstant: 50),
            rememberMeLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -65),
            rememberMeLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            forgotPassTextView.widthAnchor.constraint(equalToConstant: 125),
            forgotPassTextView.heightAnchor.constraint(equalToConstant: 50),
            forgotPassTextView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 100),
            forgotPassTextView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -14)
        ])
        
        NSLayoutConstraint.activate([
            signUpWithLabel.widthAnchor.constraint(equalToConstant: 300),
            signUpWithLabel.heightAnchor.constraint(equalToConstant: 50),
            signUpWithLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signUpWithLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: view.bounds.midY/2)
        ])
        
        NSLayoutConstraint.activate([
            signUpWithFacebookButton.widthAnchor.constraint(equalToConstant: 40),
            signUpWithFacebookButton.heightAnchor.constraint(equalToConstant: 40),
            signUpWithFacebookButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -25),
            signUpWithFacebookButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 62*view.bounds.midY/100)
        ])
        
        NSLayoutConstraint.activate([
            signUpWithAppleButton.widthAnchor.constraint(equalToConstant: 35),
            signUpWithAppleButton.heightAnchor.constraint(equalToConstant: 40),
            signUpWithAppleButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 25),
            signUpWithAppleButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 62*view.bounds.midY/100)
        ])
        
        NSLayoutConstraint.activate([
            signUpTextView.widthAnchor.constraint(equalToConstant: 330),
            signUpTextView.heightAnchor.constraint(equalToConstant: 50),
            signUpTextView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signUpTextView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 8*view.bounds.midY/10)
        ])
    }
}



extension SignInViewController: UITextFieldDelegate, UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "forgotPass"{
            print ("_______cliced to link")
        }
       if URL.absoluteString == "signUp"{
            self.dismiss(animated: true, completion: {
                self.delegate?.openSignUp()
            })
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didClickedSignInButton()
        return true
    }
    
    
}


extension SignInViewController: FireStoreFavoritePlacesOutput{
    func loadViewedPlaces(currentUserId: String) {
       self.getArrayInfo(id: currentUserId, key: "viewedPlaces") { resultString in
            globalAppUser.viewedPlaces = resultString
        }
    }
    
    
    func loadFavoritePlaces(currentUserId: String) {
        self.getArrayInfo(id: currentUserId, key: "favoritePlaces") { resultString in
            globalAppUser.favoritePlaces = resultString
        }
    }
    
    func getArrayInfo(id: String, key: String, completion: @escaping ([Int]) -> Void) {
        var result: [Int] = []
        let rootReference = Database.database().reference()
        let nameReference = rootReference.child("users").child(id).child(key)
        nameReference.observeSingleEvent(of: .value) { (DataSnapshot) in
            result = DataSnapshot.value as? [Int] ?? []
            completion(result)
        }
    }
    
}


extension SignInViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print(#function)
    }
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print(#function)
    }
}
