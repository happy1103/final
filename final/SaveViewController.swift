//
//  SaveViewController.swift
//  final
//
//  Created by User15 on 2019/1/7.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

var TitleList = [String]()
var TimeList = [String]()
var PictureList = [UIImage]()

class SaveViewController: UIViewController {
    
    var Title = ""
    var Time = ""
    var Picture = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        if Title != ""
        {
            TitleList.append(Title)
             TimeList.append(Time)
             PictureList.append(Picture)
        }
        
        print(TitleList)
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let controller = segue.destination as? MyTableViewController
        controller?.TitleList = TitleList
        controller?.TimeList = TimeList
        controller?.PictureList = PictureList
    }
    

}
