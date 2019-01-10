//
//  FirstViewController.swift
//  final
//
//  Created by User15 on 2019/1/7.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var Title = ""
    var Time = ""
    var Picture = UIImage()

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as? SaveViewController
        controller?.Title = Title
        controller?.Time = Time
        controller?.Picture = Picture
    }
    

}
