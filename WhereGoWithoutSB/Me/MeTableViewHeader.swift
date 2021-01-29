//
//  MeTableViewCell.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 20.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

protocol MeTableViewFirstCellDelegate: AnyObject{
    func presentImagePickerController()
}


class MeTableViewHeader: UITableViewHeaderFooterView {
    
    weak var viewControllerDelegate: MeTableViewFirstCellDelegate?
    var nameLabel = UILabel()
    var avatarImageView = UIImageView()

    
    private let emailLabel = UILabel()
    private let changeAvatarButton = UIButton()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupLibel(label: nameLabel, text: globalAppUser.name, sizeFont: 37)
        setupLibel(label: emailLabel, text: globalAppUser.email, sizeFont: 17)
        setupLittleButton(button: changeAvatarButton, imageName: "", bgImageName: "square.and.pencil", tintColor: ColorPalette.blue)
        changeAvatarButton.addTarget(self, action: #selector(didChangeAvatar), for: .touchUpInside)
        setupAvatarImage()
        changeAvatarButton.isHidden = true
        [nameLabel, emailLabel, avatarImageView, changeAvatarButton].forEach{
            contentView.addSubview($0)
        }
        addConstraints()

    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLibel(label: UILabel, text: String, sizeFont: CGFloat) {
        label.backgroundColor = .white
        label.text = text
        label.font = UIFont(name: "POEVeticaVanta", size: sizeFont)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
       func setupLittleButton(button: UIButton, imageName: String, bgImageName: String, tintColor: UIColor) {
           button.setImage( UIImage(systemName: imageName), for: UIControl.State.normal)
           button.setBackgroundImage( UIImage(systemName: bgImageName), for: UIControl.State.normal)
           button.setTitleColor(UIColor.white, for: UIControl.State.normal)
           button.tintColor = tintColor
           button.layer.cornerRadius = 25
           button.clipsToBounds = true
           button.layer.shadowRadius = 3.0
           button.layer.shadowOpacity = 0.5
           button.layer.masksToBounds = false
           button.layer.shadowOffset = CGSize(width: 0, height: 3)
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
    
    func addConstraints(){
        [nameLabel, emailLabel, avatarImageView, changeAvatarButton].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3),
            nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            //nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            emailLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            //nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 210),
            avatarImageView.heightAnchor.constraint(equalToConstant: 210),
            avatarImageView.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 3),
            avatarImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            changeAvatarButton.widthAnchor.constraint(equalToConstant: 40),
            changeAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            changeAvatarButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -35),
            changeAvatarButton.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 0)
        ])
    }
    
    @objc
    func didChangeAvatar(){
        viewControllerDelegate?.presentImagePickerController()
    }
}

extension MeTableViewHeader: FireStoreAvatarOutput{
    
    func loadAvatarURL (avatarURL: String){
        let referenceUsers = Storage.storage().reference(forURL: avatarURL)
        let mByte = Int64(2*1024*1024)
        referenceUsers.getData(maxSize: mByte) { (data, error) in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            self.avatarImageView.image = image
        }
    }
}




extension MeTableViewHeader: FireStoreAvatarInput{
    
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
