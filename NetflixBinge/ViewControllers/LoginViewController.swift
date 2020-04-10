//
//  LoginViewController.swift
//  NetflixBinge
//
//  Created by Alex Sikand on 3/31/20.
//  Copyright © 2020 CS411. All rights reserved.
//

import UIKit
import FirebaseAuth
import SkyFloatingLabelTextField
import GoogleSignIn

extension UIViewController
{
    // Sets up tapping away from the textfield to dismiss the keyboard
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()
        GIDSignIn.sharedInstance().clientID = "946986530604-q21roe9mfsgc0k7an1fsl6kikseb5q1d.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    // Once the user is signed in via Google, use their credential to sign into Firebase
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            // Handle Errors
            if let error = error {
                print(error.localizedDescription)
                if error != nil {
                    let alert = UIAlertController(title: "Google Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                         print("")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            // If login was successful then move to the next screen
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "initialVC")
                controller.hero.isEnabled = true
                controller.hero.modalAnimationType = .slide(direction: .left)
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
        })
    }
    
    // Sign-In with Email/Password
    @IBAction func signIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text ?? "", password: passwordField.text ?? "") { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            // Handle errors
            if error != nil {
                let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                     print("")
                }))
                self!.present(alert, animated: true, completion: nil)
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "initialVC")
                controller.hero.isEnabled = true
                controller.hero.modalAnimationType = .slide(direction: .left)
                controller.modalPresentationStyle = .fullScreen
                self!.present(controller, animated: true, completion: nil)
            }
        }
    }
    

}
