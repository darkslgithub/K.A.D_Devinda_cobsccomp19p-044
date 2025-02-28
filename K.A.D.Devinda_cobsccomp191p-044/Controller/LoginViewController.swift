//
//  LoginViewController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 8/28/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NTAXI"
        label.font = UIFont(name: "Avenir-Light", size: 36)
       // label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textColor = .updatetilecolor
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    private let emailTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    private let passwordTextFiled: UITextField = {
        return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
    }()
    
    private let loginButton: AuthUIBtn = {
        let button = AuthUIBtn(type: .system)
        button.setTitle("Log In", for: .normal)
         button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //NawBar
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Videos"
        
        configureUI()
    }
    
    // MARK: - Selectors
    
//    @objc func handleSignIn() {
//        //guard let email = emailTextFiled.text else { return }
//        //guard let password = passwordTextFiled.text else { return }
//    }
    // MARK: - Selectors
       
       @objc func handleSignIn() {
           guard let email = emailTextFiled.text else { return }
           guard let password = passwordTextFiled.text else { return }
        
        if email.isEmpty  {
            let alert = UIAlertController(title: "Please Enter Your Email", message: "Please enter your email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if password.isEmpty  {
            let alert = UIAlertController(title: "Please Enter The Password!", message: "Please enter your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        } else if password.count < 6  {
            let alert = UIAlertController(title: "Invalid Password!", message: "Password should contain least 6 charactors", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
           
           Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
               if let error = error {
                   print("DEBUG: Faild to log user with error \(error.localizedDescription)")
                   return
               }
               
               let keyWindow = UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first
               
               guard let controller = keyWindow?.rootViewController as? MainTabBarController else { return }
               controller.setupTabBar()
               
               self.dismiss(animated: true, completion: nil)
           }
       }
    
    @objc func handleShowRegister() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helper Function
    
    func configureUI() {
        
        configureNavigationBar()
        
        //view.backgroundColor = .whiteBackground
         view.backgroundColor = .updatetilecolor
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }


    

  

}
