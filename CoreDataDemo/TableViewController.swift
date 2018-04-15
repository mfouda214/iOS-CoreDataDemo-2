//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Hesham Abd-Elmegid on 10/12/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    let firstNames = ["Jane", "John", "Stephen", "Stacy", "Taylor", "Alex", "Eren"]
    let lastNames = ["White", "Black", "Fox", "Jones", "King", "McQueen", "Yeager"]
    let ages = [25, 26, 20, 30, 27, 28, 23]
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

    @IBAction func addButtonWasTapped(_ sender: UIBarButtonItem) {
        let randomFirstName = firstNames[Int(arc4random_uniform(UInt32(firstNames.count)))]
        let randomLastName = lastNames[Int(arc4random_uniform(UInt32(lastNames.count)))]
        let randomAge = ages[Int(arc4random_uniform(UInt32(ages.count)))]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        let person = Person(entity: entity!, insertInto: context)
        person.firstName = randomFirstName
        person.lastName = randomLastName
        person.age = Int32(randomAge)
        appDelegate.saveContext()
        people.append(person)
        
        self.tableView.reloadData()
    }

}

