//
//  SceneDelegate.swift
//  MoneyManagerDemo
//
//  Created by Julien on 28/10/21.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    let defaults = UserDefaults.standard


    static var shared: SceneDelegate!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        SceneDelegate.shared=self
        if( !UserDefaults.standard.bool(forKey: "isOnBoardingShown")){
            //if onboarding screen not shown
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "Main")
            window?.rootViewController = viewController
        }
        else{
            //if onboarding screen is shown
            let loggedIn = defaults.bool(forKey: "loggedIn")
            
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if ((error != nil || user == nil ) || loggedIn == false || !AccessToken.isCurrentAccessTokenActive ){
                    print("Signed Out")
                    let mainStoryBoard = UIStoryboard(name: "WelcomeScreen", bundle: nil)
                    let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "welcomeNav")
                    self.window?.rootViewController=viewController
                } else {
                    // Show the app's signed-in state.
                    print("Signed In")
                    let mainStoryBoard = UIStoryboard(name: "MoneyManagerDashboard", bundle: nil)
                    let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "tabbarcontroller")
                    self.window?.rootViewController=viewController
                    }
                }
        }
    }
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }

        window.rootViewController = vc

        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }


}

