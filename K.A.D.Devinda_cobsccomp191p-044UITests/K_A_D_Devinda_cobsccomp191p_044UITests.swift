//
//  K_A_D_Devinda_cobsccomp191p_044UITests.swift
//  K.A.D.Devinda_cobsccomp191p-044UITests
//
//  Created by dasun on 9/14/20.
//  Copyright © 2020 NIBM. All rights reserved.
//

import XCTest

class K_A_D_Devinda_cobsccomp191p_044UITests: XCTestCase {
    
    func testSignIn() throws {

        let validEmail = "dasundevinda25@gmail.com"
       // let validPassword = "1234567"

                    let app = XCUIApplication()
                    app.launch()


                    app.buttons["Already have an account?"].tap()

                   let emailTextFiled = app.textFields["Email"]
                    XCTAssertTrue(emailTextFiled.exists)

                    emailTextFiled.tap()
                    emailTextFiled.typeText(validEmail)


                    let passwordSecureTextField = app.secureTextFields["Password"]
                    XCTAssertTrue(passwordSecureTextField.exists)

                    passwordSecureTextField.tap()
                   // passwordSecureTextField.typeText(validPassword)

                    app.buttons["Log In"].tap()

    }
    
//    func testLoginIn() throws {
//
//
//        let app = XCUIApplication()
//        app.buttons["Already have an account?"].tap()
//        app.textFields["Email"].tap()
//
//        let passwordSecureTextField = app.secureTextFields["Password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.tap()
//        app.buttons["Log In"].tap()
//        app.alerts["Biometry unavailable"].scrollViews.otherElements.buttons["OK"].tap()
//
//
//    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
