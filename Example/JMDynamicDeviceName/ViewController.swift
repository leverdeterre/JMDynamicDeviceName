//
//  MasterViewController.swift
//  JMDynamicDeviceName
//
//  Created by jerome morissard on 06/08/2016.
//  Copyright © 2016 Jérôme Morissard. All rights reserved.
//

import UIKit
import JMDynamicDeviceName

class MasterViewController: UITableViewController {
    
    var objects = [
        "x86_64",
        "iPhone1,1",
        "iPhone1,2",
        "iPhone2,1",
        "iPhone3,1",
        "iPhone3,2",
        "iPhone3,3",
        "iPhone4,1",
        "iPhone5,1",
        "iPhone5,2",
        "iPhone5,3",
        "iPhone5,4",
        "iPhone6,1",
        "iPhone6,2",
        "iPhone7,1",
        "iPhone7,2",
        "iPhone8,1",
        "iPhone8,2",
        "iPhone8,4",
        "iPod1,1",
        "iPod2,1",
        "iPod3,1",
        "iPod4,1",
        "iPod5,1",
        "iPod7,1",
        "iPad1,1",
        "iPad2,1",
        "iPad2,2",
        "iPad2,3",
        "iPad2,4",
        "iPad2,5",
        "iPad2,6",
        "iPad2,7",
        "iPad3,1",
        "iPad3,2",
        "iPad3,3",
        "iPad3,4",
        "iPad3,5",
        "iPad3,6",
        "iPad4,1",
        "iPad4,2",
        "iPad4,3",
        "iPad4,4",
        "iPad4,5",
        "iPad4,6",
        "iPad4,7",
        "iPad4,8",
        "iPad4,9",
        "iPad5,1",
        "iPad5,2",
        "iPad5,3",
        "iPad5,4",
        "iPad6,3",
        "iPad6,4",
        "iPad6,7",
        "iPad6,8"]

    var myDeviceMachineName :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myDeviceMachineName = JMDeviceName.deviceMachineName()
        JMDeviceName.checkForUpdate()
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = JMDeviceName.deviceName(object)
        if objects[indexPath.row] == myDeviceMachineName {
            cell.backgroundColor = UIColor.blueColor()
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

