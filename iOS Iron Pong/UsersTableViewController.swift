//
//  UsersTableViewController.swift
//  iOS Iron Pong
//
//  Created by Hayden Goldman on 3/31/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   UINavigationBar.appearance().tintColor = UIColor.white
        showUsers ()
    }
    
    func showUsers () {
        
        let url = URL(string: "https://iron-pong.herokuapp.com/API/users")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            let usersDictionaries = try! JSONSerialization.jsonObject(with: data!, options:[]) as! [[String:Any]]
            
            for userDictionary in usersDictionaries {
                
                let claimed = userDictionary["claimed"] as! Bool
                
                if claimed == true {
                    
                    
                    let userId = userDictionary["_id"] as! String
                    let userNickName = userDictionary["nickName"] as! String
                    var userScore = 0.0
                    if (userDictionary["wins"] != nil) {
                        userScore = userDictionary ["wins"] as! Double
                    }
                    var userLosses = 0.0
                    if (userDictionary["losses"] != nil) {
                        userLosses = userDictionary ["losses"] as!Double
                    }
                    var userWinStreak = 0.0
                    if (userDictionary["winStreak"] != nil) {
                        userWinStreak = userDictionary ["winStreak"] as! Double
                    }
                    var userWinRatio = 0.0
                    if (userDictionary["winRatio"] != nil) {
                        userWinRatio = userDictionary ["winStreak"] as! Double
                    }
                    
                    
                    var totalGames = 0.0
                    if (userDictionary["totalGames"] != nil) {
                        totalGames = userDictionary ["totalGames"] as! Double
                    }
                    
                    //
                    var avatarURL = " "
                    if (userDictionary ["avatarURL"] != nil){
                        avatarURL = userDictionary ["avatarURL"] as! String
                    }
                    var catchPhrase = " "
                    if (userDictionary ["catchPhrase"] != nil){
                        catchPhrase = userDictionary ["catchPhrase"] as! String
                    }
                    var paddleGripStyle = " "
                    if (userDictionary ["paddleGripStyle"] != nil){
                        paddleGripStyle = userDictionary ["paddleGripStyle"] as! String
                    }
                    var signatureMove = " "
                    if (userDictionary ["signatureMove"] != nil){
                        signatureMove = userDictionary ["signatureMove"] as! String
                    }
                    
                    var homeTown = " "
                    if (userDictionary ["homeTown"] != nil){
                        homeTown = userDictionary ["homeTown"] as! String
                    }
                    
                    
                    
                    let user = User(id: userId, nickName : userNickName, score :userScore, losses :userLosses, winStreak : userWinStreak, winRatio : userWinRatio, totalGames : totalGames, avatarURL : avatarURL, catchPhrase :catchPhrase, paddleGripStyle:paddleGripStyle,signatureMove:signatureMove, homeTown:homeTown)
                    
                    self.users.append(user)
                    
                    
                    
                }
                
                
                
                
            }
            
            self.users.sort(by: { $0.wins! > $1.wins!})
            
            
            DispatchQueue .main.async {
                self.tableView.reloadData()
            }
            } .resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath)
        
        let username = self.users[indexPath.row]
        
        cell.textLabel?.text = username.nickName
        cell.detailTextLabel?.text = "Wins: \(String(Int(username.wins!)))"
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserProfileSegue" {
            
            let userProfileVC = segue.destination as! UserProfileViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow
            
            userProfileVC.selectedUser = users[(indexPath?.row)!]
            
            
        }

    }
    
    
    
    
}
