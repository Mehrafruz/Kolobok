import UIKit
import Firebase
import FirebaseStorage

protocol EditFavoritesViewController: AnyObject {
    func reloadHeader()
    func reloadTableView()
}


class MeViewController: UIViewController {
    weak var favoritesDelegate: EditFavoritesViewController?
    private var scrollView = UIScrollView()
    private let contentView = UIView()
    private var exitButton = UIButton()
    private let avatarImageView = UIImageView()
    private let changeAvatarButton = UIButton()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private var customLine0 = UITableViewCell()
    private var customLine1 = UITableViewCell()
    private let liveAccountButton = UIButton()
    private let text = "for task 1"
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 600)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = .white
        navigationItem.title = "Аккаунт"
        setup()
    }
    
    
    func setup() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        setupLittleButton(button: exitButton, image: UIImage(systemName: "xmark")!, tintColor: ColorPalette.black)
        exitButton.addTarget(self, action: #selector(didClickedGoBackButton), for: .touchUpInside)
        
        setupAvatarImage()
        setupLibel(label: nameLabel, text: globalAppUser.name, sizeFont: 37)
        setupLibel(label: emailLabel, text: globalAppUser.email, sizeFont: 17)
        
        setupButton(button: changeAvatarButton, title: "Изменить фото", color: ColorPalette.yellow, textColor: ColorPalette.black, borderColor: ColorPalette.yellow)
        changeAvatarButton.addTarget(self, action: #selector(didChangeAvatar), for: .touchUpInside)

        setupButton(button: liveAccountButton, title: "Выйти из аккаунта", color: ColorPalette.black, textColor: ColorPalette.gray, borderColor: ColorPalette.black)
        liveAccountButton.addTarget(self, action: #selector(didTapLiveAccountButton), for: .touchUpInside)
        
        [customLine0, customLine1].forEach {
            ($0).backgroundColor =  ColorPalette.gray
        }
        
        view.addSubview(contentView)
        
        contentView.addSubview(scrollView)
        
        [exitButton, avatarImageView, emailLabel, nameLabel, changeAvatarButton, customLine0, customLine1, liveAccountButton].forEach{
            scrollView.addSubview(($0))
        }
        addConstraints()
    }

    
    @objc
    func didClickedGoBackButton() {
        self.favoritesDelegate?.reloadTableView()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func didChangeAvatar(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc
    func didTapLiveAccountButton(){
        showAlert(reason: "")
    }
    
    func addConstraints() {
        [scrollView, contentView, exitButton, emailLabel, nameLabel, avatarImageView, changeAvatarButton, customLine0, customLine1, liveAccountButton].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            exitButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: self.exitButton.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            customLine0.widthAnchor.constraint(equalToConstant: 300),
            customLine0.heightAnchor.constraint(equalToConstant: 0.5),
            customLine0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            customLine0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            emailLabel.topAnchor.constraint(equalTo: customLine0.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 210),
            avatarImageView.heightAnchor.constraint(equalToConstant: 210),
            avatarImageView.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 1),
            avatarImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
       
        NSLayoutConstraint.activate([
            changeAvatarButton.widthAnchor.constraint(equalToConstant: 150),
            changeAvatarButton.heightAnchor.constraint(equalToConstant: 35),
            changeAvatarButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 10),
            changeAvatarButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            customLine1.widthAnchor.constraint(equalToConstant: 300),
            customLine1.heightAnchor.constraint(equalToConstant: 0.5),
            customLine1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            customLine1.topAnchor.constraint(equalTo: changeAvatarButton.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            liveAccountButton.widthAnchor.constraint(equalToConstant: 290),
            liveAccountButton.heightAnchor.constraint(equalToConstant: 35),
            liveAccountButton.topAnchor.constraint(equalTo: self.customLine1.bottomAnchor, constant: 15),
            liveAccountButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
        
    }
    
    func setupLittleButton(button: UIButton, image: UIImage, tintColor: UIColor) {
           let image = image
           button.setBackgroundImage( image, for: UIControl.State.normal)
           button.setTitleColor(UIColor.white, for: UIControl.State.normal)
           button.tintColor = tintColor
       }
       
    
    func setupLibel(label: UILabel, text: String, sizeFont: CGFloat) {
        label.backgroundColor = .white
        label.text = text
        label.font = UIFont(name: "POEVeticaVanta", size: sizeFont)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAvatarImage() {
        print (globalAppUser.avatarURL)
        if globalAppUser.avatarURL.isEmpty || globalAppUser.avatarURL == "" || Int(globalAppUser.avatarURL) == 0{
            //if UserSettings.imageData.isEmpty{
                avatarImageView.image = UIImage(named: "appIcon")
                avatarImageView.tintColor = ColorPalette.blue
          //  } else {
               // loadAvatarURL(avatarURL: UserSettings.imageData)
           // }            
        } else {
            loadAvatarURL(avatarURL: globalAppUser.avatarURL)
        }
        
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 210 / 2
        avatarImageView.layer.masksToBounds = true
        
        avatarImageView.layer.borderColor = ColorPalette.yellow.cgColor
        avatarImageView.layer.borderWidth = 1
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor, borderColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 18)
        button.backgroundColor = color
        button.layer.zPosition = 0.1
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.shadowRadius = 0.1
        button.layer.shadowOpacity = 0.1
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
    }
    
    
    
}




extension MeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        avatarImageView.image = image
        uploadAvatarImage(currentUserId: globalAppUser.id, photo: image) {(result) in
            switch result {
            case.success(let url):
                UserSettings.imageData = url.absoluteString
                globalAppUser.avatarURL = url.absoluteString
                self.uploadAvatarURL(currentUserId: globalAppUser.id)
                self.favoritesDelegate?.reloadHeader()
            case.failure(let error):
                print (error)
            }
        }
    }
}

extension MeViewController: FireStoreAvatarInput{
    
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

extension MeViewController: FireStoreAvatarOutput{
    
    func loadAvatarURL (avatarURL: String){
        let referenceUsers = Storage.storage().reference(forURL: avatarURL)
        let mByte = Int64(3*1024*1024)
        referenceUsers.getData(maxSize: mByte) { (data, error) in
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            self.avatarImageView.image = image
        }
    }
    
}

extension MeViewController: FireStoreFavoritePlacesInput{
    func uploadViewedPlaces(currentUserId: String) {
        let referenceUsers = Database.database().reference()
        referenceUsers.child("users/\(currentUserId)/viewedPlaces").setValue(globalAppUser.viewedPlaces)
    }
    
    func uploadFavoritePlaces(currentUserId: String) {
        let referenceUsers = Database.database().reference()
        referenceUsers.child("users/\(currentUserId)/favoritePlaces").setValue(globalAppUser.favoritePlaces)
    }
    
    
}

extension MeViewController: AlertDisplayer{
    func showAlert(reason: String){
        let title = "Вы дейсвительно хотите выйти?"
        let exit = UIAlertAction(title: "Выйти", style: .default, handler: { action in
            do{
                try Auth.auth().signOut()
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                globalAppUser.removeUser()
                delegate?.dismissMeView()
                self.dismiss(animated: true, completion: nil)
                //delegate?.openSignIn()
            } catch {
                print ("Не удалось выйти из аккаунта")
            }
        })
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        displayAlert(with: title , message: reason, actions: [exit,cancel])
    }
    
}

extension MeViewController: MeTableViewFirstCellDelegate{
    
    func presentImagePickerController() {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
}

extension MeViewController: SettingsViewControllerDelegate{
    func dissmisSettingsViewController() {
        self.reloadInputViews()
    }
    
    
}

