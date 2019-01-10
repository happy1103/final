//
//  InternetPicViewController.swift
//  final
//
//  Created by User15 on 2019/1/2.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class InternetPicViewController: UIViewController {

    @IBOutlet weak var URLtext: UITextField!
    @IBOutlet weak var StartEdit: UIButton!
    @IBOutlet weak var Download: UIButton!
    @IBOutlet weak var testImg: UIImageView!
    let urlStr1 = "https://wakelandtheatre.files.wordpress.com/2013/11/final-poster.jpg"
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        StartEdit.isEnabled = false

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        StartEdit.isEnabled = false
    }

    @IBAction func GetPicture(_ sender: Any) {
        if URLtext.text?.isEmpty == true{
            
            let alertController = UIAlertController(title: "注意！", message: "請輸入網址", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            let urlStr = URLtext.text
            
            if let url = URL(string: urlStr ?? urlStr1) {
                let task = URLSession.shared.dataTask(with: url) {(data, response , error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.testImg.image = image
                        }
                        print("get image")
                    }
                }
                task.resume()
            }
            StartEdit.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditViewController
        controller?.Pictruein = testImg.image!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var result = true
        if URLtext.text?.isEmpty == true{
            result = false
            
            let alertController = UIAlertController(title: "注意！", message: "請輸入網址", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        return result
    }
    /*
    // MARK: - Navigation
*/
 

}
