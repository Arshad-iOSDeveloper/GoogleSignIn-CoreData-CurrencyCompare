//
//  SceneDelegate.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import UIKit

var SceneDelegateInstance : SceneDelegate!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        SceneDelegateInstance = self
        checkAlreadyLoggedIn()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    //MARK:- Check already logged in
    func checkAlreadyLoggedIn(){
        var isLoggedin = false
        if USERDEFAULTS.object(forKey: UserDefaultsEnums.isloggedin.rawValue) != nil{
            isLoggedin = USERDEFAULTS.bool(forKey: UserDefaultsEnums.isloggedin.rawValue)
            if isLoggedin{
                //already logged in
                SceneDelegateInstance.gotoSelectBaseCurrency(transition : true)
            }else{
                //not logged in
                SceneDelegateInstance.gotoLogin(transition : true)
            }
        }else{
            //not logged in
            SceneDelegateInstance.gotoLogin(transition : true)
        }
    }
    
    //MARK:- Redirection methods
    func gotoSelectBaseCurrency(transition : Bool)
    {
        let _navigation : UINavigationController!
        
        let startVC : SelectBaseVC = Utilities.viewController(name: "SelectBaseVC", onStoryboard: Storyboard.currency.rawValue) as! SelectBaseVC
        
        _navigation = UINavigationController(rootViewController: startVC)
        
        _navigation.setNavigationBarHidden(true, animated: true)
        
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewControllerWithoutAnimation(viewController: _navigation, transition: transitionOption)
    }
    
    func gotoLogin(transition : Bool)
    {
        let _navigation : UINavigationController!
        
        let startVC : LoginVC = Utilities.viewController(name: "LoginVC", onStoryboard: Storyboard.currency.rawValue) as! LoginVC
        
        _navigation = UINavigationController(rootViewController: startVC)
        
        _navigation.setNavigationBarHidden(true, animated: true)
        
        let transitionOption = transition ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromLeft
        gotoViewControllerWithoutAnimation(viewController: _navigation, transition: transitionOption)
    }
    
    func gotoViewController(viewController: UIViewController, transition: UIView.AnimationOptions)
    {
        if transition != UIView.AnimationOptions.transitionCurlUp
        {
            UIView.transition(with: self.window!, duration: 0.5, options: transition, animations: { () -> Void in
                self.window!.rootViewController = viewController
            }, completion: { (finished: Bool) -> Void in
                // do nothing
            })
        } else {
            window!.rootViewController = viewController
        }
    }
    
    func gotoViewControllerWithoutAnimation(viewController: UIViewController, transition: UIView.AnimationOptions)
    {
        if transition != UIView.AnimationOptions.transitionCurlUp
        {
            UIView.transition(with: self.window!, duration: 0.0, options: transition, animations: { () -> Void in
                self.window!.rootViewController = viewController
            }, completion: { (finished: Bool) -> Void in
                // do nothing
            })
        } else {
            window!.rootViewController = viewController
        }
    }
    
}

