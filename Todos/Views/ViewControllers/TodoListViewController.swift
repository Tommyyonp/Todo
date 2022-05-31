//
//  TodoListViewController.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext {
        get {
            return delegate.persistentContainer.viewContext
        }
    }
    
    var todosCoreData = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        let request = Todo.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            todosCoreData = result
        } catch {
            print("error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Todos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(didTapAddBtn)
        )
        self.navigationItem.rightBarButtonItem = addButton
    }
}

extension TodoListViewController {
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            TodoViewCell.nib(),
            forCellReuseIdentifier: TodoViewCell.id
        )
    }
    
    @objc private func didTapAddBtn() {
        let vc = AddTodoViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
}

extension TodoListViewController : AddTodoViewControllerDelegate {
    func didSuccessAddTodo(title: String, content: String) {
        let newTodo = Todo(context: context)
        
        newTodo.setValue(title, forKey: "title")
        newTodo.setValue(content, forKey: "content")
        newTodo.setValue(false, forKey: "isDone")
        
        todosCoreData.append(newTodo)
        saveContext()
    
        reloadTableView()
    }
}

extension TodoListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        todosCoreData.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TodoViewCell.id,
            for: indexPath
        ) as? TodoViewCell
        cell?.data = todosCoreData[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        todosCoreData[indexPath.row].isDone = !todosCoreData[indexPath.row].isDone
        saveContext()
        reloadTableView()
    }
    
    func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        true
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            context.delete(todosCoreData[indexPath.row])
            todosCoreData.remove(at: indexPath.row)
            saveContext()
            reloadTableView()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
