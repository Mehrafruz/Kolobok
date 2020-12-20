import UIKit

class MeViewController: UIViewController {
    
    let tempButton = UIButton()
    let titleLabel = UILabel()
    let avatarImageView = UIImageView()
    let visitedView = UILabel()
    let favoriteView = UILabel()
    let settings: [String] = ["Настройки", "Помощь"]
    
    private let visitedCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 70, height: 70)
        viewLayout.minimumInteritemSpacing = 10
        collectionView.backgroundColor = UIColor(red: 299/255, green: 299/255, blue: 299/255, alpha: 1)
        
        return collectionView
    }()
    
    private let favoriteCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        viewLayout.scrollDirection = .horizontal
        viewLayout.itemSize = CGSize.init(width: 70, height: 70)
        viewLayout.minimumInteritemSpacing = 10
        collectionView.backgroundColor = UIColor(red: 299/255, green: 299/255, blue: 299/255, alpha: 1)
        
        return collectionView
    }()
    
    private var settingsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Аккаунт"
        view.backgroundColor = .systemBackground
        
        //        setupButton()
        setupTitleView()
        setupAvatarImage()
        setupView("Просмотреное:", visitedView)
        constraintsForVisited(to: avatarImageView, by: 20, visitedView)
        setupView("Избранное:", favoriteView)
        constraintsForVisited(to: avatarImageView, by: 160, favoriteView)
        //        setupView("Wish list:", favoriteView)
        //        constraintsForVisited(to: avatarImageView, by: 120, favoriteView)
        
        setupCollectionView(visitedCollectionView)
        setupLayouts(visitedCollectionView, visitedView)
        setupCollectionView(favoriteCollectionView)
        setupLayouts(favoriteCollectionView, favoriteView)
        //        setupCollectionViewItemSize()
        setupTableView()
        //       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        //       collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.489895463, blue: 0, alpha: 1)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //для анимации
        //animationView.center.x = view.bounds.midX
        //animationView.center.y = view.bounds.minY+125
    }
    
    func setupTableView() {
        view.addSubview(settingsTableView)
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        //        settingsTableView.topAnchor.constraint(equalTo: favoriteCollectionView.bottomAnchor).isActive = true
        settingsTableView.topAnchor.constraint(equalTo: favoriteCollectionView.bottomAnchor, constant: 16).isActive = true// left side
        //        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100).isActive = true //right side
        settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        // Layout constraints for collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -10),
            //            visitedCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    func setupView(_ titleName: String, _ viewLabel: UILabel) {
        view.addSubview(viewLabel)
        viewLabel.backgroundColor = .white
        viewLabel.text = titleName
        viewLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        viewLabel.adjustsFontSizeToFitWidth = true
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        print(viewLabel)
        
    }
    
    
    func setupAvatarImage() {
        avatarImageView.image = UIImage.init(named: "appIcon")
        view.addSubview(avatarImageView)
        let indent: CGFloat = 144.0
        let width = UIScreen.main.bounds.width - indent * 2
        
        avatarImageView.layer.cornerRadius = width / 2
//        avatarImageView.contentMode = .scaleAspectF.it
        avatarImageView.layer.masksToBounds = true
        
        avatarImageView.layer.borderColor = UIColor(red: 1, green: 195/255, blue: 52/255, alpha: 1).cgColor
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
        titleLabel.text = appUser.name
        
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
                                                      attribute:
            .top,
                                                      multiplier: 1,
                                                      constant: 0)
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
        
        //        let width = NSLayoutConstraint(item: titleView,
        //                                       attribute: .width,
        //                                       relatedBy: .equal,
        //                                       toItem: nil,
        //                                       attribute: .width,
        //                                       multiplier: 1,
        //                                       constant: 100)
        
        let constraints: [NSLayoutConstraint] = [horizontalConstraint, verticalCenter, height]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func constrainsForAva(_ indent: CGFloat, _ width: CGFloat) {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.centerXAnchor, multiplier: 1).isActive = true // left side
        //        avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100).isActive = true //right side
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
        //        cell.imageView?.image = UIImage(named: "kolobokAnimation_1")
        //        let image = UIImage(named: "kolobokAnimation_1")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 10
    //    }
    
    
    
}
