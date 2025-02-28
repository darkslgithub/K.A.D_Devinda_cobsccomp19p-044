//
//  TestprofileViewController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/16/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    
    // MARK: - Properties
      
      var safeArea: UILayoutGuide!
      
      var user: User? {
          didSet {
              titleLbl.text = "\(user!.firstname) \(user!.lastname)"
              firstNameTF.text = user!.firstname
              lastNameTF.text = user!.lastname
              indexTF.text = user!.index
              countryTF.text = user!.country
              tempLbl.text = "\(user!.temperature)°C"
          }
      }
      
      private let backButton: UIButton = {
          let button = UIButton(type: .custom)
          let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
          button.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
          button.tintColor = .black
          button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
          return button
      }()
      
      private let titleLbl: UILabel = {
          let label = UILabel()
          label.text = "Update Profile"
          label.font = UIFont(name: "Avenir-Light", size: 26)
          label.textColor = .black
          return label
      }()
      
      private let avatar: UIImageView = {
          let image = UIImageView()
          image.image = UIImage(named: "color-cam")
          image.layer.cornerRadius = 50;
          image.layer.masksToBounds = true
          image.clipsToBounds = true
          return image
      }()
      
      private let bioLbl: UILabel = {
          let label = UILabel()
          label.text = "Acme user since Aug 2020 at Matara, Sri Lanka"
          label.textColor = .black
          label.textAlignment = .center
          label.numberOfLines = 2
          label.font = UIFont.systemFont(ofSize: 14)
          return label
      }()
      
      private let tempLbl: UILabel = {
          let label = UILabel()
          label.text = "0°C"
          label.textColor = .black
          label.textAlignment = .center
          label.font = UIFont.boldSystemFont(ofSize: 24)
          return label
      }()
      
      private let firstNameTF: UITextField = {
          let tf = UITextField()
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 16)
          tf.placeholder = "First Name"
          tf.autocorrectionType = .no
          tf.autocapitalizationType = .sentences
          tf.layer.borderColor = UIColor.black.cgColor
          tf.layer.borderWidth = 0.5
          tf.layer.cornerRadius = 5.0
          tf.layer.masksToBounds = true
          return tf
      }()
      
      private let lastNameTF: UITextField = {
          let tf = UITextField()
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 16)
          tf.placeholder = "Last Name"
          tf.autocorrectionType = .no
          tf.autocapitalizationType = .sentences
          tf.layer.borderColor = UIColor.black.cgColor
          tf.layer.borderWidth = 0.5
          tf.layer.cornerRadius = 5.0
          tf.layer.masksToBounds = true
          return tf
      }()
      
      private let indexTF: UITextField = {
          let tf = UITextField()
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 16)
          tf.placeholder = "Index"
          tf.autocorrectionType = .no
          tf.autocapitalizationType = .sentences
          tf.layer.borderColor = UIColor.black.cgColor
          tf.layer.borderWidth = 0.5
          tf.layer.cornerRadius = 5.0
          tf.layer.masksToBounds = true
          return tf
      }()
      
      private let countryTF: UITextField = {
          let tf = UITextField()
          tf.borderStyle = .roundedRect
          tf.font = UIFont.systemFont(ofSize: 16)
          tf.placeholder = "Country"
          tf.autocorrectionType = .no
          tf.autocapitalizationType = .sentences
          tf.layer.borderColor = UIColor.black.cgColor
          tf.layer.borderWidth = 0.5
          tf.layer.cornerRadius = 5.0
          tf.layer.masksToBounds = true
          return tf
      }()
    

    
      private let updateButton: UIButton = {
          let button = UIButton()
         // button.backgroundColor = .white
          button.backgroundColor = .updatepagecolor
          button.setTitle("UPDATE", for: .normal)
          button.setTitleColor(.black, for: .normal)
          button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
          button.addTextSpacing(2)
          button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
          return button
      }()
      
      let scrollView: UIScrollView = {
          let sv = UIScrollView()
          let screensize: CGRect = UIScreen.main.bounds
          sv.contentSize = CGSize(width: screensize.width, height: screensize.height)
          sv.translatesAutoresizingMaskIntoConstraints = false
          return sv
      }()
      
      private lazy var mainTile: UIView = {
          let tile = UIView()
          //tile.backgroundColor = .white
          tile.backgroundColor = .updatetilecolor
          
          tile.addSubview(updateButton)
          updateButton.anchor(left: tile.leftAnchor, bottom: tile.bottomAnchor, right: tile.rightAnchor, height: 60)
          
          let separatorView = UIView()
          separatorView.backgroundColor = .lightGray
          tile.addSubview(separatorView)
          separatorView.anchor(left: tile.leftAnchor, bottom: updateButton.topAnchor, right: tile.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
          
          tile.addSubview(scrollView)
          scrollView.anchor(top: tile.topAnchor, left: tile.leftAnchor, bottom: separatorView.topAnchor, right: tile.rightAnchor)
          
          scrollView.addSubview(avatar)
          avatar.anchor(top: scrollView.topAnchor, paddingTop: 30, width: 100, height: 100)
          avatar.centerX(inView: scrollView)
          
          scrollView.addSubview(bioLbl)
          bioLbl.anchor(top: avatar.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 30, paddingLeft: 70, paddingRight: 70)
          bioLbl.centerX(inView: scrollView)
          
          scrollView.addSubview(tempLbl)
          tempLbl.anchor(top: bioLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 10, paddingLeft: 70, paddingRight: 70)
          tempLbl.centerX(inView: scrollView)
          
          let stack = UIStackView(arrangedSubviews: [firstNameTF, lastNameTF, indexTF, countryTF])
          stack.axis = .vertical
          stack.distribution = .fillProportionally
          stack.spacing = 30
          scrollView.addSubview(stack)
          stack.anchor(top: tempLbl.bottomAnchor, left: tile.leftAnchor, right: tile.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
          
          return tile
      }()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          safeArea = view.layoutMarginsGuide
          fetchUserData()
          configUI()
          self.hideKeyboardWhenTappedAround()
      }
      
      // MARK: - Selectors
      
      @objc func handleGoBack() {
          self.navigationController?.popToRootViewController(animated: true)
      }
      
      @objc func handleUpdate() {
          guard let firstName = firstNameTF.text else { return }
          guard let lastName = lastNameTF.text else { return }
          guard let index = indexTF.text else { return }
         //guard let country = countryTF.text else { return }
         guard let country = countryTF.text else { return }
          guard let currentUid = Auth.auth().currentUser?.uid else { return }
          
          if firstName.isEmpty {
              let alert = UIAlertController(title: "First Name is Required!", message: "Please enter your first name", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              self.present(alert, animated: true)
              return
          } else if lastName.isEmpty  {
              let alert = UIAlertController(title: "Last Name is Required!", message: "Please enter your last name", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              self.present(alert, animated: true)
              return
          } else if index.isEmpty  {
              let alert = UIAlertController(title: "Index is Required!", message: "Please enter your index", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              self.present(alert, animated: true)
              return
          } else if country.isEmpty  {
              let alert = UIAlertController(title: "Country is Required!", message: "Please enter your country", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              self.present(alert, animated: true)
              return
          }
          
          self.view.endEditing(true)
          let values = [
              "firstName": firstName,
              "lastName": lastName,
              "index": index,
              "country": country,
              "profileDate": [".sv": "timestamp"]
          ] as [String : Any]
          self.uploadUserProfile(uid: currentUid, values: values)
          
      }

      func configUI() {
          configNavBar()
         // view.backgroundColor = .white
          view.backgroundColor = .updatepagecolor
          view.addSubview(titleLbl)
          titleLbl.anchor(top: safeArea.topAnchor, paddingTop: 20)
          titleLbl.centerX(inView: view)
          view.addSubview(backButton)
          backButton.anchor(top: safeArea.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 16, width: 38, height: 38)
          view.addSubview(mainTile)
          mainTile.anchor(top: titleLbl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20)
      }
      
      func configNavBar() {
          navigationController?.navigationBar.isHidden = true
          navigationController?.navigationBar.barStyle = .default
      }
      
      // MARK: - API
      
      func fetchUserData() {
          guard let currentUid = Auth.auth().currentUser?.uid else { return }
          Service.shared.fetchUserData(uid: currentUid) { (user) in
              self.user = user
          }
      }
      
      func uploadUserProfile(uid: String, values: [String: Any]) {
          REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
              if error == nil {
                  let alert = UIAlertController(title: "Success!", message: "Profile updated sucessfully", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                  self.present(alert, animated: true)
              }
          }
      }

   }
