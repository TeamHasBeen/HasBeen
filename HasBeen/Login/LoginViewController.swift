//
//  LoginViewController.swift
//  BeReal
//
//  Created by David Pegg on 2/24/23.
//

import UIKit
/*
 Add onLoginTapped() and post login notification
 Add segue to sign up view when the sign up button is tapped.
 */
class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onLoginTapped(_ sender: Any) {
        guard let username = usernameField.text,
              let password =  passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {
            showMissingFieldAlert()
            return
        }
        
        User.login(username: username, password: password) {[weak self] result in
            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")
                
                NotificationCenter.default.post(name: Notification.Name("Login"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    
    private func showMissingFieldAlert() {
        let alertController = UIAlertController(title: "Error.", message: "All fields need to be completed in order to log in.", preferredStyle: .alert)
        let action = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(action)
        present(alertController,animated: true)
    }
}

