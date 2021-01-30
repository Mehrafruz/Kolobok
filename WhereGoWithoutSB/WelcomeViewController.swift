//
//  WelcomeViewController.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 02.12.2020.
//  Copyright © 2020 Мехрафруз. All rights reserved.
//

import UIKit
import SpriteKit



class WelcomeViewController: UIViewController{
    
    
    private let exitButton = UIButton()
    private let animationView = SKView()
    private var signUpButton = UIButton()
    private var signInButton = UIButton()
    private var welcomeLabel = UILabel()
    private var withoutSingUpTextView = UITextView()
    private let cornerRadius: CGFloat = 20

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup(){
        let exitButtonImage = UIImage(systemName: "xmark")
        exitButton.setBackgroundImage( exitButtonImage, for: UIControl.State.normal)
        exitButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        exitButton.tintColor = ColorPalette.black
        exitButton.addTarget(self, action: #selector(didClickedExitButton), for: .touchUpInside)
        
        view.addSubview(animationView)
        let scene = makeScene()
        animationView.frame.size = scene.size
        animationView.presentScene(scene)
        animationView.allowsTransparency = true
        
        welcomeLabel.font = UIFont(name: "POEVeticaVanta", size: 40)
        welcomeLabel.layer.zPosition = 1.5
        welcomeLabel.textColor = ColorPalette.black
        welcomeLabel.text = "Привет!"
        welcomeLabel.textAlignment = .center
        
        let attribute = [NSAttributedString.Key.font: UIFont(name: "POEVeticaVanta", size: 16)]
        withoutSingUpTextView.delegate = self
        withoutSingUpTextView.backgroundColor = .white
        withoutSingUpTextView.isEditable = false
        let withoutSingUpText = NSMutableAttributedString(string: "Хочешь продолжить без регистрации?", attributes: attribute as [NSAttributedString.Key : Any])
        withoutSingUpText.addAttribute(.link, value: "withoutSignUp", range: NSRange(location: 6, length: withoutSingUpText.string.count-7))
        UITextView.appearance().linkTextAttributes = [ .foregroundColor: ColorPalette.gray]
        withoutSingUpTextView.attributedText = withoutSingUpText
        
        
        setupButton(button: signInButton, title: "Войти",
                    color: ColorPalette.gray, textColor: UIColor.white)
        signInButton.addTarget(self, action: #selector(didClickedSignInButton), for: .touchUpInside)
        
        setupButton(button: signUpButton, title: "Зарегистрироваться",
                    color: ColorPalette.yellow,  textColor: ColorPalette.black)
        signUpButton.addTarget(self, action: #selector(didClickedSignUpButton), for: .touchUpInside)
        
        [exitButton, welcomeLabel, signInButton, signUpButton, withoutSingUpTextView].forEach {
            view.addSubview($0)
        }
        addConstraints()
    }
    
    func setupButton(button: UIButton, title: String, color: UIColor, textColor: UIColor){
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "POEVeticaVanta", size: 17)
        
        button.backgroundColor = color
        button.layer.zPosition = 1.5
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.6
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func makeScene() -> SKScene {
        let size = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        let scene = SKScene(size: size)
        scene.zPosition = 1.1
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .white
        createSceneContents(to: scene)
        return scene
    }
    
    func createSceneContents(to scene: SKScene) {
        //create baground
        let backroundImage = SKSpriteNode(imageNamed: "bgWelcomeScene")
        backroundImage.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        backroundImage.size = CGSize(width: scene.size.width, height: scene.size.height)
        backroundImage.setScale(1)
        backroundImage.zPosition = -1
        scene.addChild(backroundImage)
        //create kolobok
        let kolobok = SKSpriteNode(imageNamed: "kolobokAnimation")
        kolobok.size = CGSize(width: 100, height: 100)
        kolobok.zPosition = 1.3
        kolobok.position.y = UIScreen.main.bounds.maxY-(scene.size.height)/6
        kolobok.position.x = UIScreen.main.bounds.minX-100
        scene.addChild(kolobok)
        //run movements
        let rightRotate: SKAction = .rotate(byAngle: -4 * .pi, duration: 3)
        let leftRotate: SKAction = .rotate(byAngle: 4 * .pi, duration: 3)
        let pause: SKAction = .pause()
        kolobok.run(.repeat(
            .sequence(
                [.group([
                    rightRotate,
                    .moveBy(x: UIScreen.main.bounds.maxX+100, y: -UIScreen.main.bounds.midY+scene.size.height/3, duration: 3)]),
                 .group([pause,
                         .pause()]),
                 .group([
                    leftRotate,
                    .moveBy(x:UIScreen.main.bounds.minX-400, y: -UIScreen.main.bounds.midY+scene.size.height/4, duration: 3)]),
                 .group([pause,
                         .pause()]),
                 .group([
                    rightRotate,
                    .moveBy(x: UIScreen.main.bounds.maxX+100, y: -UIScreen.main.bounds.midY+(23*scene.size.height)/100, duration: 3),
                 ]),
                ]
            ), count: 1))
    }
    
    //MARK: не применяю данную функцию но пусть побудет тут
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = ColorPalette.black.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.zPosition = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    func addConstraints() {
        [exitButton, welcomeLabel, signInButton, signUpButton, withoutSingUpTextView].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 30),
            exitButton.heightAnchor.constraint(equalToConstant: 30),
            exitButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            exitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            welcomeLabel.widthAnchor.constraint(equalToConstant: 250),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -120)
        ])
        
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: 200),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            withoutSingUpTextView.widthAnchor.constraint(equalToConstant: 300),
            withoutSingUpTextView.heightAnchor.constraint(equalToConstant: 30),
            withoutSingUpTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            withoutSingUpTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        
        
    }
    
    @objc func didClickedExitButton(){
        self.dismiss(animated: true, completion: nil)
    }
   
    let signUpViewController = SignUpViewController()
    @objc
    func didClickedSignUpButton(){
        signUpButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        signUpViewController.delegate = self
        let signUpNavigationViewController = UINavigationController(rootViewController: signUpViewController)
        present(signUpNavigationViewController, animated: true)
        WelcomeViewController().dismiss(animated: true, completion: nil)
    }
    
    let signInViewController = SignInViewController()
    @objc
    func didClickedSignInButton(){
        signInButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        signInViewController.delegate = self
        let signInNavigationViewController = UINavigationController(rootViewController: signInViewController)
        present(signInNavigationViewController, animated: true)
        WelcomeViewController().dismiss(animated: true, completion: nil)
        
    }
    
    
    
}

extension WelcomeViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "withoutSignUp"{
            didClickedExitButton()
        }
        return false
    }
}

extension WelcomeViewController: SignInDelegate{
    func openSignUp() {
        present(SignUpViewController(), animated: true)
    }
    
    func dismissWelcomeView() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension WelcomeViewController: SignUpDelegate{
    func openSignIn() {
        present(SignInViewController(), animated: true)
    }
    
    func dismissWelcomeView1() {
        self.dismiss(animated: false, completion: nil)
    }
    
}
