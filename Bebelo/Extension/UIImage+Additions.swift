//
//  UIImage+Additions.swift
//  TradeAir
//
//  Created by Adeel on 19/09/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit

class UIImage_Additions: NSObject {
    
}
extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIImage {
    
    //    public func urlToImage(urlString: String) -> UIImage{
    //
    //        let url = NSURL(string: Variables.SERVER_IP + "/" + urlString)
    //        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
    //        return  UIImage(data: data!)!
    //
    //    }
    //
    //    public func absoluteURL(ImageUrl: String) -> NSURL{
    //
    //        let profileImageUrl = Variables.SERVER_IP + "/" + ImageUrl
    //
    //        return NSURL(string: profileImageUrl)!
    //
    //    }
    
    var rounded: UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(size.height/2, size.width/2)
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleToFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    //    func compressImage(imageUrl:String)-> UIImage {
    //        let imagenew:UIImage = UIImage().urlToImage(imageUrl)
    //        return UIImage.compressImage(imagenew, compressRatio:0.9)
    //    }
    func RBSquareImageTo(_ image: UIImage, size: CGSize) -> UIImage? {
        return RBResizeImage(RBSquareImage(image), targetSize: size)
    }
    
    func RBSquareImage(_ image: UIImage) -> UIImage? {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRect(x: posX, y: posY, width: edge, height: edge)
        
        let imageRef = image.cgImage?.cropping(to: cropSquare);
        return UIImage(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
    
    func RBResizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
        if let image = image {
            let size = image.size
            
            let widthRatio  = targetSize.width  / image.size.width
            let heightRatio = targetSize.height / image.size.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        } else {
            return nil
        }
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func drawImagesAndText(_ string:String) -> UIImage{
        // 1
        let renderer = UIGraphicsImageRenderer(size: self.size)

        let img = renderer.image { ctx in
            // 2
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            

            // 3
            var attrs: [NSAttributedString.Key: Any]!
            if string.count > 3{
            attrs = [
                .font: UIFont(name: Constant.robotoBFont, size: 10) ?? UIFont.systemFont(ofSize: 10),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.black
            ]
            }
            else if string.count > 4{
                attrs = [
                    .font: UIFont(name: Constant.robotoBFont, size: 8) ?? UIFont.systemFont(ofSize: 8),
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: UIColor.black
                ]
            }
            else if string.count > 5{
                attrs = [
                    .font: UIFont(name: Constant.robotoBFont, size: 6) ?? UIFont.systemFont(ofSize: 6),
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: UIColor.black
                ]
            }
            else{
                attrs = [
                    .font: UIFont(name: Constant.robotoBFont, size: 13) ?? UIFont.systemFont(ofSize: 13),
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: UIColor.black
                ]
            }
            let attributedString = NSAttributedString(string: string, attributes: attrs)

            // 5
            let mouse = self
            mouse.draw(in: CGRect(origin: .zero, size: self.size))
            attributedString.draw(in: CGRect(origin: .zero, size: self.size))
            
            // 5
            
        }
        return img
    }
    func drawImagesAndText1(_ string: String,isEvent:Bool = false,isSelect:Bool = false) -> UIImage {
        
        var textFontAttributes: [NSAttributedString.Key: Any]!
        var point:CGPoint!
        if isSelect {
            if string.count > 5{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 10) ?? UIFont.systemFont(ofSize: 6),
                    .foregroundColor: UIColor.white
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/3, y: self.size.height/3)
                }
                else{
                    point = CGPoint(x: self.size.width/7.4, y: self.size.height/3.2)
                }
            }
            else if string.count > 4{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 11) ?? UIFont.systemFont(ofSize: 8),
                    .foregroundColor: UIColor.white
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.8, y: self.size.height/2.8)
                }
                else{
                    point = CGPoint(x: self.size.width/6.8, y: self.size.height/3.5)
                }
            }
            else if string.count > 3{
                textFontAttributes = [
                .font: UIFont(name: Constant.robotoBFont, size: 12) ?? UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.white
            ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.4, y: self.size.height/2.4)
                }
                else{
                    point = CGPoint(x: self.size.width/6.5, y: self.size.height/4)
                }
            }
            else if string.count > 2{
                textFontAttributes = [
                .font: UIFont(name: Constant.robotoBFont, size: 13) ?? UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.white
            ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.8, y: self.size.height/2.8)
                }
                else{
                    point = CGPoint(x: self.size.width/6.5, y: self.size.height/4.4)
                }
            }
            else{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 14) ?? UIFont.systemFont(ofSize: 13),
                    .foregroundColor: UIColor.white
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.8, y: self.size.height/2.8)
                }
                else{
                    point = CGPoint(x: self.size.width/3.8, y: self.size.height/5)

                }
                       
            }
        }
        else{
            if string.count > 5{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 8) ?? UIFont.systemFont(ofSize: 6),
                    .foregroundColor: UIColor.black
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.4, y: self.size.height/2.3)
                }
                else{
                    point = CGPoint(x: self.size.width/4.5, y: self.size.height/3.2)
                }
            }
            else if string.count > 4{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 9) ?? UIFont.systemFont(ofSize: 8),
                    .foregroundColor: UIColor.black
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.4, y: self.size.height/2.35)
                }
                else{
                    point = CGPoint(x: self.size.width/4.8, y: self.size.height/3.5)
                }
            }
            else if string.count > 3{
                textFontAttributes = [
                .font: UIFont(name: Constant.robotoBFont, size: 10) ?? UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.black
            ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.4, y: self.size.height/2.4)
                }
                else{
                    point = CGPoint(x: self.size.width/7, y: self.size.height/4)
                }
            }
            else if string.count > 2{
                textFontAttributes = [
                .font: UIFont(name: Constant.robotoBFont, size: 11) ?? UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.black
            ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.4, y: self.size.height/2.4)
                }
                else{
                    point = CGPoint(x: self.size.width/7.2, y: self.size.height/4.4)
                }
            }
            else{
                textFontAttributes = [
                    .font: UIFont(name: Constant.robotoBFont, size: 12) ?? UIFont.systemFont(ofSize: 13),
                    .foregroundColor: UIColor.black
                ]
                if isEvent{
                    point = CGPoint(x: self.size.width/2.3, y: self.size.height/2.4)
                }
                else{
                    point = CGPoint(x: self.size.width/4.2, y: self.size.height/5)

                }
                       
            }
        }
        

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

        let rect = CGRect(origin: point, size: self.size)
        string.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func drawImages() -> UIImage {

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
