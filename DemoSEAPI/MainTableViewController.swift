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
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
    
    var searchController = UISearchController(searchResultsController: nil)
    let requestManager = RequestManager()
    
  // variables to send data to ShowPostViewController
    var _userId:String = ""
    var _userName:String = ""
    var _userReputation:String = ""
    var _ppImageString:String = ""
    
    var validatedText: String{
        return searchController.searchBar.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20").lowercaseString
    }
    
    //empty array to store the filtered results
    var searchResults:[JSON] = [] {
        didSet {
            
            tableView.reloadData()
            loadingIndicator.stopAnimating()
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        
           
            
            
         //hide the activity indicator when not loading
         loadingIndicator.hidesWhenStopped = true
            
            
        //search controller customization
        searchController.searchBar.placeholder = "Search posts..."
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red: 47.0/255.0, green:150.0/255.0, blue: 232.0/255.0, alpha: 0.7)
        
        
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true

        
        // table view cutomization
        tableView.backgroundColor = UIColor(red: 45, green: 46, blue: 47, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 45, green: 46, blue: 47, alpha: 0.5)
        //navigationController?.hidesBarsOnSwipe = true
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainTableViewController.updateSearchResults), name: "searchResultsUpdated", object: nil)
        
        //Enabling self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
     
        
 }
    
    func updateSearchResults() {
        
        //print(requestManager.searchResults)
        
        // alert view to display if there are no results
        if   requestManager.noResultsCheck == true {
            let alert = UIAlertController(title: "Oops!", message: "No results found", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { (Action) -> Void in
            self.searchController.searchBar.becomeFirstResponder()
            
            }
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
        }
        requestManager.noResultsCheck = false // set the flag to false again

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
       
        
        // start spinning the activity indicator
        
        //self.loadingIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5)
        

       self.loadingIndicator.center = self.tableView.center
                loadingIndicator.startAnimating()
        
    }
  
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPost" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! ShowPostViewController
                destinationController.url = searchResults[indexPath.row]["link"].stringValue
            }

            
        }
         if segue.identifier == "ProfileInfo" {
            let destinationController = segue.destinationViewController as! ProfileInfoViewController
            destinationController.userId = _userId
            destinationController.userName = _userName
            destinationController.userReputation = _userReputation
            destinationController.ppImageString = _ppImageString
    }
    }
 
    @IBAction func close(segue:UIStoryboardSegue) {
        
        
        
    }
    
   
    func profilePicTouchedAtIndex(index: Int) {
        print("ppic touched at rowIndex : \(index)")
        _userId = searchResults[index]["owner"]["user_id"].stringValue
        print(_userId)
        _userName = searchResults[index]["owner"]["display_name"].stringValue
        _userReputation = searchResults[index]["owner"]["reputation"].stringValue
        _ppImageString = searchResults[index]["owner"]["profile_image"].stringValue
        performSegueWithIdentifier("ProfileInfo", sender: nil)
        
        
    }
    


    
}
