//
//  DetalhesViewController.swift
//  newsFeedApp
//
//  Created by Pedro  Apolloni on 07/09/17.
//  Copyright © 2017 Pedro  Apolloni. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage
import SVProgressHUD

class DetalhesViewController: UIViewController {

    @IBOutlet weak var nomeDetalhes: UILabel!
    
    @IBOutlet weak var goalDetalhes: UILabel!
    
    @IBOutlet weak var profileImageDetalhes: UIImageView!
    
    @IBOutlet weak var postImageDetalhes: UIImageView!
    
    
    var feedHash = ""
    @IBOutlet weak var alimento: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://api.tecnonutri.com.br/api/v4/feed/"+feedHash
        print(url)
        
        SVProgressHUD.show(withStatus: "Carregando")
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                let resData = swiftyJsonVar["item"]
                print(resData)
                self.nomeDetalhes.text = resData["profile"]["name"].string
                self.nomeDetalhes.font = UIFont.boldSystemFont(ofSize: 16.0)
                let goal =  resData["profile"]["general_goal"].string
                let obj = "Meta: " + goal!
                self.goalDetalhes.text = obj
                self.goalDetalhes.textColor = UIColor.orange
                let imagemUrl = NSURL(string: resData["image"].string!)! as URL
                self.postImageDetalhes.yy_setImage(with: imagemUrl, options: .progressiveBlur)
                
                var nomeComida = resData["comment"].string
                
                if (nomeComida == nil){
                    nomeComida = "Alimento"
                }
                else{
                self.alimento.text = nomeComida
                }
                let stringURL = resData["profile"]["image"]
                if (stringURL == JSON.null){
                    self.profileImageDetalhes.image = UIImage(named: ("profileImageDefault"))!                }
                else{
                    let urlProfile = resData["profile"]["image"].string
                    
                    self.profileImageDetalhes.layer.cornerRadius = self.profileImageDetalhes.frame.width/2;
                    self.profileImageDetalhes.clipsToBounds = true
                    
                     self.profileImageDetalhes.yy_imageURL = NSURL(string: urlProfile!)!as URL
                }
            
                    
                }
                SVProgressHUD.dismiss()
                
                
            }
        
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
