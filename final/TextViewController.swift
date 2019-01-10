//
//  TextViewController.swift
//  final
//
//  Created by User15 on 2019/1/3.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var TextEnter: UITextField!
    @IBOutlet weak var TextColor: UISlider!
    @IBOutlet weak var TextSize: UISlider!
    @IBOutlet weak var TextTest: UILabel!
    @IBOutlet weak var EnterText: UIButton!
    
    var Pictureout = UIImage()
    var red = CGFloat(0)
    var green = CGFloat(0)
    var blue = CGFloat(0)
    var Size = CGFloat(20)
    var Style = 0
    
    var FinalTitleText = ""
    var FinalTitlered = CGFloat(0)
    var FinalTitlegreen = CGFloat(0)
    var FinalTitleblue = CGFloat(0)
    var FinalTitleSize = CGFloat(20)
    var FinalTitleStyle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TextEnter.delegate = self
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let countOfWords = string.characters.count + textField.text!.characters.count - range.length
        
        if countOfWords > 40{
            return false
        }
        return true
    }

    @IBAction func TextChange(_ sender: UISlider) {
        if sender == TextColor{
            
            let redpoint = CGFloat(Double.random(in: 0.0...1.0))
            let greenpoint = CGFloat(Double.random(in: 0.0...1.0))
            let bluepoint = CGFloat(Double.random(in: 0.0...1.0))
            
            TextTest.textColor = UIColor(red: CGFloat(redpoint), green: CGFloat(greenpoint), blue: CGFloat(bluepoint), alpha: CGFloat(1.0))
            red = redpoint
            green = greenpoint
            blue = bluepoint
        }
        if sender == TextSize{
            TextTest.font = UIFont.systemFont(ofSize: CGFloat(TextSize.value))
            Size = CGFloat(TextSize.value)
        }
    }
    @IBAction func Entertext(_ sender: Any) {
        TextTest.text = TextEnter.text
        if TextEnter.text?.isEmpty == true{
            
            let alertController = UIAlertController(title: "注意！", message: "沒有輸入內文", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? PictureViewController
        controller?.Finaltext = TextTest.text ?? ""
        controller?.Finalred = red
        controller?.Finalgreen = green
        controller?.Finalblue = blue
        controller?.FinalSize = Size
        //controller?.FinalTitleStyle = Style
        controller?.Pictureout = Pictureout
        
        controller?.FinalTitleText = FinalTitleText 
        controller?.FinalTitlered = FinalTitlered
        controller?.FinalTitlegreen = FinalTitlegreen
        controller?.FinalTitleblue = FinalTitleblue
        controller?.FinalTitleSize = FinalTitleSize
        controller?.FinalTitleStyle = FinalTitleStyle
        
    }
 
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditViewController
        controller?.pictureText = URLtext.text ?? urlStr1
    }*/

}
