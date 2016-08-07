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

    private static var cachedDeviceName: String?
    private static var cachedDeviceFamilyName: String?

    class func platform() -> String {
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    
    public class func deviceName(systemName: String) -> String {
        loadJSON(systemName)
        let deviceName = cachedDeviceName
        cachedDeviceName = nil
        cachedDeviceFamilyName = nil
        return deviceName!
    }
    
    public class func deviceName() -> String {
        if (cachedDeviceName != nil) {
            return cachedDeviceName!
        }
        
        loadJSON()
        return cachedDeviceName!
    }
    
    public class func deviceFamilyName(systemName: String) -> String {
        loadJSON(systemName)
        let deviceFamilyName = cachedDeviceFamilyName
        cachedDeviceName = nil
        cachedDeviceFamilyName = nil
        return deviceFamilyName!
    }
    
    public class func deviceFamilyName() -> String {
        if (cachedDeviceFamilyName != nil) {
            return cachedDeviceFamilyName!
        }
        
        loadJSON()
        return cachedDeviceFamilyName!
    }
    
    
    class func loadJSON(systemName: String){
        let userDefault = NSUserDefaults()
        var json: [String:[String:String]]?
        json = (userDefault.objectForKey(userDefaultJSONKey) as? [String:[String:String]])
        
        if (json == nil) {
            var filePath = NSBundle.mainBundle().pathForResource("JMDynamicDeviceName", ofType: "bundle")
            let jmBundle = NSBundle(forClass: self)
            filePath = jmBundle.pathForResource("ios-models", ofType: "json")
            let data = NSData(contentsOfFile:filePath!)
            json = try!NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! [String:[String:String]]
            userDefault.setObject(json, forKey: userDefaultJSONKey)
        }

        var system = json![systemName]
        if (system == nil) {
            cachedDeviceName = "iPhone Simulator"
            cachedDeviceFamilyName = "iPhone Simulator"
            
        } else {
            cachedDeviceName = system!["name"]!
            cachedDeviceFamilyName = system!["familyName"]!
        }
    }
    
    class func loadJSON(){
        let sysName = platform()
        loadJSON(sysName)
    }
}

// MARK: Extension for networks calls

extension JMDeviceName {
    
    public class func getLastModifiedDate (completionBlock: (str: String?) -> Void) -> Void {
        let mRequest = NSMutableURLRequest(URL: NSURL(string: githubProjectPath)!)
        mRequest.HTTPMethod = "HEAD"
        
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = urlSession.downloadTaskWithRequest(mRequest) { (url, response, error) in
            let urlHttpResponse = response as! NSHTTPURLResponse
            let lastModifiedField = urlHttpResponse.allHeaderFields["Last-Modified"]
            completionBlock(str: (lastModifiedField as? String))
        }
        task.resume()
    }
    
    public class func getGithubJson (completionBlock: (dict: [String : [String:String]]?) -> Void) -> Void {
        let mRequest = NSMutableURLRequest(URL: NSURL(string: githubProjectPath)!)
        mRequest.HTTPMethod = "GET"
        
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = urlSession.dataTaskWithRequest(mRequest) { (data, response, error) in
            let json: [String:[String:String]]
            json = try!NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! [String:[String:String]]
            completionBlock(dict: json)
        }
        task.resume()
    }
    
    public class func checkForUpdate (){
        let userDefault = NSUserDefaults()
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
