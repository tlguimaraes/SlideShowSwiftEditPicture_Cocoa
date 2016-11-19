//
//  SlideViewController.swift
//  Integritas
//
//  Created by Thiago Guimaraes on 11/18/16.
//  Copyright © 2016 Thiago Guimaraes. All rights reserved.
//


import UIKit

class SlideViewController: UIViewController, UIPageViewControllerDataSource {

// MARK: - Variables
private var pageViewController: UIPageViewController?
@IBOutlet weak var btnSlideShow: UIBarButtonItem!

// Initialize it right away here
//private let contentImages = ["meal1","meal2","meal3"]
private let contentImages = MessageViewCell.Data.myStrings


// MARK: - View Lifecycle
override func viewDidLoad() {
    super.viewDidLoad()
    loadSampleThiagos()
    createPageViewController()
    setupPageControl()
    
}



@IBAction func btnCaptureImageClick(sender: AnyObject) {

let next = (self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerImage"))! as UIViewController
self.presentViewController(next, animated: true, completion: nil)

print("*****Test.")
}
func loadSampleThiagos() {
    
    
    print("[Thiago] Expected pictures to be on SlideShow: ",MessageViewCell.loadedPictures.cache.enumerate())
    print("[Thiago] Images: ",MessageViewCell.Data.myStrings)
    
    
}

private func createPageViewController() {

let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
pageController.dataSource = self

if contentImages.count > 0 {
let firstController = getItemController(0)!
let startingViewControllers = [firstController]
pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
}

pageViewController = pageController
addChildViewController(pageViewController!)
self.view.addSubview(pageViewController!.view)
pageViewController!.didMoveToParentViewController(self)
}

private func setupPageControl() {
let appearance = UIPageControl.appearance()
appearance.pageIndicatorTintColor = UIColor.grayColor()
appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
appearance.backgroundColor = UIColor.darkGrayColor()
}

// MARK: - UIPageViewControllerDataSource

func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

let itemController = viewController as! PageItemController

if itemController.itemIndex > 0 {
return getItemController(itemController.itemIndex-1)
}

return nil
}

func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

let itemController = viewController as! PageItemController

if itemController.itemIndex+1 < contentImages.count {
return getItemController(itemController.itemIndex+1)
}

return nil
}

private func getItemController(itemIndex: Int) -> PageItemController? {

if itemIndex < contentImages.count {
let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
pageItemController.itemIndex = itemIndex
pageItemController.imageName = contentImages[itemIndex]
return pageItemController
}

return nil
}

// MARK: - Page Indicator

func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
return contentImages.count
}

func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
return 0
}

// MARK: - Additions

func currentControllerIndex() -> Int {

let pageItemController = self.currentController()

if let controller = pageItemController as? PageItemController {
return controller.itemIndex
}

return -1
}

func currentController() -> UIViewController? {

if self.pageViewController?.viewControllers?.count > 0 {
return self.pageViewController?.viewControllers![0]
}

return nil
}

}



