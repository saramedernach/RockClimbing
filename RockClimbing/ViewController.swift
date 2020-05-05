//
//  ViewController.swift
//  RockClimbing
//
//  Created by Sara Medernach on 5/4/20.
//  Copyright © 2020 Sara Medernach. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchResults:[Crag] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        LocationController.startMonitoringLocation()
        
        fetchCragResults()
        
    }
    
    @IBAction func addCragTapped(_ sender: Any) {
        
        let cragViewController = storyboard?.instantiateViewController(identifier: String(describing: ModifyCragViewController.self)) as! ModifyCragViewController
        
        navigationController?.pushViewController(cragViewController, animated: true )
        
    }
    
    fileprivate func fetchCragResults() {
        // Do any additional setup after loading the view.
        
        let context = DatabaseController.persistentStoreContainer().viewContext
        
        let fetchRequest:NSFetchRequest = Crag.fetchRequest()
        
        do {
            
            fetchResults = try context.fetch(fetchRequest)
            
        }
        catch {
            
            print(error)
            
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CragCell")
        
        cell?.textLabel?.text = fetchResults[indexPath.row].cragName
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        
        let selectedCrag = fetchResults[rowIndex]
        
        let cragViewController = storyboard?.instantiateViewController(identifier: String(describing: CragViewController.self)) as! CragViewController
        
        self.navigationController?.pushViewController(cragViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}

