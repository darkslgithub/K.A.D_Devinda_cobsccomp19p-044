//
//  RegisterViewController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 8/29/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth
import GeoFire

class RegisterViewController: UIViewController {
    
     // MARK: - Properties
    
       private var location = LocationHandler.shared.locationManager.location

       private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "COVID-19"
           label.font = UIFont(name: "Avenir-Light", size: 36)
           //label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textColor = .updatetilecolor
           
           return label
       }()
       
      
       private lazy var firstNameContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: firstNameTextFiled )
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
      private lazy var lastNameContainerView: UIView = {
              let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: lastTextFiled )
              view.heightAnchor.constraint(equalToConstant: 50).isActive = true
              return view
          }()
          
      private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: emailTextFiled )
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
      }()
    
      private lazy var roleContainerView: UIView = {
          let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: roleTextFiled)
          view.heightAnchor.constraint(equalToConstant: 50).isActive = true
          return view
      }()
       
       private lazy var passwordContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextFiled)
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           return view
       }()
    
    
       private let firstNameTextFiled: UITextField = {
          return UITextField().textField(withPlaceholder: "First Name", isSecureTextEntry: false)
       }()
      
       private let lastTextFiled: UITextField = {
           return UITextField().textField(withPlaceholder: "Last Name", isSecureTextEntry: false)
       }()
        
       private let emailTextFiled: UITextField = {
              return UITextField().textField(withPlaceholder: "Email", isSecureTextEntry: false)
          }()
    
       private let roleTextFiled: UITextField = {
            return UITextField().textField(withPlaceholder: "Role", isSecureTextEntry: false)
        }()
       
       private let passwordTextFiled: UITextField = {
           return UITextField().textField(withPlaceholder: "Password", isSecureTextEntry: true)
       }()
    
       private let signUpButton: AuthUIBtn = {
           let button = AuthUIBtn(type: .system)
           button.setTitle("Register", for: .normal)
           button.setTitleColor(.black, for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
           //button.titleLabel?.font=UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
           button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
           return button
       }()
       
       let alreadyHaveAccountButton: UIButton = {
           let button = UIButton(type: .system)
           let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
           
           attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
           
           button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
           
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
        navigationItem.title = "reg"
           
           configureUI()
           
       }
       
       // MARK: - Helper Function
       
       func uploadUserDataAndShowHomeController(uid: String, values: [String: Any]) {
           REF_USERS.child(uid).updateChildValues(values) { (error, ref) in

               //handle error

               let keyWindow = UIApplication.shared.connectedScenes
               .filter({$0.activationState == .foregroundActive})
               .map({$0 as? UIWindowScene})
               .compactMap({$0})
               .first?.windows
               .filter({$0.isKeyWindow}).first

//               guard let controller = keyWindow?.rootViewController as? HomeViewController else { return }
//                 controller.configure()
            guard let controller = keyWindow?.rootViewController as? MainTabBarController else { return }
            controller.setupTabBar()

               self.dismiss(animated: true, completion: nil)
           }
       }
       
       func configureUI() {
        //view.backgroundColor = .whiteBackground
        view.backgroundColor = .updatetilecolor
           
           view.addSubview(titleLabel)
           titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
           titleLabel.centerX(inView: view)
           
           let stack = UIStackView(arrangedSubviews: [firstNameContainerView, lastNameContainerView, emailContainerView, roleContainerView, passwordContainerView, signUpButton])
           stack.axis = .vertical
           stack.distribution = .fillProportionally
           stack.spacing = 24
           
           view.addSubview(stack)
           stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
           
           view.addSubview(alreadyHaveAccountButton)
           alreadyHaveAccountButton.centerX(inView: view)
           alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, height: 32)
           
       }
       
       // MARK: - Selectors
       
       @objc func handleSignUp() {
           guard let firstname = firstNameTextFiled.text else { return }
           guard let lastname = lastTextFiled.text else { return }
           guard let email = emailTextFiled.text else { return }
           guard let role = roleTextFiled.text else { return }
           guard let password = passwordTextFiled.text else { return }
        
        //Validations
               if firstname.isEmpty {
                let alert = UIAlertController(title: "Please Enter Your First Name!", message: "Please enter your first name", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               } else if lastname.isEmpty  {
                   let alert = UIAlertController(title: "Please Enter Your Last Name!", message: "Please enter your last name", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               } else if role.isEmpty  {
                   let alert = UIAlertController(title: "Please Enter Your Role!", message: "Please enter your role (Admin/User)", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               } else if email.isEmpty  {
                   let alert = UIAlertController(title: "Please Enter Your Email!", message: "Please enter your email address", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               } else if password.isEmpty  {
                   let alert = UIAlertController(title: "Please Enter The Password!", message: "Please enter your password", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               } else if password.count < 6  {
                   let alert = UIAlertController(title: "Password is not valid!", message: "Password should contain least 6 charactors", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                   self.present(alert, animated: true)
                   return
               }
               
         
           
           Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
               if let error = error {
                   print("Faild to register user with error \(error)")
                   return
               }

               guard let uid = result?.user.uid else { return }

               let values = [
                "firstname": firstname,
                "lastname": lastname,
               "email": email,
               "role": role
               ] as [String : Any]

               
                   let geoFire = GeoFire(firebaseRef: REF_USER_LOCATIONS)

                   guard let location = self.location else { return }

                   geoFire.setLocation(location, forKey: uid, withCompletionBlock: { (error) in
                       self.uploadUserDataAndShowHomeController(uid: uid, values: values)
                   })
              

               self.uploadUserDataAndShowHomeController(uid: uid, values: values)
           }
       }
       
       @objc func handleShowLogIn() {
           navigationController?.popViewController(animated: true)
       }
}
