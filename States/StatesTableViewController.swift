//
//  StatesTableViewController.swift
//  States
//
//  Created by Mark Meretzky on 2/24/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import UIKit;
import SafariServices;

class StatesTableViewController: UITableViewController {
/*
    var states: [String] = [   //The model is an array of 50 Strings.
        "Alabama",
        "Alaska",
        "Arizona",
        "Arkansas",
        "California",
        "Colorado",
        "Connecticut",
        "Delaware",
        "Florida",
        "Georgia",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Pennsylvania",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming"
    ];
*/
    
/*
    var zones: [[String]] = [   //The model is an array of 5 arrays.
        
        //EST: Eastern Standard Time
        [
            "Alabama",
            "Connecticut",
            "Delaware",
            "Florida",
            "Georgia",
            "Indiana",
            "Kentucky",
            "Maine",
            "Maryland",
            "Massachusetts",
            "Michigan",
            "New Hampshire",
            "New Jersey",
            "New York",
            "North Carolina",
            "Ohio",
            "Pennsylvania",
            "Rhode Island",
            "South Carolina",
            "Tennessee",
            "Vermont",
            "Virginia",
            "West Virginia"
        ],
        
        //CST: Central Standard Time
        [
            "Arkansas",
            "Illinois",
            "Iowa",
            "Kansas",
            "Louisiana",
            "Minnesota",
            "Mississippi",
            "Missouri",
            "Nebraska",
            "North Dakota",
            "Oklahoma",
            "South Dakota",
            "Texas",
            "Wisconsin"
        ],
        
        //MST: Mountain Standard Time
        [
            "Arizona",
            "Colorado",
            "Idaho",
            "Montana",
            "New Mexico",
            "Utah",
            "Wyoming"
        ],
        
        //PST: Pacific Standard Time
        [
            "California",
            "Nevada",
            "Oregon",
            "Washington"
        ],
        
        //Miscellaneous
        [
            "Alaska",
            "Hawaii"
        ]
    ];
*/
 
    var zones: [Zone] = [   //The model is an array of 5 instances.
     
        Zone(name: "EST: Eastern Standard Time (UTC-05:00)", states: [
            "Alabama",
            "Connecticut",
            "Delaware",
            "Florida",
            "Georgia",
            "Indiana",
            "Kentucky",
            "Maine",
            "Maryland",
            "Massachusetts",
            "Michigan",
            "New Hampshire",
            "New Jersey",
            "New York",
            "North Carolina",
            "Ohio",
            "Pennsylvania",
            "Rhode Island",
            "South Carolina",
            "Tennessee",
            "Vermont",
            "Virginia",
            "West Virginia"
            ]),
        
        Zone(name: "CST: Central Standard Time (UTC-06:00)", states: [
            "Arkansas",
            "Illinois",
            "Iowa",
            "Kansas",
            "Louisiana",
            "Minnesota",
            "Mississippi",
            "Missouri",
            "Nebraska",
            "North Dakota",
            "Oklahoma",
            "South Dakota",
            "Texas",
            "Wisconsin"
            ]),
        
        Zone(name: "MST: Mountain Standard Time (UTC-07:00)", states: [
            "Arizona",
            "Colorado",
            "Idaho",
            "Montana",
            "New Mexico",
            "Utah",
            "Wyoming"
            ]),
        
        Zone(name: "PST: Pacific Standard Time (UTC-08:00)", states: [
            "California",
            "Nevada",
            "Oregon",
            "Washington"
            ]),
        
        Zone(name: "Miscellaneous", states: [
            "Alaska",
            "Hawaii"
            ])
    ];

    override func viewDidLoad() {
        super.viewDidLoad();

        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.rightBarButtonItem = editButtonItem;
    }

    // MARK: - Protocol UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return zones.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (0 ..< zones.count).contains(section) else {
            fatalError("table contains no section number \(section)");
        }

        return zones[section].states.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard (0 ..< zones.count).contains(indexPath.section) else {
            fatalError("table contains no section number \(indexPath.section)");
        }
        
        guard (0 ..< zones[indexPath.section].states.count).contains(indexPath.row) else {
            fatalError("section \(indexPath.section) contains no cell number \(indexPath.row)");
        }
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "StatesCell", for: indexPath);

        // Configure the cell ...
        let state: String = zones[indexPath.section].states[indexPath.row];
        cell.textLabel?.text = state;
        cell.detailTextLabel?.text = "\(state) is state number \(indexPath.row + 1) of \(zones[indexPath.section].states.count) in zone \(indexPath.section + 1).";
        cell.imageView?.image = UIImage(named: state);
        cell.showsReorderControl = true;
        return cell;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source.
            zones[indexPath.section].states.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // Override to support rearranging the table view.
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let state: String = zones[fromIndexPath.section].states.remove(at: fromIndexPath.row);
        zones[to.section].states.insert(state, at: to.row);
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (0 ..< zones.count).contains(section) else {
            fatalError("no header for section number \(section)");
        }
/*
        let names: [String] = [
            "EST: Eastern Standard Time",
            "CST: Central Standard Time",
            "MST: Mountain Standard Time",
            "PST: Pacific Standard Time",
            "Miscellaneous"
        ];
*/
        return zones[section].name;
    }
    
    // MARK: - Protocol UITableViewControllerDelegate
    
    //Called when a cell is tapped.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state: String = zones[indexPath.section].states[indexPath.row];
        print("selected \(state) in cell number \(indexPath)");
        
        var urlComponents: URLComponents = URLComponents();
        urlComponents.scheme = "https";
        urlComponents.host = "en.wikipedia.org";   //English
        urlComponents.path = "/wiki/\(state)";

        guard let url: URL = urlComponents.url else {
            fatalError("could not create url for state \(state)");
        }
        
        let safariViewController: SFSafariViewController = SFSafariViewController(url: url);
        present(safariViewController, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
