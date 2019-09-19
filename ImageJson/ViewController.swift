//
//  ViewController.swift
//  ImageJson
//
//  Created by Becca Akinlaja on 9/9/19.
//  Copyright © 2019 Becca Akinlaja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return titleArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.titleText.text = titleArray[indexPath.row]
        cell.titleText.numberOfLines = 4
        
        do {
            let url = URL(string: imageArray[indexPath.row])
            let data = try Data(contentsOf: (url)!)
           cell.imageVIEW.image = UIImage(data: data)
        } catch {
            print(error)
        }
       
      return cell
    }
    
    var titleArray = [String]()
    var imageArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getJson()
    }

    
    func getJson()  {
        let stringUrl = "https://jsonplaceholder.typicode.com/photos"
        let url = URL(string: stringUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                print("returning error")
                return
            }
                guard let content = data else {
                print("cannot fetch data")
                return
            }
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [[String: Any]] else {
                print("Not containing Json")
                return
            }
           //print(json)
           // print(json[0]["title"]!)
            for i in 0 ..< json.count {
                self.titleArray.append(json[i]["title"] as! String)
                self.imageArray.append(json[i]["thumbnailUrl"] as! String)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        }
        task.resume()
    }

}

