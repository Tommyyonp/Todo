//
//  LoginViewController.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }


  @IBAction func didTapLogin(_ sender: UIButton) {
    navigationController?.pushViewController(TodoListViewController(), animated: true)
  }

  @IBAction func didTapRegister(_ sender: UIButton) {
    navigationController?.pushViewController(RegisterViewController(), animated: true)
  }
}
