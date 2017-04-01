//
//  PublicUsersViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class PublicUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {

    @IBOutlet weak var queueTableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        self.getUsers()
    }
    
    func getUsers() {
        
        let url = URL(string: "https://iron-pong.herokuapp.com/API/users")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for dictionary in json {
                let name = dictionary["nickName"] as! String
                let user = User()
                user.name = name
                self.users.append(user)
            }
            DispatchQueue.main.async {
                self.queueTableView.reloadData()
            }
            }.resume()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PublicUserCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        // Configure the cell...
        
        return cell
    }

}
