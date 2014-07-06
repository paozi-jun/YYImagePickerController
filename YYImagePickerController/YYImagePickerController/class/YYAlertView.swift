
import UIKit
import QuartzCore

let kTitleYOffset:Float = 15.0
let kTitleHeight:Float = 25.0

let kContentOffset:Float = 30.0
let kBetweenLabelOffset:Float = 20.0

class YYAlertView: UIView {

    let kAlertWidth:Float = 245.0
    let kAlertHeight:Float = 160.0
    
    var leftBlock = {()->() in }
    var rightBlock = {()->() in }
    var dismissBlock = {()->() in }
    
    var leftLeave:Bool?
    var alertTitleLabel:UILabel?
    var alertContentLabel:UILabel?
    var leftBtn:UIButton?
    var rightBtn:UIButton?
    var backImageView:UIView?
    
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title:NSString,content:NSString,leftTitle:NSString?,rightTitle:NSString){
        super.init(frame:CGRectZero)
        
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.whiteColor()
        self.alertTitleLabel = UILabel(frame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight))
        self.alertTitleLabel!.font = UIFont.boldSystemFontOfSize(20.0)
        self.alertTitleLabel!.textColor = UIColor(red:56.0/255.0,green:64.0/255.0,blue:71.0/255.0,alpha:1)
        self.addSubview(self.alertTitleLabel)
        
        var contentLabelWidth = kAlertWidth - 16
        self.alertContentLabel = UILabel(frame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel!.frame), contentLabelWidth, 60))
        self.alertContentLabel!.numberOfLines = 0
        self.alertContentLabel!.textAlignment = NSTextAlignment.Center
        self.alertTitleLabel!.textAlignment = NSTextAlignment.Center
        self.alertContentLabel!.textColor = UIColor(red:127.0/255.0,green:127.0/255.0,blue:127.0/255.0,alpha:1)
        self.alertContentLabel!.font = UIFont.systemFontOfSize(15.0)
        self.addSubview(self.alertContentLabel)
        
        var leftBtnFrame:CGRect!
        var rightBtnFrame:CGRect!
        let kSingleButtonWidth:Float = 160.0
        let kCoupleButtonWidth:Float = 107.0
        let kButtonHeight:Float = 40.0
        let kButtonBottomOffset:Float = 10.0
        
        if leftTitle {
            leftBtnFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame) + kButtonBottomOffset, kAlertHeight - kButtonBottomOffset - kButtonHeight, kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = UIButton(frame:leftBtnFrame);
            self.leftBtn!.setBackgroundImage(YYAlertView.imageWithColor(UIColor(red:227.0/255.0,green:100.0/255.0,blue:83.0/255.0,alpha:1)) ,forState:UIControlState.Normal)
            self.leftBtn!.setTitle(leftTitle, forState: UIControlState.Normal)
            self.leftBtn!.titleLabel!.font = UIFont.boldSystemFontOfSize(14)
            self.leftBtn!.setTitleColor(UIColor.whiteColor(),forState:UIControlState.Normal)
            self.leftBtn!.addTarget(self, action: "leftBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
            self.leftBtn!.layer!.masksToBounds = true
            self.addSubview(self.leftBtn)
            self.leftBtn!.layer.masksToBounds = true
            self.leftBtn!.layer!.cornerRadius = 3.0
            
            self.rightBtn = UIButton(frame:rightBtnFrame)
        }else {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth, kButtonHeight);
            self.rightBtn = UIButton(frame: rightBtnFrame)
            self.rightBtn!.frame = rightBtnFrame;
        }
        
        self.rightBtn!.setBackgroundImage(YYAlertView.imageWithColor(UIColor(red:87.0/255.0,green:135.0/255.0,blue:173.0/255.0,alpha:1)) ,forState:UIControlState.Normal)
        self.rightBtn!.setTitle(rightTitle, forState: UIControlState.Normal)
        self.rightBtn!.titleLabel!.font = UIFont.boldSystemFontOfSize(14)
        self.rightBtn!.setTitleColor(UIColor.whiteColor(),forState:UIControlState.Normal)
        self.rightBtn!.addTarget(self, action: "rightBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.rightBtn!.layer.masksToBounds = true
        self.rightBtn!.layer!.cornerRadius = 3.0
        self.addSubview(self.rightBtn)
        
        self.alertTitleLabel!.text = title
        self.alertContentLabel!.text = content
        
        var xButton = UIButton(frame:CGRectMake(kAlertWidth - 32, 0, 32, 32))
        xButton.setImage(UIImage(named:"btn_close_normal.png"),forState:UIControlState.Normal)
        xButton.setImage(UIImage(named:"btn_close_selected.png"),forState:UIControlState.Highlighted)
        self.addSubview(xButton)
        xButton.addTarget(self, action: "dismissAlert", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func leftBtnClicked(){
        self.leftLeave = true
        self.dismissAlert()
        self.leftBlock()
    }
    
    func rightBtnClicked(){
        self.leftLeave = false
        self.dismissAlert()
        self.rightBlock()
    }
    
    func show(){
        var window = UIApplication.sharedApplication().keyWindow
        self.frame = CGRectMake((CGRectGetWidth(window.bounds) - self.kAlertWidth) * 0.5, -self.kAlertHeight - 30, self.kAlertWidth, self.kAlertHeight)
        window.addSubview(self)
    }

    
    func dismissAlert(){
        self.dismissBlock()
        
        if self.backImageView {
            self.backImageView!.removeFromSuperview()
            self.backImageView = nil
        }
        UIView.animateWithDuration(0.3, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.alpha = 0
            }, completion: {(_)->Void in
                
            })
    }
    
    override func willMoveToSuperview(newSuperview: UIView!)
    {
        if newSuperview {
            var shareWindow = UIApplication.sharedApplication().keyWindow
            
            if !self.backImageView {
                self.backImageView = UIView(frame:shareWindow.bounds)
                self.backImageView!.userInteractionEnabled = true
                self.backImageView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissAlert"))
            }
            self.backImageView!.backgroundColor = UIColor.blackColor()
            self.backImageView!.alpha = 0.6
            shareWindow.addSubview(self.backImageView)
            
            self.frame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(shareWindow.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
            self.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(0.35, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.transform = CGAffineTransformMakeScale(1.2,1.2)
                }, completion: {(_)->Void in
                    UIView.animateWithDuration(0.1, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
                        self.transform = CGAffineTransformMakeScale(1,1)
                        }, completion: {(_)->Void in
                        })
                })
        }
        
    }
    
    class func imageWithColor(color:UIColor)->UIImage{
        var rect = CGRectMake(0.0,0.0,1.0,1.0)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context,color.CGColor)
        CGContextFillRect(context, rect)
    
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return image
    }
}
