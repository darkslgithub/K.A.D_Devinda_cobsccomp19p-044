//
//  HomeViewController.swift
//  K.A.D.Devinda_cobsccomp191p-044
//
//  Created by dasun on 8/28/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth

private let annotationIdentifier = "DriverAnnotation"

class HomeViewController: UIViewController {

    private let locationManager = LocationHandler.shared.locationManager
    private let mapView = MKMapView()
    private var route: MKRoute?
    
    private var user: User? {
          didSet {
              //locationInputView.user = user
//              if user?.accountType == .passenger {
//                  fetchDrivers()
//                  configureLocationInputActivationView()
//                  observeCurrentTrip()
//              } else {
//                  observeTrips()
//              }
              
          }
      }
       // MARK: - Lifecycale
        
        override func viewDidLoad() {
            super.viewDidLoad()
            checkIsUserLoggedIn()
            enableLocationServices()
                        
           // signOut()
            view.backgroundColor = .white
            
            
           
        }
    
//    func checkIsUserLoggedIn() {
//        if(authUser == "") {
//            DispatchQueue.main.async {
//                let nav = UINavigationController(rootViewController: WelcomeViewController())
//                //let nav = UINavigationController(rootViewController: RegisterViewController())
//                nav.modalPresentationStyle = .fullScreen
//                self.present(nav, animated: true, completion: nil)
//            }
//        } else {
//            //configure()
//        }
//    }
    
    func checkIsUserLoggedIn() {
          if(Auth.auth().currentUser?.uid == nil) {
              DispatchQueue.main.async {
                  let nav = UINavigationController(rootViewController: WelcomeViewController())
                 nav.modalPresentationStyle = .fullScreen
                  self.present(nav, animated: true, completion: nil)
              }
          } else {
              configure()
          }
      }
    
    func configure() {
        configureUI()
        fetchUserData()
    }
    
    func configureUI() {
          confugireMapView()
//          configureRideActionView()
//
//          view.addSubview(actionButton)
//          actionButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
//                              paddingTop: 16, paddingLeft: 20, width: 30, height: 30)
//
//
//          configureTableView()
      }
    func confugireMapView() {
           view.addSubview(mapView)
           mapView.frame = view.frame
           
           mapView.showsUserLocation = true
           mapView.userTrackingMode = .follow
           mapView.delegate = self
       }
    func fetchUserData() {
          guard let currentUid = Auth.auth().currentUser?.uid else { return }
          
          Service.shared.fetchUserData(uid: currentUid) { (user) in
              self.user = user
          }
      }
    
    func signOut() {
          do {
              try Auth.auth().signOut()
              DispatchQueue.main.async {
                  let nav = UINavigationController(rootViewController: LoginViewController())
                  nav.modalPresentationStyle = .fullScreen
                  self.present(nav, animated: true, completion: nil)
              }
          } catch {
              print("DEBUG: sign out error")
          }
      }
}

// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UserAnnotation {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view.image = #imageLiteral(resourceName: "chevron-sign-to-right")
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let route = self.route {
            let polyline = route.polyline
            let lineRenderer = MKPolylineRenderer(overlay: polyline)
            lineRenderer.strokeColor = .mainBlueTint
            lineRenderer.lineWidth = 4
            return lineRenderer
        }
        return MKOverlayRenderer()
    }
}

// MARK: - LocationServices

extension HomeViewController {
    
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
