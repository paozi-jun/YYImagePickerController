

import UIKit

class YYViewUtil: NSObject {
    
    class func imageWithColor(color:UIColor)->UIImage {
        var rect:CGRect = CGRectMake(0.0,0.0,1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
    
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
    
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return image
    }
    
    class func button4NavBaritem(title:String)->UIButton{
        var button = UIButton(frame:CGRectMake(0, 0, 60, 25))
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.titleLabel.font = UIFont.systemFontOfSize(13)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return button
    }
}
