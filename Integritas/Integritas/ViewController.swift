//
//  ViewController.swift
//  Integritas
//
//  Created by Thiago Guimaraes on 11/17/16.
//  Copyright © 2016 Thiago Guimaraes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
class MessageViewCell {
    struct loadedPictures {
        static var cache: [String:String] = Dictionary<String, String>()
    }
    struct Data {
        
        static var myStrings = [String]()  // Image to be loaded in the SlideShow
        
    }
    struct PhotoNamed {
        
        static var value = [UIImage]()  // Image to be loaded in the SlideShow
        
    }
}
