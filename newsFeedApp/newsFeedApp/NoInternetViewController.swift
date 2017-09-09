//
//  NoInternetViewController.swift
//  newsFeedApp
//
//  Created by Pedro  Apolloni on 08/09/17.
//  Copyright © 2017 Pedro  Apolloni. All rights reserved.
//

import UIKit

class NoInternetViewController: UIViewController {
    
    func testInternet(){
        if(Connectivity.isConnectedToInternet == true){
            let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "Feed")
            self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        // Do any additional setup after loading the view.
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
