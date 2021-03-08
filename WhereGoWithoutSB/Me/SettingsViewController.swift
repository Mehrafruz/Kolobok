//
//  SettingsViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 27.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

protocol SettingsViewControllerDelegate where Self: UIViewController{
    func dissmisSettingsViewController()
}

class SettingsViewController: UIViewController {
    weak var categoryView: CategoryViewInput?
    weak var delegate: SettingsViewControllerDelegate?
    
    private var scrollView = UIScrollView()
    private var exitButton = UIButton()
    private let contentView = UIView()
    private let changeNameLabel = UILabel()
    private let changeNameTextView = UITextView()
    private let changePasswordLabel = UILabel()
    private let changePasswordTextView = UITextView()
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    private let avatarImageView = UIImageView()
    private let changeAvatarButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 600)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationController?.delegate = self
        isModalInPresentation = true
        setup()
        contentView.backgroundColor = .white
        
    }
    
    func setup (){
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        setupAvatarImage()
        setupButton(button: changeAvatarButton, title: "Изменить фото", color: ColorPalette.yellow, textColor: ColorPalette.black)
        changeAvatarButton.addTarget(self, action: #selector(didChangeAvatar), for: .touchUpInside)

        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        setupLabel(label: changeNameLabel, text: "Сменить имя пользователя", fontSize: 16)
        setupLabel(label: changePasswordLabel, text: "Сменить пароль", fontSize: 16)
        setupTextView(textView: changeNameTextView, text: " Имя", value: "name", location: 0, length: " Имя".count)
        setupTextView(textView: changePasswordTextView, text: " Пароль", value: "password", location: 0, length: " Пароль".count)

        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        view.addSubview(contentView)
        delegate?.dissmisSettingsViewController()
        contentView.addSubview(scrollView)
        
        [avatarImageView, exitButton, changeAvatarButton, changeNameLabel, changeNameTextView, changePasswordLabel, changePasswordTextView, customLine0, customLine1].forEach{
            scrollView.addSubview($0)
        }
        addConstraints()
    }
    
    func addConstraints() {
        [scrollView, changeAvatarButton, avatarImageView, contentView, exitButton, changeNameLabel, changeNameTextView, changePasswordLabel, changePasswordTextView, customLine0, customLine1].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
                contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            ])
            
            NSLayoutConstraint.activate([
                exitButton.widthAnchor.constraint(equalToConstant: 30),
                exitButton.heightAnchor.constraint(equalToConstant: 30),
                exitButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
                exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
            
            
            NSLayoutConstraint.activate([
                avatarImageView.widthAnchor.constraint(equalToConstant: 210),
                avatarImageView.heightAnchor.constraint(equalToConstant: 210),
                avatarImageView.topAnchor.constraint(equalTo: self.exitButton.bottomAnchor, constant: 10),
                avatarImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
            ])
            
            NSLayoutConstraint.activate([
                changeAvatarButton.widthAnchor.constraint(equalToConstant: 150),
                changeAvatarButton.heightAnchor.constraint(equalToConstant: 35),
                changeAvatarButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 10),
                changeAvatarButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
            ])
            
            NSLayoutConstraint.activate([
                customLine0.widthAnchor.constraint(equalToConstant: 300),
                customLine0.heightAnchor.constraint(equalToConstant: 0.5),
                customLine0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine0.topAnchor.constraint(equalTo: changeAvatarButton.bottomAnchor, constant: 10)
            ])
            
            NSLayoutConstraint.activate([
                changeNameLabel.widthAnchor.constraint(equalToConstant: 270),
                changeNameLabel.heightAnchor.constraint(equalToConstant: 30),
                changeNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65),
                changeNameLabel.topAnchor.constraint(equalTo: customLine0.bottomAnchor, constant: 10)
            ])
            
            NSLayoutConstraint.activate([
                changeNameTextView.widthAnchor.constraint(equalToConstant: 290),
                changeNameTextView.heightAnchor.constraint(equalToConstant: 35),
                changeNameTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
                changeNameTextView.topAnchor.constraint(equalTo: changeNameLabel.bottomAnchor, constant: -3)
            ])
            
            NSLayoutConstraint.activate([
                changePasswordLabel.widthAnchor.constraint(equalToConstant: 270),
                changePasswordLabel.heightAnchor.constraint(equalToConstant: 30),
                changePasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65),
                changePasswordLabel.topAnchor.constraint(equalTo: changeNameTextView.bottomAnchor, constant: 10)
            ])
            
            NSLayoutConstraint.activate([
                changePasswordTextView.widthAnchor.constraint(equalToConstant: 290),
                changePasswordTextView.heightAnchor.constraint(equalToConstant: 35),
                changePasswordTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
                changePasswordTextView.topAnchor.constraint(equalTo: changePasswordLabel.bottomAnchor, constant: -3)
            ])
            
            NSLayoutConstraint.activate([
                customLine1.widthAnchor.constraint(equalToConstant: 300),
                customLine1.heightAnchor.constraint(equalToConstant: 0.5),
                customLine1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                customLine1.topAnchor.constraint(equalTo: changePasswordTextView.bottomAnchor, constant: 15)
            ])
            
        }
    }
    
    func setupAvatarImage() {
        avatarImageView.contentMode = .scaleAspectFill
        if globalAppUser.avatarURL == "" || globalAppUser.avatarURL == "0"{
            avatarImageView.image = UIImage(named: "appIcon")
            avatarImageView.tintColor = ColorPalette.yellow
        } else {
            loadAvatarURL(avatarURL: globalAppUser.avatarURL)
        }
        avatarImageView.layer.cornerRadius = 210 / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderColor = ColorPalette.yellow.cgColor
        avatarImageView.layer.borderWidth = 1
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
    
    func setupTextView(textView: UITextView, text: String, value: String, location: Int, length: Int) {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "POEVeticaVanta", size: 16)]
        textView.delegate = self
        textView.backgroundColor = .white
        let text = NSMutableAttributedString(string: text, attributes: attribute as [NSAttributedString.Key : Any])
        text.addAttribute(.link, value: value, range: NSRange(location: location, length: length))
        UITextView.appearance().linkTextAttributes = [ .foregroundColor: UIColor.white]
        textView.attributedText = text
        textView.textAlignment = .left
        textView.layer.borderWidth = 1
        textView.backgroundColor = ColorPalette.black
        textView.layer.cornerRadius = 7
        textView.clipsToBounds = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isEditable = false
    }
    
    @objc
    func didClickedGoBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didChangeAvatar(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "name"{
            present(RenameUserViewController(), animated: true)
        }
        if URL.absoluteString == "password"{
            present(RepassUserViewController(), animated: true)
        }
        return false
    }
}


extension SettingsViewController: FireStoreAvatarOutput{
    func loadAvatarURL(avatarURL: String) {
        let referenceUsers = Storage.storage().reference(forURL: avatarURL)
        let mByte = Int64(2*1024*1024)
        referenceUsers.getData(maxSize: mByte) { (data, error) in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            self.avatarImageView.image = image
        }
    }
}

extension SettingsViewController: FireStoreAvatarInput{
    
    func uploadAvatarImage(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let ref = Storage.storage().reference().child("avatars").child(currentUserId)
        guard let imageData = avatarImageView.image?.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
    
    func uploadAvatarURL (currentUserId: String){
        let referenceUsers = Database.database().reference()
        referenceUsers.child("users/\(currentUserId)/avatarURL").setValue(globalAppUser.avatarURL)
    }
    
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        avatarImageView.image = image
        let meTableViewHeader = MeTableViewHeader()
        meTableViewHeader.avatarImageView.image = image
        uploadAvatarImage(currentUserId: globalAppUser.id, photo: image) {(result) in
            switch result {
            case.success(let url):
                globalAppUser.avatarURL = url.absoluteString
                self.uploadAvatarURL(currentUserId: globalAppUser.id)
            case.failure(let error):
                print (error)
            }
        }
    }
}

extension SettingsViewController: UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didClickedGoBackButton()
    }
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print(#function)
    }
}
