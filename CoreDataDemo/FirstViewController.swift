//
//  FirstViewController.swift
//  CoreDataDemo
//
//  Created by Mohamed Sobhi  Fouda on 4/15/18.
//  Copyright © 2018 CareerFoundry. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Age: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK - Get the FileManager/Documents Path
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsURL = paths[0] as NSURL
        print(documentsURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SaveToCoreData(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        let person = Person(entity: entity!, insertInto: context)
        person.firstName = FirstName.text
        person.lastName = LastName.text
        person.age = Int32(Age.text!)!
        appDelegate.saveContext()
        
        FirstName.text = ""
        LastName.text = ""
        Age.text = ""
        
    }
    
    @IBAction func ShowButtonTapped(_ sender: UIBarButtonItem) {
    
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Nav")
        
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender
        popover.delegate = self as? UIPopoverPresentationControllerDelegate
        present(viewController, animated: true, completion:nil)
        
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
