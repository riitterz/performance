//
//  CacheViewController.swift
//  performance-1788
//
//  Created by Macbook on 01.03.2022.
//

import UIKit

class CacheViewController: UITableViewController {

    lazy var photoService = PhotoService(container: self.tableView)
    
    lazy var weatherUrl: String = {
        return "http://openweathermap.org/img/w/weatherIcon.png"
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        
        
        cell.imageView?.image = photoService.photo(atIndexpath: indexPath, byUrl: weatherUrl)
       
        return cell
    }
    
}
