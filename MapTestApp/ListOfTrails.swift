//
//  ListOfTrails.swift
//  MapTestApp
//
//  Created by students on 2/12/21.
//

import UIKit

class ListOfTrails: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var trailsTable: UITableView!
    
    let trailArray: [String] = ["Boggy Hole", "Belton Copp", "Lay Preserve"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trailsTable.delegate = self
        trailsTable.dataSource = self
        
        self.trailsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trailArray.count
    }
    
    func tableView(_ trailsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trailArray.count
    }

    func tableView(_ trailsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.trailsTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = self.trailArray[indexPath.row]
        
        return cell
    }
    
}
