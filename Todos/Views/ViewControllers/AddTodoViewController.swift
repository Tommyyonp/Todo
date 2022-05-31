//
//  AddTodoViewController.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//

import UIKit

protocol AddTodoViewControllerDelegate {
    func didSuccessAddTodo(title : String, content: String)
}

class AddTodoViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextField!
    
    var delegate : AddTodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        guard let title = titleField.text,
              let content = contentField.text
        else { return }
        delegate?.didSuccessAddTodo(
            title: title,
            content: content
        )
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
