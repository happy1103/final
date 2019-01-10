//
//  TitleViewController.swift
//  final
//
//  Created by User15 on 2019/1/3.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var TitleEnter: UITextField!
    @IBOutlet weak var Titlecolor: UISlider!
    @IBOutlet weak var TitleSize: UISlider!
    @IBOutlet weak var TitleStyle: UISegmentedControl!
    @IBOutlet weak var TitleTest: UILabel!
    @IBOutlet weak var EnterTitle: UIButton!
    @IBOutlet weak var Nextbutton: UIButton!
    
    var Pictureout = UIImage()
    var Titlered = CGFloat(0)
    var Titlegreen = CGFloat(0)
    var Titleblue = CGFloat(0)
    var Titlesize = CGFloat(20)
    var Titlestyle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.TitleEnter.delegate = self
        Nextbutton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let countOfWords = string.characters.count + textField.text!.characters.count - range.length
        
        if countOfWords > 10{
            return false
        }
        return true
    }
    @IBAction func TitleColorChange(_ sender: UISlider) {
        if sender == Titlecolor{
            
            let redpoint = CGFloat(Double.random(in: 0.0...1.0))
            let greenpoint = CGFloat(Double.random(in: 0.0...1.0))
            let bluepoint = CGFloat(Double.random(in: 0.0...1.0))
            
            TitleTest.textColor = UIColor(red: CGFloat(redpoint), green: CGFloat(greenpoint), blue: CGFloat(bluepoint), alpha: CGFloat(1.0))
            Titlered = redpoint
            Titlegreen = greenpoint
            Titleblue = bluepoint
            
        }
        if sender == TitleSize{
            TitleTest.font = UIFont.systemFont(ofSize: CGFloat(TitleSize.value))
            Titlesize = CGFloat(TitleSize.value)
        }
    }
    var name = "無效果"
    @IBAction func TitleStyleChoose(_ sender: UISegmentedControl) {
        name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        if name == "粗體" {
            TitleTest.font = UIFont.boldSystemFont(ofSize: Titlesize)
            Titlestyle = 1
        }
        if name == "斜體" {
            TitleTest.font = UIFont.italicSystemFont(ofSize: Titlesize)
            Titlestyle = 2
        }
        if name == "無效果" {
            TitleTest.font = UIFont.systemFont(ofSize: CGFloat(TitleSize.value))
            Titlestyle = 0
        }
        print(TitleSize)
    }
    @IBAction func EnterTitleBnt(_ sender: Any) {
        TitleTest.text = TitleEnter.text
        if TitleEnter.text?.isEmpty == true{
            
            let alertController = UIAlertController(title: "注意！", message: "沒有輸入標題", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        Nextbutton.isEnabled = true
    }
    @IBAction func Next(_ sender: Any) {
        if TitleEnter.text?.isEmpty == true{
            
            let alertController = UIAlertController(title: "注意！", message: "沒有輸入標題", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? TextViewController
        controller?.FinalTitleText = TitleTest.text ?? ""
        controller?.FinalTitlered = Titlered
        controller?.FinalTitlegreen = Titlegreen
        controller?.FinalTitleblue = Titleblue
        controller?.FinalTitleSize = Titlesize
        controller?.FinalTitleStyle = Titlestyle
        controller?.Pictureout = Pictureout
        
    }

}
