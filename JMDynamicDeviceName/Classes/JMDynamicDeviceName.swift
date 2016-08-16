//
//  JMDeviceName.swift
//  JMDeviceName
//
//  Created by jerome morissard on 06/08/2016.
//  Copyright © 2016 Jérôme Morissard. All rights reserved.
//

import UIKit

let githubProjectPath = "https://leverdeterre.github.io/JMDynamicDeviceName/ios-models.json"
let userDefaultLastModifiedKey = "JMDynamicDeviceName.Last-Modified"
let userDefaultJSONKey = "JMDynamicDeviceName.ios-models.json"

public class JMDeviceName {

    lazy var deviceName: String = self.initializeDeviceName()
    lazy var deviceFamilyName: String = self.initializeDeviceFamilyName()

    func initializeDeviceName() -> String {
        let sysName = JMDeviceName.deviceMachineName()
        var json = JMDeviceName.moreUpToDateJSON()
        if let systemInformations = json[sysName] {
            if let name = systemInformations["name"] {
                return name
            }
        }
        return "iPhone Simulator"
    }
    
    func initializeDeviceFamilyName() -> String {
        let sysName = JMDeviceName.deviceMachineName()
        var json = JMDeviceName.moreUpToDateJSON()
        if let systemInformations = json[sysName] {
            if let name = systemInformations["familyName"] {
                return name
            }
        }
        return "iPhone Simulator"
    }

    class public func deviceMachineName() -> String {
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    
    class func moreUpToDateJSON() -> [String:[String:String]] {
        let userDefault = NSUserDefaults.standardUserDefaults()
        var json: [String:[String:String]]?
        json = (userDefault.objectForKey(userDefaultJSONKey) as? [String:[String:String]])
        if let json = json {
            return json
        
        } else {
            let jmBundle = NSBundle(forClass: self)
            var filePath = jmBundle.pathForResource("JMDynamicDeviceName.bundle/ios-models", ofType: "json")
            let data = NSData(contentsOfFile:filePath!)
            json = try!NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! [String:[String:String]]
            if let json = json {
                return json
            }
        }
        
        return [String:[String:String]]()
    }
    
    public class func deviceName(systemName: String) -> String {
        var json = moreUpToDateJSON()
        if let systemInformations = json[systemName] {
            if let name = systemInformations["name"] {
                return name
            }
        }
        return systemName
    }
    
    public class func deviceFamilyName(systemName: String) -> String {
        var json = moreUpToDateJSON()
        if let systemInformations = json[systemName] {
            if let name = systemInformations["familyName"] {
                return name
            }
        }
        return systemName
    }
}

// MARK: Extension for networks calls

extension JMDeviceName {
    
    public class func getLastModifiedDate (then: (str: String?) -> Void) -> Void {
        let mRequest = NSMutableURLRequest(URL: NSURL(string: githubProjectPath)!)
        mRequest.HTTPMethod = "HEAD"
        
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = urlSession.downloadTaskWithRequest(mRequest) { (url, response, error) in
            if let myResponse = response {
                let urlHttpResponse = myResponse as! NSHTTPURLResponse
                let lastModifiedField = urlHttpResponse.allHeaderFields["Last-Modified"]
                then(str: (lastModifiedField as? String))
                
            } else {
                then(str: nil)
            }
        }
        task.resume()
    }
    
    public class func getGithubJson (then: (dict: [String : [String:String]]?) -> Void) -> Void {
        let mRequest = NSMutableURLRequest(URL: NSURL(string: githubProjectPath)!)
        mRequest.HTTPMethod = "GET"
        
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = urlSession.dataTaskWithRequest(mRequest) { (data, response, error) in
            if let myResponse = response {
                let json: [String:[String:String]]
                json = try!NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! [String:[String:String]]
                then(dict: json)
                
            } else {
                then(dict: nil)
            }
        }
        task.resume()
    }
    
    public class func checkForUpdate (){
        let userDefault = NSUserDefaults.standardUserDefaults()
        if (userDefault.objectForKey(userDefaultLastModifiedKey) == nil) {
            getLastModifiedDate({ (lastModifiedString) in
                getGithubJson({ (jsonDict) in
                    if lastModifiedString != nil
                    && jsonDict != nil
                    {
                        userDefault.setObject(lastModifiedString, forKey: userDefaultLastModifiedKey)
                        userDefault.setObject(jsonDict, forKey: userDefaultJSONKey)
                    }
                })
            })
            
        } else {
            getLastModifiedDate({ (lastModifiedString) in
                if userDefault.objectForKey(userDefaultLastModifiedKey) as? String != lastModifiedString {
                    getGithubJson({ (jsonDict) in
                        if lastModifiedString != nil
                            && jsonDict != nil
                        {
                            print("JMDeviceName.checkForUpdate -> json model update done")
                            userDefault.setObject(lastModifiedString, forKey: userDefaultLastModifiedKey)
                            userDefault.setObject(jsonDict, forKey: userDefaultJSONKey)
                        }
                    })
                } else {
                    print("JMDeviceName.checkForUpdate -> nothing has change")
                }
            })
        }
    }
}
