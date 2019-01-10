//
//  PictureViewController.swift
//  final
//
//  Created by User15 on 2019/1/3.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    var data : Data?
    
    var CIFilterNames = [
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone"
    ]
    
    
    @IBOutlet weak var FinalTitle: UILabel!
    @IBOutlet weak var FinalText: UILabel!
    @IBOutlet weak var FinalPicture: UIImageView!
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var snapshotView: UIView!
    @IBOutlet weak var ChangeFrame: UIButton!
    @IBOutlet weak var imgtest: UIImageView!
    @IBOutlet weak var Frame: UIImageView!
    var shareImage = UIImage()
    
    @IBOutlet weak var Fliter: UISegmentedControl!
    var FinalTitleText = ""
    var FinalTitlered = CGFloat(0)
    var FinalTitlegreen = CGFloat(0)
    var FinalTitleblue = CGFloat(0)
    var FinalTitleSize = CGFloat(20)
    var FinalTitleStyle = 0
    
    @IBOutlet weak var filtersScrollView: UIScrollView!
    var pictureText = ""
    var Pictureout = UIImage()
    
    var Finaltext = ""
    var Finalred = CGFloat(0)
    var Finalgreen = CGFloat(0)
    var Finalblue = CGFloat(0)
    var FinalSize = CGFloat(20)
    //var FinalTitleStyle = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        FinalText.text = Finaltext
        FinalText.textColor = UIColor(red: Finalred, green: Finalgreen, blue: Finalblue, alpha: CGFloat(1.0))
        FinalText.font = UIFont.systemFont(ofSize: FinalSize)
        
        FinalTitle.text = FinalTitleText
        FinalTitle.textColor = UIColor(red: FinalTitlered, green: FinalTitlegreen, blue: FinalTitleblue, alpha: CGFloat(1.0))
        FinalTitle.font = UIFont.systemFont(ofSize: FinalTitleSize)
        
        if FinalTitleStyle == 1 {
            FinalTitle.font = UIFont.boldSystemFont(ofSize: FinalTitleSize)
        }
        if FinalTitleStyle == 2 {
            FinalTitle.font = UIFont.italicSystemFont(ofSize: FinalTitleSize)
        }
        
        FinalPicture.image = Pictureout
        print(FinalTitleText)
        
        /*TitleList.append(Finaltext)
        TimeList.append(Time)
        PictureList.append(Pictureout)*/
        // Do any additional setup after loading the view.
        
        var xCoord: CGFloat = 5
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 70
        let buttonHeight: CGFloat = 70
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        
        for i in 0..<CIFilterNames.count {
            itemCount = i
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord,y:  yCoord, width: buttonWidth,height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(PictureViewController.filterButtonTapped(_:)), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: FinalPicture.image!)
            let filter = CIFilter(name: "\(CIFilterNames[i])" )
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
            let imageForButton = UIImage(cgImage: filteredImageRef!)
            filterButton.setBackgroundImage(imageForButton, for: [])
            xCoord +=  buttonWidth + gapBetweenButtons
            filtersScrollView.addSubview(filterButton)
        }
        filtersScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount+2),height: yCoord)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        let button = sender as UIButton
        
        FinalPicture.image = button.backgroundImage(for: [])
    }
    
    @IBAction func SavePicture(_ picker: UIImagePickerController) {
        UIGraphicsBeginImageContextWithOptions(snapshotView.frame.size, true, 0)
        snapshotView.drawHierarchy(in: snapshotView.bounds, afterScreenUpdates: true)
        shareImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //UIImageWriteToSavedPhotosAlbum(shareImage, nil, nil, nil)
        //UIImageWriteToSavedPhotosAlbum(shareImage!, nil, nil, nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let time = formatter.string(from: now)
        
        let Time = time
        
        let controller = segue.destination as? SaveViewController
        controller?.Title = FinalTitleText
        controller?.Time = Time
        controller?.Picture = shareImage
        
        /*data = Data(Title: Title, Time: Time)
        controller?.data = Data(Title: Title, Time: Time)
        controller?.Picture = shareImage*/
    }
    

    @IBAction func PublicPIc(_ sender: Any) {
    UIGraphicsBeginImageContextWithOptions(snapshotView.frame.size, true, 0)
        snapshotView.drawHierarchy(in: snapshotView.bounds, afterScreenUpdates: true)
        let shareImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [shareImage!], applicationActivities: [])
        activityViewController.excludedActivityTypes = [.assignToContact, .addToReadingList, .openInIBooks, .markupAsPDF, .postToVimeo, .postToWeibo, .postToFlickr, .postToTwitter]
        
        self.present(activityViewController, animated: true, completion: nil)
        
        // MARK: Activity Controller Completion Handler with Alert
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if !completed {
                // handle task not completed
                print(error ?? "user canceled sharing")
                return
            }
            let activityText: [String] = (activity?.rawValue.components(separatedBy: "."))!
            let controller = UIAlertController(title: "Successed!", message: "Successfully shared by \"\(activityText[activityText.count - 1])\"", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func FrameCharge(_ sender: Any) {
        let point = Int.random(in: 0...8)
        Frame.image = UIImage(named: String(point))
    }
    /*https://www.google.com/search?biw=1341&bih=832&tbm=isch&sa=1&ei=hXs1XPDzH8Kc8QXonp_oDw&q=%E6%8B%8D%E7%AB%8B%E5%BE%97+%E6%A1%86&oq=%E6%8B%8D%E7%AB%8B%E5%BE%97+%E6%A1%86&gs_l=img.3..0j0i24.26056.27986..28243...0.0..0.32.268.10......0....1..gws-wiz-img.......0i7i30.dcYq83Qo08k#imgdii=dSXlG489kkGMQM:&imgrc=cSWxFJC0Q4sSDM:
     
     https://developer.apple.com/documentation/coreimage/processing_an_image_using_built-in_filters
     
     https://ios.devdon.com/archives/1036
     */
    var name = "無特效"
    @IBAction func ReStart(_ sender: Any) {
        FinalTitleText = ""
    }
    @IBAction func ChooseFliter(_ sender: UISegmentedControl) {
        name = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        if name == "黑白" {
            
        }
        if name == "模糊" {
            
        }
        if name == "清晰" {
            
        }
        if name == "老舊" {
            
        }
        if name == "無特效" {
           
        }
    }
}
