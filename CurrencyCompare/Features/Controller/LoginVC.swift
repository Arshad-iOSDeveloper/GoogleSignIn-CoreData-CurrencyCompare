//
//  LoginVC.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Action methods
    @IBAction func btnLoginClick(_ sender: UIButton) {
        googleSetup()
    }
    
    //MARK:- Goolge signin methods
    func googleSetup(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        /*let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        print("\(userId!)\n\(idToken!)\n\(fullName!)\n\(givenName!)\n\(familyName!)\n\(email!)") */
        
        USERDEFAULTS.set(true, forKey: UserDefaultsEnums.isloggedin.rawValue)
        USERDEFAULTS.synchronize()
        self.gotoSelectBaseCurrency()
    }
    
    //MARK:- Redirection methods
    func gotoSelectBaseCurrency(){
        let vc: SelectBaseVC = Utilities.viewController(name: "SelectBaseVC", onStoryboard: Storyboard.currency.rawValue) as! SelectBaseVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
