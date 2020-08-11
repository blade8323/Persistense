//
//  ViewController.swift
//  Persistense
//
//  Created by Admin on 11.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lineFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = dataFileURL()
        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let array = NSArray(contentsOf: fileURL) as? [String] {
                for i in 0..<array.count {
                    lineFields[i].text = array[i]
                }
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    @objc func applicationWillResignActive(notification: Notification) {
        let fileURL = dataFileURL()
        print(fileURL)
        let array = (lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileURL, atomically: true)
    }

    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url: URL?
        url = URL(fileURLWithPath: "")
        do {
            try url = urls.first!.appendingPathComponent("data.plist")
        } catch  {
            print(error.localizedDescription)
        }
        return url!
    }

}

