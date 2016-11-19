//
//  ThiagoTableViewController.swift
//  ThiagoLeoncioTracker
//
//  Created by Thiago Leoncio on11/15/16.
//  Copyright © 2016 Leoncio. All rights reserved.


import UIKit

class ThiagoTableViewController: UITableViewController {
    // MARK: Properties
    
    @IBOutlet weak var btnSaveFile: UIBarButtonItem!
    var thiagos = [Thiago]()
    var SlideViewController: UIPageViewController?
    @IBOutlet weak var btnSlideShow: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()

        // Load the sample data.
        loadSampleThiagos()
        print("INIT COUNT ARRAY:", thiagos.count)
    }
    
    func loadSampleThiagos() {
        let photo1 = UIImage(named: "meal1")!
        MessageViewCell.Data.myStrings.append("meal1")
        MessageViewCell.PhotoNamed.value.append(UIImage(named: "meal1")!)
        let thiago1 = Thiago(name: "GiveMeaJob@", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "meal2")!
        MessageViewCell.Data.myStrings.append("meal2")
        MessageViewCell.PhotoNamed.value.append(UIImage(named: "meal2")!)
        let thiago2 = Thiago(name: "LoveIOSDevelopment", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "meal3")!
        MessageViewCell.Data.myStrings.append("meal3")
        MessageViewCell.PhotoNamed.value.append(UIImage(named: "meal3")!)
        let thiago3 = Thiago(name: "GoForIT", photo: photo3, rating: 3)!
        
        thiagos += [thiago1, thiago2, thiago3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thiagos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ThiagoTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ThiagoTableViewCell
        
        // Fetches the appropriate thiago for the data source layout.
        let thiago = thiagos[indexPath.row]
        cell.nameLabel.text = thiago.name
        cell.photoImageView.image = thiago.photo
        //cell.ratingControl.rating = thiago.rating
        
        MessageViewCell.loadedPictures.cache[thiago.name] = thiago.name
        print("[Thiago] PIC: ",MessageViewCell.loadedPictures.cache.enumerate())
        MessageViewCell.Data.myStrings.append(String(thiago.photo))
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            thiagos.removeAtIndex(indexPath.row)
            MessageViewCell.Data.myStrings.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let thiagoDetailViewController = segue.destinationViewController as! ThiagoViewController
            
            // Get the cell that generated this segue.
            if let selectedThiagoCell = sender as? ThiagoTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedThiagoCell)!
                let selectedThiago = thiagos[indexPath.row]
                thiagoDetailViewController.thiago = selectedThiago
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new thiago.")
        }
    }
    

    @IBAction func btnSaveFileClick(sender: AnyObject) {
        //Action to Save File Locally
        let SelectSaveFileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SelectSaveFileViewController")
        self.navigationController?.pushViewController(SelectSaveFileViewController!, animated:true)

        
        
    }
    @IBAction func btnSlideShowClick(sender: AnyObject) {
        
        
        //loading Array to get from another ViewController
        
        let SlideViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SlideViewController")
        self.navigationController?.pushViewController(SlideViewController!, animated:true)
        
        //let SlideViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SlideViewController") as SlideViewController
        //self.navigationController?.pushViewController(SlideViewController, animated:true)
        
    }
    @IBAction func unwindToThiagoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ThiagoViewController, thiago = sourceViewController.thiago {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing thiago.
                thiagos[selectedIndexPath.row] = thiago
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new thiago.
                let newIndexPath = NSIndexPath(forRow: thiagos.count, inSection: 0)
                thiagos.append(thiago)
                //MessageViewCell.Data.myStrings.append(thiago.name)
                //MessageViewCell.PhotoNamed.value.append(UIImage(named: "meal1")!)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
}
