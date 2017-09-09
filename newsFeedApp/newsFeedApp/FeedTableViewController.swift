//
//  FeedTableViewController.swift
//  newsFeedApp
//
//  Created by Pedro  Apolloni on 31/08/17.
//  Copyright © 2017 Pedro  Apolloni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage
import SVProgressHUD




class FeedTableViewController: UITableViewController {

    var feedHashSelected = ""
    var arrRes = [[String:AnyObject]]() //Array of dictionary

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        

        // ------- Connectivity -------------
        
        
        if(Connectivity.isConnectedToInternet == false){
            let alert = UIAlertController(title: "Aviso", message: "Conecte-se a Internet para o usar o aplicativo!", preferredStyle: .alert)
            
            
            let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "noInternet")
                self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else{
            print("Conectado")
        }
        
        
        
        
        // ---- REQUEST -----
        
        SVProgressHUD.show(withStatus: "Carregando")
        Alamofire.request("http://api.tecnonutri.com.br/api/v4/feed?" ).responseJSON { (responseData) -> Void in
//            print("Request: \(response.request)")
//            print("Response: \(response.response)")
//            print("Error: \(response.error)")
            if((responseData.result.value) != nil) {
              //  print(responseData)
                let swiftyJsonVar = JSON(responseData.result.value!)
               // print(swiftyJsonVar)
                if let resData = swiftyJsonVar["items"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    print(resData)
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
            SVProgressHUD.dismiss()
        }

        
        
        
        // ---- FIM REQUEST -----
        
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "feedCell")! as! FeedTableViewCell
        
        var dict = arrRes[(indexPath as NSIndexPath).row]
        
            cell.profileName.text = dict["profile"]?["name"] as? String
            cell.profileName.font = UIFont.boldSystemFont(ofSize: 16.0)
            let goal = dict["profile"]?["general_goal"] as? String
            let obj = "Meta: " + goal!
            cell.objetivo.text = obj
            cell.objetivo.textColor = UIColor.orange
            let stringRefeicao = "Refeição de "
            let stringDataRefeicao = dict["date"] as? String
            cell.dataRefeicao.text = stringRefeicao + stringDataRefeicao!
            let caloriasString = String(dict["energy"] as! Float)
            cell.calorias.text = "KCal: " + caloriasString
           
        
        let profileURL = dict["profile"]?["image"] as? String
        
        // ------ RADIUS -------
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
        cell.profileImage.clipsToBounds = true
        

        
        
        if (profileURL == nil){
            cell.profileImage.image = UIImage(named: "profileImageDefault")
        }
        else{
            let url = dict["profile"]?["image"] as! String
            cell.profileImage.yy_imageURL = NSURL(string: url)! as URL

        }
        let imagemPost = dict["image"] as! String

        cell.postImage.yy_setImage(with: NSURL(string: imagemPost)! as URL, placeholder: UIImage(named: "place"), options: .progressive)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRes.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        
         var dict = arrRes[(indexPath as NSIndexPath).row]["feedHash"] as! String
         print(dict)
         feedHashSelected = dict
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        
        
        
        self.performSegue(withIdentifier: "goToDetalhes", sender: self)

        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetalhes" {
        let viewController = segue.destination as! DetalhesViewController
        viewController.feedHash = (self.feedHashSelected)
        }
    }

}
