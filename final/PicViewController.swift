//
//  PicViewController.swift
//  final
//
//  Created by User15 on 2019/1/7.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class PicViewController: UIViewController {

    var Time = ""
    var Picture = UIImage()
    
    @IBOutlet weak var Pic: UIImageView!
    @IBOutlet weak var Timelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        Pic.image = Picture
        Timelabel.text = Time
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
