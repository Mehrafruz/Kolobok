import UIKit
import Firebase
import FirebaseStorage


class MeViewController: UIViewController {
    
    let tempButton = UIButton()
    let titleLabel = UILabel()
    let avatarImageView = UIImageView()
    let avatarImagPickerController = UIImagePickerController()
    let changeAvatarButton = UIButton()
    let visitedView = UILabel()
    let favoriteView = UILabel()
    let settings: [String] = ["Настройки", "Помощь"]
    
    private let visitedCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 70, height: 70)
        viewLayout.minimumInteritemSpacing = 10
        collectionView.backgroundColor = ColorPalette.gray
        
        return collectionView
    }()
    
    private let favoriteCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 70, height: 70)
        viewLayout.minimumInteritemSpacing = 10
        collectionView.backgroundColor = ColorPalette.gray
        
        return collectionView
    }()
    
    private var settingsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if globalAppUser.name.isEmpty{
            present(SignInViewController(), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Аккаунт"
        view.backgroundColor = .systemBackground
        setup()
    }
    
    func setup(){
        setupTitleView()
        
        
        setupAvatarImage()
        setupView("Просмотреное:", visitedView)
        constraintsForVisited(to: avatarImageView, by: 20, visitedView)
        setupView("Избранное:", favoriteView)
        constraintsForVisited(to: avatarImageView, by: 160, favoriteView)
        
        setupCollectionView(visitedCollectionView)
        setupLayouts(visitedCollectionView, visitedView)
        setupCollectionView(favoriteCollectionView)
        setupLayouts(favoriteCollectionView, favoriteView)
        setupTableView()
        setupLittleButton(button: changeAvatarButton, imageName: "", bgImageName: "square.and.pencil", tintColor: ColorPalette.blue)
        changeAvatarButton.addTarget(self, action: #selector(didChangeAvatar), for: .touchUpInside)
        
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
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func setupCollectionViewItemSize (){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        customLayout.numberOfColumns = 5
        customLayout.cellPadding = 1
        visitedCollectionView.collectionViewLayout = customLayout
        if let layout = visitedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            print("f")
        }
        
    }
    
    private func setupLayouts(_ collectionView: UICollectionView, _ upperView: UILabel) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    func setupView(_ titleName: String, _ viewLabel: UILabel) {
        view.addSubview(viewLabel)
        viewLabel.backgroundColor = .white
        viewLabel.text = titleName
        viewLabel.font = UIFont(name: "POEVeticaVanta", size: 20)
        viewLabel.adjustsFontSizeToFitWidth = true
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        print(viewLabel)
        
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
    
    func setupButton() {
        tempButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        tempButton.addTarget(self, action: #selector(tempButtonTapped), for: .touchUpInside)
        view.addSubview(tempButton)
        
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        tempButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true// left side
        tempButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true //right side
        tempButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tempButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupTitleView() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.text = globalAppUser.name
        titleLabel.font = UIFont(name: "POEVeticaVanta", size: 30)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        constraintsForTitle()
        
    }
    
    @objc func tempButtonTapped () {
        let secondViewController = PlaceViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    func constraintsForTitle() {
        let horizontalConstraint = NSLayoutConstraint(item: titleLabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: view.safeAreaLayoutGuide,
                                                      attribute: .top,
                                                      multiplier: 1,
                                                      constant: 20)
        let verticalCenter = NSLayoutConstraint(item: titleLabel,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerX,
                                                multiplier: 1,
                                                constant: 0)
        let height = NSLayoutConstraint(item: titleLabel,
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
        avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
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
                                                    constant: 20)
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
        return categoriesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let item = categoriesItems[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    
}

extension MeViewController: UICollectionViewDelegate {
    
}

extension MeViewController: CustomLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return UIImage(named: categoriesItems[indexPath.item].imageName)?.size ?? CGSize(width: 0, height: 0)
    }
}

extension MeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = settings[indexPath.row]
        cell.textLabel?.font = UIFont(name: "POEVeticaVanta", size: 16)
        cell.accessoryType = .disclosureIndicator
        return cell
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

extension MeViewController: FireStoreInput{

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
