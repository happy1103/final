
import UIKit
import ObjectiveC

class DDGManage: NSObject {
    static var share = DDGManage()
    public func composeImageWithLogo( bgImage: UIImage,
                                      imageRect: [CGRect],
                                      images:[UIImage]) -> UIImage {
       
        let imageRef = bgImage.cgImage
        let w: CGFloat = CGFloat((imageRef?.width)!)
        let h: CGFloat = CGFloat((imageRef?.height)!)
        
        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
        bgImage.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        
        for i in 0..<images.count {
            images[i].draw(in: CGRect(x: imageRect[i].origin.x,
                                      y: imageRect[i].origin.y,
                                      width: imageRect[i].size.width,
                                      height:imageRect[i].size.height))
        }
        
        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImg!
    }
    
    
    public func tailoringImage(_ image: UIImage) -> UIImage? {
        
        UIGraphicsBeginImageContext((image.size))
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: (image.size.width),
                                               height: (image.size.height)))
        
        path.addClip()
        
        image.draw(at: CGPoint.zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public  func async_tailoringImage(_ image: UIImage,completed:@escaping (UIImage?) -> ()) {
        
        DispatchQueue.global().async{
            let newImage = self.tailoringImage(image)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
    public func tailoringImage(_ image: UIImage,withRadius radius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContext((image.size))
        let path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                    y: 0,
                                                    width: (image.size.width),
                                                    height: (image.size.height)), cornerRadius: radius)
        
        path.addClip()
        image.draw(at: CGPoint.zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func async_tailoringImage(_ image: UIImage,withRadius radius: CGFloat,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.tailoringImage(image, withRadius: radius)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }

    public func tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ) -> UIImage? {
        
        let imageSize = CGSize(width: image.size.width + width * 2 , height: image.size.height + width * 2)
        UIGraphicsBeginImageContext(imageSize)
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: imageSize.width,
                                               height: imageSize.height))
        
        color.set()
        path.fill()
        let clipPath = UIBezierPath(ovalIn: CGRect(x: width, y: width, width: image.size.width, height: image.size.height))
        clipPath.addClip()
        image.draw(at: CGPoint(x: width, y: width))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return  newImage
    }
  
    public func async_tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.tailoringImageLayer(image, borderWidth: width, borderColor: color)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
    public func shotImage(image: UIImage?,byFrame frame: CGRect?) -> UIImage? {
        if image == nil {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions((image?.size)!, false, 0.0)
        let path = UIBezierPath(rect: frame!)
        path.addClip()
        image?.draw(at: CGPoint.zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func async_shotImage(image: UIImage?,byFrame frame: CGRect?,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.shotImage(image: image, byFrame: frame)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
 
    public func shotImage(imageView: UIImageView?,bgView: UIView?) -> UIImage? {
        if imageView == nil {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions((imageView?.bounds.size)!, false, 0.0)
        let path = UIBezierPath(rect: (bgView?.frame)!)
        path.addClip()
        let imgectx = UIGraphicsGetCurrentContext()
        imageView?.layer.render(in: imgectx!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func async_shotImage(imageView: UIImageView?,bgView: UIView?,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.shotImage(imageView: imageView, bgView: bgView)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
    public func clearImage(imageView: UIImageView?, rect: CGRect) -> UIImage? {
        if imageView == nil {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions((imageView?.bounds.size)!, false, 0.0)
        let imageCtx = UIGraphicsGetCurrentContext()
        imageView?.layer.render(in: imageCtx!)
        imageCtx!.clear(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func imageFilterHandel(image: UIImage, filterName: String) -> UIImage? {
        
        let inputImage = CIImage(image: image)
        let filter = CIFilter(name: filterName)
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage =  filter?.outputImage!
        let context: CIContext = CIContext(options: nil)
        let cgImage = context.createCGImage(outputImage!, from: (outputImage?.extent)!)
        let newImage = UIImage(cgImage: cgImage!)
        return newImage
    }
    
    public func async_imageFilterHandel(image: UIImage, filterName: String,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = self.imageFilterHandel(image: image, filterName: filterName)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
    
}

extension UIImage {
    
    public func composeImageWithLogo( logo: UIImage,
                                      logoOrigin: CGPoint,
                                      logoSize:CGSize) -> UIImage {
        let imageRef = self.cgImage
        let w: CGFloat = CGFloat((imageRef?.width)!)
        let h: CGFloat = CGFloat((imageRef?.height)!)
        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
        self.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
        logo.draw(in: CGRect(x: logoOrigin.x,
                             y: logoOrigin.y,
                             width: logoSize.width,
                             height:logoSize.height))
        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImg!
    }
}

