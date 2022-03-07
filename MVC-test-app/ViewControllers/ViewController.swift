//
//  ViewController.swift
//  MVC-test-app
//
//  Created by IlyaCool on 6.03.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var loginInputField: UITextField!
    @IBOutlet var passwordInputField: UITextField!
    
    private let userService = UserService.getInstanse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @IBAction func logInClick() {
        let login = loginInputField.text!
        let password = passwordInputField.text!
    
        let loginingUser = User(login: login, password: password)
        
        if userService.logIn(user: loginingUser) {
            performSegue(withIdentifier: "logIn", sender: nil)
            return
        }
        showAlert(title: "Error!", message: "Incorrect login or password!", textFields: [passwordInputField])
    }
    
    @IBAction func signUpClick() {
        let login = loginInputField.text!
        let password = passwordInputField.text!
        
        let signingUpUser = User(login: login, password: password)
        
        if userService.register(user: signingUpUser) {
            showAlert(title: "Success!", message: "Use your new login and password for log in", textFields: [loginInputField, passwordInputField])
        }
        showAlert(title: "Error!", message: "Already user with this login", textFields: [loginInputField, passwordInputField])
    }
    
}

// MARK: Alert Controller
extension ViewController {
    func showAlert(title: String, message: String, textFields: [UITextField]? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textFields?.forEach() { textField in
                textField.text = ""
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: Content Lifting
extension ViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let keyboardSize = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!
        let superViewOffset = self.view.frame.origin.y
        if superViewOffset == 0 {
            self.view.frame.origin.y -= keyboardSize.height / 4
        }
    }
    
    @objc func kbWillHide() {
        self.view.frame.origin.y = 0
    }
}
