//
//  RenameUserViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 29.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

class RenameUserViewController: UIViewController {
    
    private var scrollView = UIScrollView()
    private var exitButton = UIButton()
    private let contentView = UIView()
    private let changeNameLabel = UILabel()
    private let changeNameTextField = UITextField()
    private let safeButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        
      //  scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifikation()
        contentView.backgroundColor = .white
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
        changeSafeButtonConstraint(topAtcnor: -kbFrameSize.size.height)
        
        UIView.animate(withDuration: 0.5){
            
            self.view.layoutIfNeeded()
            
        }
        // changeSafeButtonConstraint(topAtcnor: -kbFrameSize.size.height)
    }
    
    @objc func kbWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 0.5){
            self.changeSafeButtonConstraint(topAtcnor: 400)
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setup(){
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        
        setupButton(button: safeButton, title: "Сохранить", color: ColorPalette.yellow, textColor: ColorPalette.black)
        safeButton.addTarget(self, action: #selector(didClickedSafeButton), for: .touchUpInside)

        setupLabel(label: changeNameLabel, text: "Сменить имя пользователя", fontSize: 16)
        setupTextField(textField: changeNameTextField, placeholder: " Имя")
        
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        
        [exitButton, changeNameLabel, safeButton, changeNameTextField].forEach{
            contentView.addSubview($0)
        }
        addConstraints()
        
    }
    
    func addConstraints() {
        [scrollView, contentView, exitButton, safeButton, changeNameLabel,changeNameTextField].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
                contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
//            NSLayoutConstraint.activate([
//                scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (UIScreen.main.bounds.height*0.8)/2),
//                scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//                scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//                scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
//            ])
            
            NSLayoutConstraint.activate([
                exitButton.widthAnchor.constraint(equalToConstant: 30),
                exitButton.heightAnchor.constraint(equalToConstant: 30),
                exitButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                exitButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
            ])
            
            
            NSLayoutConstraint.activate([
                changeNameLabel.widthAnchor.constraint(equalToConstant: 270),
                changeNameLabel.heightAnchor.constraint(equalToConstant: 30),
                changeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 65),
                changeNameLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 20)
            ])
            
            NSLayoutConstraint.activate([
                changeNameTextField.widthAnchor.constraint(equalToConstant: 290),
                changeNameTextField.heightAnchor.constraint(equalToConstant: 35),
                changeNameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 60),
                changeNameTextField.topAnchor.constraint(equalTo: changeNameLabel.bottomAnchor, constant: -3)
            ])
            
            NSLayoutConstraint.activate([
                safeButton.widthAnchor.constraint(equalToConstant: 289),
                safeButton.heightAnchor.constraint(equalToConstant: 35),
                safeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                safeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
            
        }
    }
    
    func changeSafeButtonConstraint(topAtcnor: CGFloat){
        safeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: topAtcnor).isActive = true
    }

    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 18)
        button.backgroundColor = color
        button.layer.zPosition = 0.1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.shadowRadius = 0.1
        button.layer.shadowOpacity = 0.1
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    func setupLittleButton(button: UIButton, image: UIImage, tintColor: UIColor) {
        let image = image
        button.setBackgroundImage( image, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = tintColor
    }
    
    func setupLabel(label: UILabel, text: String, fontSize: CGFloat){
        label.font = UIFont(name: "POEVeticaVanta", size: fontSize)
        label.textColor = ColorPalette.black
        label.text = text
        label.textAlignment = .left
    }
    
    func setupTextField(textField: UITextField, placeholder: String) {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = UIFont(name: "POEVeticaVanta", size: 16)
        textField.layer.borderColor = ColorPalette.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.textColor = UIColor.white
        textField.backgroundColor = ColorPalette.black
    }
    
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc
    func didClickedSafeButton(){
       // kbWillHide()
    }
    
}

extension RenameUserViewController: UITextFieldDelegate{
    
}
