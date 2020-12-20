//
//  SignUpViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 02.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class SignUpViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var goBackButton = UIButton()
    private var signinLabel = UILabel()
    private var nameTextField = UITextField()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var confirmPasswordTextField = UITextField()
    private let customLine0 = UITableViewCell()
    private let customLine1 = UITableViewCell()
    private let customLine2 = UITableViewCell()
    private let customLine3 = UITableViewCell()
    private var personImageView = UIImageView()
    private var emailImageView = UIImageView()
    private var lockImageView0 = UIImageView()
    private var lockImageView1 = UIImageView()
    private var signUpButton = UIButton()
    private var signUpWithLabel = UILabel()
    private var signUpWithFacebookButton = UIButton()
    private var signUpWithAppleButton = UIButton()
    private let signInTextView = UITextView()
    private var flag = true

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerForKeyboardNotifikation()
        
        if didDismissViewFlag{
            self.dismiss(animated: false, completion: nil)
        }
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
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
        
        setupLabel(label: signinLabel, text: "Регистрация", fontSize: 40)
        setupLabel(label: signUpWithLabel, text: "или зарегистрироваться с", fontSize: 16)
        signUpWithLabel.textColor = ColorPalette.gray
        
        setupImageView(imageView: personImageView, imageNamed: "person.fill")
        setupImageView(imageView: emailImageView, imageNamed: "envelope.fill")
        setupImageView(imageView: lockImageView0, imageNamed: "lock.fill")
        setupImageView(imageView: lockImageView1, imageNamed: "lock.fill")
        
        setupTextField(textField: nameTextField, placeholder: "Имя")
        setupTextField(textField: emailTextField, placeholder: "Email")
        setupTextField(textField: passwordTextField, placeholder: "Пароль")
        setupTextField(textField: confirmPasswordTextField, placeholder: "Повторите пароль")
        
        setupButton(button: signUpButton, title: "Зарегистрироваться", color: ColorPalette.yellow, textColor: ColorPalette.black)
        setupLittleButton(button: goBackButton, image: UIImage(systemName: "arrow.left")!, tintColor: ColorPalette.black)
        setupLittleButton(button: signUpWithFacebookButton, image: UIImage(named: "facebooklogo")!, tintColor: .white)
        setupLittleButton(button: signUpWithAppleButton, image: UIImage(named: "applelogo")!, tintColor: .white)
        goBackButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didClickedSignUpButton), for: .touchUpInside)
        [customLine0, customLine1, customLine2, customLine3].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        setupTextView(textView: signInTextView, text: "Есть аккаунт? Войти.", value: "signIn", location: 14, length: "Есть аккаунт? Войти.".count-14)
        
        view.addSubview(scrollView)
        [goBackButton, signinLabel,nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, personImageView, emailImageView, lockImageView0, lockImageView1, signUpButton, signInTextView, signUpWithLabel, signUpWithFacebookButton, customLine0, customLine1, customLine2, customLine3, signUpWithAppleButton].forEach {
            scrollView.addSubview($0)
        }
        
        addConstraint()
    }
    
    @objc func didClickedGoBackButton() {
        self.navigationController?.popViewController(animated: true)
        present(WelcomeViewController(), animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didClickedSignUpButton() {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        
        guard let name = nameTextField.text, name != "" else{
            print ("nameTextField is empty")
            showAlert()
            return
        }
        
        guard let email = emailTextField.text, email != "" else{
            print ("emailTextField is empty")
            showAlert()
            return
        }
        guard let password0 = passwordTextField.text, password0 != "" else{
            print ("passwordTextField is empty")
            showAlert()
            return
        }
        
        guard let password1 = confirmPasswordTextField.text, password1 != "" else{
            print ("passwordTextField is empty")
            showAlert()
            return
        }
        // MARK: Парольдолжен состоять минимум из 6 элементов
        if (!name.isEmpty && !email.isEmpty && !password0.isEmpty && !password1.isEmpty){
            Auth.auth().createUser(withEmail: email, password: password0)  { (result, error) in
                if error == nil{
                    if let result = result{
                        print(result.user.uid)
                        let referenceUsers = Database.database().reference().child("users")
                        referenceUsers.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            showAlert()
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
        imageView.tintColor = ColorPalette.black
    }
    
    func setupTextView(textView: UITextView, text: String, value: String, location: Int, length: Int) {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "POEVeticaVanta", size: 16)]
        textView.delegate = self
        let text = NSMutableAttributedString(string: text, attributes: attribute as [NSAttributedString.Key : Any])
        text.addAttribute(.link, value: value, range: NSRange(location: location, length: length))
        UITextView.appearance().linkTextAttributes = [ .foregroundColor: ColorPalette.yellow]
        textView.attributedText = text
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 17)
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
        [goBackButton, signinLabel,nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, personImageView, emailImageView, lockImageView0, lockImageView1, signUpButton, signInTextView, signUpWithLabel, signUpWithFacebookButton, customLine0, customLine1, customLine2, customLine3, signUpWithAppleButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            goBackButton.widthAnchor.constraint(equalToConstant: 30),
            goBackButton.heightAnchor.constraint(equalToConstant: 30),
            goBackButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            goBackButton.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            signinLabel.widthAnchor.constraint(equalToConstant: 250),
            signinLabel.heightAnchor.constraint(equalToConstant: 50),
            signinLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signinLabel.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -300)
        ])
        
        NSLayoutConstraint.activate([
            personImageView.widthAnchor.constraint(equalToConstant: 30),
            personImageView.heightAnchor.constraint(equalToConstant: 30),
            personImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -125),
            personImageView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -192)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -190)
        ])
        
        NSLayoutConstraint.activate([
            customLine2.widthAnchor.constraint(equalToConstant: 300),
            customLine2.heightAnchor.constraint(equalToConstant: 0.5),
            customLine2.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            customLine2.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -174)
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
            lockImageView0.widthAnchor.constraint(equalToConstant: 30),
            lockImageView0.heightAnchor.constraint(equalToConstant: 30),
            lockImageView0.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -125),
            lockImageView0.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -71)
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
            lockImageView1.widthAnchor.constraint(equalToConstant: 30),
            lockImageView1.heightAnchor.constraint(equalToConstant: 30),
            lockImageView1.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -125),
            lockImageView1.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -11)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 200),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            confirmPasswordTextField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            customLine3.widthAnchor.constraint(equalToConstant: 300),
            customLine3.heightAnchor.constraint(equalToConstant: 0.5),
            customLine3.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            customLine3.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 70)
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
            signInTextView.widthAnchor.constraint(equalToConstant: 180),
            signInTextView.heightAnchor.constraint(equalToConstant: 50),
            signInTextView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            signInTextView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 8*view.bounds.midY/10)
        ])
    }
    
    
    
}


extension SignUpViewController: UITextFieldDelegate, UITextViewDelegate, UIAdaptivePresentationControllerDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "signIn"{
            self.dismiss(animated: true, completion: nil)
            present(SignInViewController(), animated: true)
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didClickedSignUpButton()
        return true
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didClickedGoBackButton()
    }
    
}
