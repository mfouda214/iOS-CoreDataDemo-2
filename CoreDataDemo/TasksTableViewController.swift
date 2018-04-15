//
//  TasksTableViewController.swift
//  CoreDataDemo
//
//  Updated by Mohamed Sobhi Fouda on 15/4/18.
//  Created by Hesham Abd-Elmegid on 10/12/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    var person: Person?
    var tasks = [Task]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tasks = person?.tasks {
            self.tasks = tasks.allObjects as! [Task]
        }
    }
    
    @IBAction func addButtonWasTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Task"
        })
        
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if let title = alertController.textFields?[0].text {
                self.createTask(title: title)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func createTask(title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        
        let task = Task(entity: entity!, insertInto: context)
        task.title = title
        task.person = person
        appDelegate.saveContext()
        tasks.append(task)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = tasks[indexPath.row]
        let title = task.title
        task.person = person
        cell.textLabel?.text = title
        
        return cell
    }
}
