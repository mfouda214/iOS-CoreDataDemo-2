//
//  ViewController.swift
//  CoreDataDemo
//
//  Updated by Mohamed Sobhi Fouda on 15/4/18.
//  Created by Hesham Abd-Elmegid on 10/12/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var people = [Person]()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            people = results as! [Person]
        } catch let error as NSError {
            print("Fetching Error: \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTasksViewController" {
            let viewController = segue.destination as! TasksTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            let person = people[(selectedIndexPath?.row)!]
            viewController.person = person
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let person = people[indexPath.row]
        let firstName = person.firstName
        let lastName = person.lastName
        let age = person.age
        cell.textLabel?.text = "\(firstName!) \(lastName!) age \(age)"
        
        return cell
    }
    @IBAction func RootView(_ sender: UIBarButtonItem) {
   
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "First")
        
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self as? UIPopoverPresentationControllerDelegate
        present(viewController, animated: true, completion:nil)
        
    
    }
    
    @IBAction func addButtonWasTapped(_ sender: UIBarButtonItem) {
//        let randomFirstName = firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
//        let randomLastName = lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
//        let randomAge = ages[Int(arc4random_uniform(UInt32(ages.count)))]
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
//
//        let person = Person(entity: entity!, insertInto: context)
//        person.firstName = randomFirstName
//        person.lastName = randomLastName
//        person.age = Int32(randomAge)
//        appDelegate.saveContext()
//        people.append(person)
//
//        self.tableView.reloadData()
        ////////////
        
        let alertController = UIAlertController(title: "Add Person", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "First Name"
        })
        
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Last Name"
        })
        
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Age"
        })
        
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if let firstName = alertController.textFields?[0].text {
               let lastName = alertController.textFields?[1].text
                let age = Int32((alertController.textFields?[2].text)!)
                        
                self.createPerson(firstName: firstName, lastName: lastName!, age: age!)
                
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func createPerson(firstName: String, lastName: String, age: Int32) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        let person = Person(entity: entity!, insertInto: context)
        person.firstName = firstName
        person.lastName = lastName
        person.age = age
        appDelegate.saveContext()
        people.append(person)
        
        self.tableView.reloadData()
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(FirstViewController.dismissViewController))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        return navigationController
        
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

