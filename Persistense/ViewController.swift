//
//  ViewController.swift
//  Persistense
//
//  Created by Admin on 11.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate static let rootKey = "rootKey"
    
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
            let data = NSMutableData(contentsOf: fileURL)
            do {
                if let unarchiver = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) {
                    let fourLines = unarchiver as! FourLines
                    if let newLines = fourLines.lines {
                        for i in 0..<newLines.count {
                            lineFields[i].text = newLines[i]
                        }
                    }

                }
            } catch  {
                print("blya!!!")
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    @objc func applicationWillResignActive(notification: Notification) {
        let fileURL = dataFileURL()
        let fourLines = FourLines()
        let array = (lineFields as NSArray).value(forKey: "text") as! [String]
        //array.write(to: fileURL, atomically: true)
        fourLines.lines = array
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: fourLines, requiringSecureCoding: false)
            try data.write(to: fileURL)
        } catch  {
            print("не смогли сформировать архив((((")
        }
    }

    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url: URL?
        url = URL(fileURLWithPath: "")
//        do {
//            try url = urls.first!.appendingPathComponent("data.archive")
//        } catch  {
//            print(error.localizedDescription)
//        }
        url = urls.first!.appendingPathComponent("data.archive")
        return url!
    }

}

