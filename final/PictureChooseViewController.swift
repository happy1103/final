//
//  PictureChooseViewController.swift
//  final
//
//  Created by User15 on 2019/1/2.
//  Copyright © 2019 ee. All rights reserved.
//
import UIKit

class PictureChooseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    struct PicName: Codable {
        var status: String
        var message: String
    }
    
    var imageView: UIImageView!
    @IBOutlet weak var PicPicked: UIImageView!
    @IBOutlet weak var start: UIButton!
    
    @IBOutlet weak var RandomPic: UIButton!
    @IBOutlet weak var PickAlbum: UIButton!
    let imagePicker = UIImagePickerController()
    
    var randomurl = ""
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = UIColor.white
        self.imagePicker.delegate = self
        PicPicked.image = UIImage(named: "封面")
        start.isEnabled = false
        RandomPic.isEnabled = false
        if let urlStr = "https://dog.ceo/api/breeds/image/random".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr)
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data, let PicName = try?
                    decoder.decode(PicName.self, from: data)
                {
                    print(PicName.message)
                    self.randomurl = PicName.message
                    
                } else {
                    print("error")
                }
            }
            task.resume()
        }
    }
    
    @IBAction func OPen(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    /// 開啟相簿
    ///
    /// - Parameter
    func callGetPhoneWithKind(_ kind: Int) {
        let picker: UIImagePickerController = UIImagePickerController()
        
        // 開啟相簿
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            picker.allowsEditing = true // 可對照片作編輯
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    // 相簿
    @objc func onPhotoBtnAction(_ sender: UIButton) {
        self.callGetPhoneWithKind(2)
    }
    
    // MARK: - Delegate
    // ---------------------------------------------------------------------
    /// 取得選取後的照片
    var a = UIImage()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil) // 關掉
        a = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        PicPicked.image = a
        //info[UIImagePickerController.InfoKey.originalImage] as? UIImage // 從Dictionary取出原始圖檔
        
        print(UIImagePickerController.InfoKey.originalImage)
        start.isEnabled = true
    }
    
    // 圖片picker控制器任務結束回呼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? EditViewController
        controller?.Pictruein = a
        controller?.isfromalbum = 1
    }
    @IBAction func randomPic(_ sender: Any) {
        if let urlStr = "https://dog.ceo/api/breeds/image/random".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr)
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data, let PicName = try?
                    decoder.decode(PicName.self, from: data)
                {
                    print(PicName.message)
                    self.randomurl = PicName.message
                    
                } else {
                    print("error")
                }
            }
            task.resume()
        }
        let urlStr = randomurl
        
        if let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) {(data, response , error) in
                if let data = data {
                    self.a = UIImage(data: data)!
                    DispatchQueue.main.async {
                        self.PicPicked.image = self.a
                    }
                }
            }
            task.resume()
            print("HAHA")
        }
       RandomPic.isEnabled = true
    }
}
