//
//  FullMapViewController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 9/18/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import AVFoundation


private let reuseIdentifier = "LocationCell"
private let annotationIdentifier = "UserAnnotation"

class FullMapViewController: UIViewController {
    
    // MARK: - Properties
        
        private let mapView = MKMapView()
        private let locationManager = LocationHandler.shared.locationManager
        var safeArea: UILayoutGuide!
        
        private var user: User? {
            didSet {
                //
            }
        }
        
        private let topNav: UIView = {
            let uv = UIView()
           // uv.backgroundColor = .systemGray6
            uv.backgroundColor = .updatepagecolor
            
            let backBtn = UIButton()
            let boldConfig = UIImage.SymbolConfiguration(pointSize: .zero, weight: .bold, scale: .large)
            backBtn.setImage(UIImage(systemName: "chevron.left", withConfiguration: boldConfig), for: .normal)
            backBtn.tintColor = .black
            backBtn.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
            uv.addSubview(backBtn)
            backBtn.anchor(left: uv.leftAnchor, paddingLeft: 16, width: 38, height: 38)
            backBtn.centerY(inView: uv)
            
            let titleLbl = UILabel()
            titleLbl.text = "Danger Areas"
            titleLbl.font = UIFont(name: "Avenir-Light", size: 26)
            titleLbl.textColor = .black
            titleLbl.adjustsFontSizeToFitWidth = true
            uv.addSubview(titleLbl)
            titleLbl.centerY(inView: uv)
            titleLbl.centerX(inView: uv)
            
            return uv
        }()
        
        private let mapTile: UIView = {
            let tile = UIView()
            //tile.backgroundColor = .white
             tile.backgroundColor = .updatepagecolor
            return tile
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            safeArea = view.layoutMarginsGuide
            configUI()
            fetchOtherUsers()
        }
        
        // MARK: - Selectors
        
        @objc func handleGoBack() {
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        // MARK: - API
        
        func fetchOtherUsers() {
            guard let location = locationManager?.location else { return }
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            
            Service.shared.fetchUsersLocation(location: location) { (user) in
                guard let coordinate = user.location?.coordinate else { return }
                let annotation = UserAnnotation(uid: user.uid, coordinate: coordinate)
                
                let temp = Float(user.temperature)!
                let result = user.surveyResult
                
                var usersVisible: Bool {
                    
                    return self.mapView.annotations.contains { (annotation) -> Bool in
                        guard let userAnno = annotation as? UserAnnotation else { return false }
                        
                        if userAnno.uid == user.uid {
                            if temp >= 38.0 && result >= 3 {
                                userAnno.updateAnnotationPosition(withCoordinate: coordinate)
                                self.notifyUser()
                                return true
                            }
                        }
                        
                        return false
                    }
                }
                
                if !usersVisible {
                    // ignore own annotation
                    if user.uid != currentUid {
                        if temp >= 38.0 && result >= 75 {
                            self.mapView.addAnnotation(annotation)
                            self.notifyUser()
                        }
                    }
                }
            }
        }

        
        // MARK: - Helper Functions
        
        func configUI() {
            //view.backgroundColor = .systemGray6
            view.backgroundColor = .updatepagecolor
            
            configNavBar()
            view.addSubview(topNav)
            topNav.anchor(top: safeArea.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 70)
            view.addSubview(mapTile)
            mapTile.anchor(top: topNav.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
            configMapView()
        }
        
        func configMapView() {
            mapTile.addSubview(mapView)
            mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 70)
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            mapView.delegate = self
            mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(UserAnnotation.self))
        }
        
        func configNavBar() {
            navigationController?.navigationBar.isHidden = true
            navigationController?.navigationBar.barStyle = .default
        }
        
        func notifyUser() {
            if !UIApplication.topViewController()!.isKind(of: UIAlertController.self) {
                AudioServicesPlayAlertSound(SystemSoundID(1322))
                let alert = UIAlertController(title: "Warning!", message: "Possible COVID-19 infected person near you", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }

    }

    // MARK: - MKMapViewDelegate

    extension FullMapViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? UserAnnotation {
                let identifier = NSStringFromClass(UserAnnotation.self)
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
                if let markerAnnotationView = view as? MKMarkerAnnotationView {
                    markerAnnotationView.animatesWhenAdded = true
                    markerAnnotationView.canShowCallout = false
                    markerAnnotationView.markerTintColor = .red
                }
                return view
            }
            return nil
        }
    }

    // MARK: - LocationServices

    extension FullMapViewController {
        
        func enableLocationServices() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
            case .restricted, .denied:
                break
            case .authorizedWhenInUse:
                locationManager?.requestAlwaysAuthorization()
            case .authorizedAlways:
                locationManager?.startUpdatingLocation()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            default:
                break
            }
        }
}
