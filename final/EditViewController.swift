//
//  EditViewController.swift
//  final
//
//  Created by User15 on 2019/1/2.
//  Copyright © 2019 ee. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var fullSize = UIScreen.main.bounds.size
    //var anotherUIView :UIView!
    
    @IBOutlet weak var EditPicture: UIImageView!
    var pictureText = ""
    var Pictruein = UIImage()
    var Pictureout = UIImage()
    var isfromalbum = 0
    var nextImage = UIImage()
    
    var big = CGFloat(0.0)
    var imageView: UIImageView?
    var bgView: UIView?
    var imageView1: UIImageView?
    var startPoint: CGPoint!
    
    @IBOutlet weak var inBOX: UIImageView!
    @IBOutlet weak var MianView: UIView!
    @IBOutlet weak var anotherUIView: UIView!
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        self.view.addSubview(imageView!)
        
        if isfromalbum == 0
        {
            self.imageView?.image = Pictruein
        }
        else
        {
            //self.EditPicture.image = Pictruein
            self.imageView?.image = Pictruein
        }
        
        imageView?.isUserInteractionEnabled = true
        
        if Pictruein.size.width > Pictruein.size.height
        {
            big = CGFloat(width/Pictruein.size.width)
        }
        else
        {
            big = CGFloat(width/Pictruein.size.height)
        }
            
        imageView?.frame = CGRect(x: 0, y: 40, width: CGFloat(big*Pictruein.size.width), height: CGFloat(big*Pictruein.size.height))
        
        imageView1 = UIImageView()
        self.view.addSubview(imageView1!)
        imageView1!.frame = CGRect(x: 90, y: 300, width: 200, height: 200)
        
        //print(width/Pictruein.size.width)
        let doubleFingers =
            UITapGestureRecognizer(
                target:self,
                action:#selector(EditViewController.doubleTap(_:)))
        
        // 點幾下才觸發 設置 1 時 則是點一下會觸發 依此類推
        doubleFingers.numberOfTapsRequired = 1
        
        // 幾根指頭觸發
        doubleFingers.numberOfTouchesRequired = 2
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(doubleFingers)
        
        
        // 單指輕點
        let singleFinger = UITapGestureRecognizer(
            target:self,
            action:#selector(EditViewController.singleTap(_:)))
        
        // 點幾下才觸發 設置 2 時 則是要點兩下才會觸發 依此類推
        singleFinger.numberOfTapsRequired = 2
        
        // 幾根指頭觸發
        singleFinger.numberOfTouchesRequired = 1
        
        // 雙指輕點沒有觸發時 才會檢測此手勢 以免手勢被蓋過
        singleFinger.require(toFail: doubleFingers)
        self.view.addGestureRecognizer(singleFinger)
        
        // 拖曳手勢
        let pan = UIPanGestureRecognizer(
            target:self,
            action:#selector(EditViewController.pan(_:)))
        
        
        // 最少可以用幾指拖曳
        pan.minimumNumberOfTouches = 1
        
        // 最多可以用幾指拖曳
        pan.maximumNumberOfTouches = 1
        anotherUIView.addGestureRecognizer(pan)
        
        
        let pinch = UIPinchGestureRecognizer(target:self,action:#selector(EditViewController.pinch(_:)))
        
        self.view.addGestureRecognizer(pinch)
        
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(EditViewController.rotation(_:)))
        
        self.view.addGestureRecognizer(rotation)
        
        // Do any additional setup after loading the view.
        
        
        let pan2 = UIPanGestureRecognizer(target: self, action: #selector(panTouch(startPan:)))
        imageView?.addGestureRecognizer(pan2)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        isfromalbum = 0
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? TitleViewController
        controller?.Pictureout = nextImage
    }
    
    // 觸發拖曳手勢後 執行的動作
    @objc func pan(_ recognizer:UIPanGestureRecognizer) {
        // 設置 UIView 新的位置
        let point = recognizer.location(in: self.view)
        anotherUIView.center = point
    }
    
    // 觸發單指輕點兩下手勢後 執行的動作
    @objc func singleTap(_ recognizer:UITapGestureRecognizer){
        print("單指連點兩下時觸發")
        
        // 取得每指的位置
        self.findFingersPositon(recognizer)
    }
    
    // 觸發雙指輕點一下手勢後 執行的動作
    @objc func doubleTap(_ recognizer:UITapGestureRecognizer){
        print("雙指點一下時觸發")
        
        // 取得每指的位置
        self.findFingersPositon(recognizer)
    }
    
    func findFingersPositon(_ recognizer:UITapGestureRecognizer) {
        // 取得每指的位置
        let number = recognizer.numberOfTouches
        for i in 0..<number {
            let point = recognizer.location(
                ofTouch: i, in: recognizer.view)
            print(
                "第 \(i + 1) 指的位置：\(NSCoder.string(for: point))")
        }
    }
    
    // 觸發旋轉手勢後 執行的動作
    @objc func rotation(_ recognizer:UIRotationGestureRecognizer) {
        // 弧度
        let radian = recognizer.rotation
        
        // 旋轉的弧度轉換為角度
        let angle = radian * (180 / CGFloat(Double.pi))
        
        anotherUIView.transform = CGAffineTransform(rotationAngle: radian)
        
        print("旋轉角度： \(angle)")
    }
    
    // 觸發縮放手勢後 執行的動作
    @objc func pinch(_ recognizer:UIPinchGestureRecognizer) {
        if recognizer.state == .began {
            print("開始縮放")
        } else if recognizer.state == .changed {
            // 圖片原尺寸
            let frm = anotherUIView.frame
            
            //let frm = Pictruein.frame
            
            // 縮放比例
            let scale = recognizer.scale
            
            // 目前圖片寬度
            let w = frm.width
            
            // 目前圖片高度
            let h = frm.height
            
            // 縮放比例的限制為 0.5 ~ 2 倍
            if w * scale > 100 && w * scale < 400 {
                anotherUIView.frame = CGRect(x: frm.origin.x, y: frm.origin.y, width: w * scale, height: h * scale)
            }
        } else if recognizer.state == .ended {
            print("結束縮放")
        }
        
    }
    
    //(https://itisjoe.gitbooks.io/swiftgo/content/uikit/uigesturerecognizer.html)
    

    @IBAction func CutPicture(_ sender: Any) {
        
    }
    
    var tmpic = UIImage()
    
    let height = (UIScreen.main.bounds.size.height)
    let width = UIScreen.main.bounds.size.width
    
    func setBgView() {
        if bgView == nil {
            bgView = UIView()
        }
        imageView1!.removeFromSuperview()
        self.view.addSubview(bgView!)
        bgView?.backgroundColor = UIColor.black
        bgView?.alpha = 0.7
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func panTouch(startPan: UIPanGestureRecognizer) {
        let shotPan = startPan.location(in: imageView)
        print(shotPan)
        self.setBgView()
        if startPan.state == .began {
            self.startPoint = shotPan
        } else if startPan.state == .changed {
            let X = startPoint.x
            let Y = startPoint.y
            let W = shotPan.x - startPoint.x
            let H = shotPan.y - startPoint.y
            let rect = CGRect(x: X, y: Y, width: W, height: H)
            bgView?.frame = rect
        } else if startPan.state == .ended {
            
            nextImage = DDGManage.share.shotImage(imageView: imageView, bgView: bgView)!
            
            tmpic = DDGManage.share.shotImage(imageView: imageView, bgView: bgView)!
            bgView?.removeFromSuperview()
            nextImage = tmpic
            //inBOX.image = nextImage
            bgView = nil
            imageView1!.image = tmpic
            self.view.addSubview(imageView1!)
            //imageView1?.backgroundColor = UIColor.black
            imageView1!.frame = CGRect(x: 80, y: CGFloat(big*Pictruein.size.height)+20, width: CGFloat(big*Pictruein.size.width)*0.6, height: CGFloat((big*Pictruein.size.height)+40)*0.6)
        }
    }
}
