import UIKit
import Firebase
import FirebaseStorage


class MeViewController: UIViewController{
    
    private let output: MeViewOutput
    
    private var scrollView = UIScrollView()
    let nameLabel = UILabel()
    let avatarImageView = UIImageView()
    let avatarImagPickerController = UIImagePickerController()
    let changeAvatarButton = UIButton()
    let visitedLabel = UILabel()
    let favoriteLabel = UILabel()
    let settings: [String] = ["Настройки", "Выйти"]
    
    private let visitedCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 180, height: 130)
        viewLayout.minimumInteritemSpacing = 3
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private let favoriteCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 180, height: 130)
        viewLayout.minimumInteritemSpacing = 3
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var settingsTableView : UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(output: MeViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if globalAppUser.name.isEmpty{
            present(SignInViewController(), animated: true)
        }
        favoriteCollectionView.reloadData()
        visitedCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           //MARK: чтобы прокрутка скрола нормально заработала сонтентсайз вызывай тут
           scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
          
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Аккаунт"
        view.backgroundColor = .systemBackground
        setup()
    }
    
    func setup(){
        scrollView.contentOffset = CGPoint.zero
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        
        setupTitleView()
        setupAvatarImage()
        setupView("Просмотреное", visitedLabel)
        constraintsForVisited(to: avatarImageView, by: 10, visitedLabel)
        setupView("Избранное", favoriteLabel)
        constraintsForVisited(to: avatarImageView, by: 200, favoriteLabel)
        
        setupCollectionView(visitedCollectionView)
        setupLayouts(visitedCollectionView, visitedLabel)
        setupCollectionView(favoriteCollectionView)
        setupLayouts(favoriteCollectionView, favoriteLabel)
        setupTableView()
        setupLittleButton(button: changeAvatarButton, imageName: "", bgImageName: "square.and.pencil", tintColor: ColorPalette.blue)
        changeAvatarButton.addTarget(self, action: #selector(didChangeAvatar), for: .touchUpInside)
        
        //view.addSubview(scrollView)
        
        [changeAvatarButton].forEach{
            view.addSubview(($0))
        }
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupTableView() {
        view.addSubview(settingsTableView)
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.topAnchor.constraint(equalTo: favoriteCollectionView.bottomAnchor, constant: 16).isActive = true
        settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    @objc
    func didChangeAvatar(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func addConstraints() {
        [changeAvatarButton].forEach{
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        changeAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        changeAvatarButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeAvatarButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        changeAvatarButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -35).isActive = true
        changeAvatarButton.rightAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 0).isActive = true
    }
    
    private func setupCollectionView(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MeCollectionViewCell.self, forCellWithReuseIdentifier: MeCollectionViewCell.identifier)
    }
    
    
    
    private func setupLayouts(_ collectionView: UICollectionView, _ upperView: UILabel) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    
    func setupView(_ titleName: String, _ viewLabel: UILabel) {
        view.addSubview(viewLabel)
        viewLabel.backgroundColor = .white
        viewLabel.text = titleName
        viewLabel.font = UIFont(name: "POEVeticaVanta", size: 19)
        viewLabel.adjustsFontSizeToFitWidth = true
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupAvatarImage() {
        if globalAppUser.avatarURL == "" || globalAppUser.avatarURL == "0"{
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.image = UIImage(systemName: "plus.circle")
            avatarImageView.tintColor = ColorPalette.blue
            
        } else {
            loadAvatarURL(avatarURL: globalAppUser.avatarURL)
        }
        view.addSubview(avatarImageView)
        let indent: CGFloat = 144.0
        let width = UIScreen.main.bounds.width - indent * 2
        
        avatarImageView.layer.cornerRadius = width / 2
        avatarImageView.layer.masksToBounds = true
        
        avatarImageView.layer.borderColor = ColorPalette.gray.cgColor
        avatarImageView.layer.borderWidth = 3
        
        constrainsForAva(indent, width)
    }
    
    
    func setupTitleView() {
        view.addSubview(nameLabel)
        nameLabel.backgroundColor = .white
        nameLabel.text = globalAppUser.name
        nameLabel.font = UIFont(name: "POEVeticaVanta", size: 27)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraintsForTitle()
        
    }
    
    
    
    func constraintsForTitle() {
        let horizontalConstraint = NSLayoutConstraint(item: nameLabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .top,
                                                      multiplier: 1,
                                                      constant: 40)
        let verticalCenter = NSLayoutConstraint(item: nameLabel,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)
        let height = NSLayoutConstraint(item: nameLabel,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 50)
        
        let constraints: [NSLayoutConstraint] = [horizontalConstraint, verticalCenter, height]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func constrainsForAva(_ indent: CGFloat, _ width: CGFloat) {
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.centerXAnchor, multiplier: 1).isActive = true //
        avatarImageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7).isActive = true
    }
    
    
    
    
    fileprivate func constraintsForVisited(to item: Any, by constant: CGFloat, _ sendView: UILabel) {
        let horizontalConstraint = NSLayoutConstraint(item: sendView,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: item,
                                                      attribute: .bottom,
                                                      multiplier: 1,
                                                      constant: constant)
        let verticalConstraint = NSLayoutConstraint(item: sendView,
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .leading,
                                                    multiplier: 1,
                                                    constant: 10)
        let height = NSLayoutConstraint(item: sendView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 50)
        
        
        let constraints: [NSLayoutConstraint] = [horizontalConstraint, verticalConstraint, height]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
extension MeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === favoriteCollectionView{
            return output.itemsCount(arr: globalAppUser.favoritePlaces)
        }
        else if collectionView === visitedCollectionView{
            return output.itemsCount(arr: globalAppUser.viewedPlaces)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeCollectionViewCell.identifier, for: indexPath) as! MeCollectionViewCell
        var item = FavoretiPlaceViewCellModel(imageURL: nil, title: "")
        if collectionView === favoriteCollectionView{
            item = output.item(at: indexPath.row, at: globalAppUser.favoritePlaces)
        }
        else if collectionView === visitedCollectionView{
            item = output.item(at: indexPath.row, at: globalAppUser.viewedPlaces)
        }
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === favoriteCollectionView{
            output.didSelect(at: globalAppUser.favoritePlaces[indexPath.row])
        }
        if collectionView === visitedCollectionView{
            output.didSelect(at: globalAppUser.viewedPlaces[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension MeViewController: UICollectionViewDelegate {
    
}

extension MeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = settings[indexPath.row]
        cell.textLabel?.textAlignment = .right
        if indexPath.row == 1{
            cell.textLabel?.textColor = .red
        }
        cell.textLabel?.font = UIFont(name: "POEVeticaVanta", size: 16)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            present(SettingsViewController(), animated: true)
        }
        
        if indexPath.row == 1{
            showAlert(reason: "")
        }
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
                globalAppUser.avatarURL = url.absoluteString
                self.uploadAvatarURL(currentUserId: globalAppUser.id)
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
        let mByte = Int64(2*1024*1024)
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

extension MeViewController: MeViewInput{
    func update(at index: Int) {
        favoriteCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        visitedCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
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
                
            } catch {
                print ("не удалось выйти из аккаунта")
            }
        })
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        displayAlert(with: title , message: reason, actions: [exit,cancel])
    }
    
}
