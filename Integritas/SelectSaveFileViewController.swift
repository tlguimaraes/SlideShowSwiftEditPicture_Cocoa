//
//  SelectSaveFileViewController.swift
//  Integritas
//
//  Created by Thiago Guimaraes on 11/18/16.
//  Copyright © 2016 Thiago Guimaraes. All rights reserved.
//

import UIKit

class SelectSaveFileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Properties
    var imagesDirectoryPath:String!
    var images:[UIImage]!
    var titles:[String]!
    
    @IBAction func choosePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        presentViewController(imagePicker, animated: true, completion: nil)
        imagePicker.delegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = []
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        imagesDirectoryPath = documentDirectorPath.stringByAppendingString("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = NSFileManager.defaultManager().fileExistsAtPath(imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try NSFileManager.defaultManager().createDirectoryAtPath(imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable(){
        do{
            images.removeAll()
            titles = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(imagesDirectoryPath)
            for image in titles{
                let data = NSFileManager.defaultManager().contentsAtPath(imagesDirectoryPath.stringByAppendingString("/\(image)"))
                let image = UIImage(data: data!)
                images.append(image!)
            }
            self.tableView.reloadData()
        }catch{
            print("Error")
        }
    }
    
    
    //MARK: UIImagePickerControllerDelegate Protocol
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        // Save image to Document directory
        var imagePath = NSDate().description
        imagePath = imagePath.stringByReplacingOccurrencesOfString(" ", withString: "")
        imagePath = imagesDirectoryPath.stringByAppendingString("/\(imagePath).png")
        
        print("IMAGE PATH:",imagePath)
        //MessageViewCell.Data.myStrings.append(thiago.name)
        //MessageViewCell.PhotoNamed.value.append(UIImage(named: "meal1")!)
        let data = UIImagePNGRepresentation(image)
        let success = NSFileManager.defaultManager().createFileAtPath(imagePath, contents: data, attributes: nil)
        dismissViewControllerAnimated(true) { () -> Void in
            self.refreshTable()
        }
    }
    
    //MARK: UITableView DataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("CellID")
        cell?.imageView?.image = images[indexPath.row]
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
}

