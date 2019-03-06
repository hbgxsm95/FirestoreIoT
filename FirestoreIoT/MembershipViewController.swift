//
//  MembershipViewController.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit
import FirebaseUI
class MembershipViewController: UIViewController {

    @IBAction func membershipButton(_ sender: Any) {
        let auth = FUIAuth.defaultAuthUI()!
        auth.providers = []
        present(auth.authViewController(), animated: true, completion: nil)
    }
    
    @IBAction func nonMembershipButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showIdentifier", sender: Any?.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = FUIAuth.defaultAuthUI()!
        try? auth.signOut()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let auth = FUIAuth.defaultAuthUI()!
        if auth.auth?.currentUser == nil{
            // Don't do anything here
        } else{
            self.performSegue(withIdentifier: "showIdentifier", sender: Any?.self)
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
