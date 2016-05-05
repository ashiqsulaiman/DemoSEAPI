//
//  MainTableViewController.swift
//  DemoSEAPI
//
//  Created by ashiq on 15/03/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageLoader

class MainTableViewController: UITableViewController, UISearchBarDelegate, MainTableViewCellDelegate {
    
    
   
    var searchController = UISearchController(searchResultsController: nil)
    let requestManager = RequestManager()
    
    
    var validatedText: String{
        return searchController.searchBar.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20").lowercaseString
    }
    
    //empty array to store the filtered results
    var searchResults:[JSON] = [] {
        didSet {
            tableView.reloadData()
        }
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    searchController.searchBar.delegate = self
    tableView.tableHeaderView = searchController.searchBar
    searchController.dimsBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    definesPresentationContext = true
        
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainTableViewController.updateSearchResults), name: "searchResultsUpdated", object: nil)
        
        //Enabling self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
     
        
 }
    
    func updateSearchResults() {
        
        //print(requestManager.searchResults)
        searchResults = requestManager.searchResults
        }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return searchResults.count
    
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell
       
        // for circular images
        cell.avatarLabel.layer.cornerRadius = 30
        cell.avatarLabel.clipsToBounds = true
        
        
        cell.nameLabel?.text = searchResults[indexPath.row]["owner"]["display_name"].stringValue
        cell.questionLabel?.text = searchResults[indexPath.row]["title"].stringValue
        cell.avatarLabel.load(searchResults[indexPath.row]["owner"]["profile_image"].stringValue)
        
        
        cell.rowIndex = indexPath.row
        cell.delegates = self
        
        if indexPath.row == searchResults.count - 10 {
            if requestManager.hasMore {
                requestManager.getNextPage(validatedText)
            }
        }
        
        return cell
    }
    
  

    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        requestManager.resetSearch() //empties the array
        updateSearchResults() // updates the populated array with emptied array
        requestManager.alamofireFunction(validatedText) //calls the function with the validatedText
       
        
    }
  
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPost" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let _url = searchResults[indexPath.row]["link"].stringValue
                let destinationController = segue.destinationViewController as! ShowPostViewController
                destinationController.url = _url
            }
            else if segue.identifier == "ProfileInfo" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    
                    let _userName = searchResults[indexPath.row]["owner"]["display_name"].stringValue
                    // print("name dc: \(destinationController.userName)")
                    let _userId = searchResults[indexPath.row]["owner"]["user_id"].stringValue
                    let _userReputation = searchResults[indexPath.row]["owner"]["reputation"].stringValue
                    let _ppImageString = searchResults[indexPath.row]["owner"]["profile_image"].stringValue
                    let destinationController = segue.destinationViewController as! ProfileInfoViewController
                    destinationController.userName = _userName
                    destinationController.userId = _userId
                    destinationController.userReputation = _userReputation
                    destinationController.ppImageString = _ppImageString

                    
                }
            }
            
            
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
   
//    @IBAction func showProfileInfo(sender: AnyObject) {
//        print("tapped")
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        showProfileInfo(indexPath.row)
//    }
   

    func profilePicTouchedAtIndex(index: Int) {
        print("ppic touched at rowIndex : \(index)")
        
        performSegueWithIdentifier("ProfileInfo", sender: nil)
        
        
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ProfileInfo" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let _url = searchResults[indexPath.row]["link"].stringValue
//                let destinationController = segue.destinationViewController as! ShowPostViewController
//                destinationController.url = _url
//            }
//        }
//    }

    
}
