//
//  RegisterViewController.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//

import UIKit

class RegisterViewController: UIViewController {
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

  var users: [User] = []
  let defaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func didTapRegister(_ sender: UIButton) {
    guard let username = usernameField.text,
          let password = passwordField.text
    else { return }
    let newUser = User(username: username, password: password)
    users.append(newUser)
    defaults.setValue(users, forKey: "registerUser")
    let ac = UIAlertController(title: "Register berhasil", message: "Anda sudah teregistrasi. Silahkan Login", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.navigationController?.popViewController(animated: true)
    }))
    present(ac, animated: true)
  }
}
