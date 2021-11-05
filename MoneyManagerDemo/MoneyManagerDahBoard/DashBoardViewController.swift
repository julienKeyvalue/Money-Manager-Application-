//
//  DashBoardViewController.swift
//  MoneyManagerDemo
//
//  Created by Julien on 01/11/21.
//

import UIKit
import GoogleSignIn

class DashBoardViewController: UIViewController {
    @IBOutlet var BgView: UIView!
    var textfieldobj=TextFieldSetup()
    var window:UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldobj.gradient(view: view, BgView: BgView)
        navigationController?.setNavigationBarHidden(true, animated: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()  
        if let viewController = UIStoryboard(name: "WelcomeScreen", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreen") as? WelcomeScreenViewController {
            let navController = UINavigationController(rootViewController: viewController)
            SceneDelegate.shared.window?.rootViewController = navController
        }
        self.window?.makeKeyAndVisible()
    }
}
