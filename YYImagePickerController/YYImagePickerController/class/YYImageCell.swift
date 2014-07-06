

import UIKit
import AssetsLibrary

class YYImageCell: UICollectionViewCell {

    var imageView:UIImageView!
    var selectView:UIView!
    var selectImageView:UIImageView!
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame:CGRectZero)
        self.addSubview(self.imageView)
        
        self.selectView = UIView(frame:CGRectZero)
        self.selectView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.addSubview(selectView)
        
        self.selectImageView = UIImageView(frame:CGRectZero)
        self.selectImageView.backgroundColor = mochaColorGreen
        self.selectImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.selectView.addSubview(self.selectImageView)
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.bounds
        self.selectView.frame = self.bounds
        
        var selectWidth = self.frame.size.width/5
        self.selectImageView.frame = CGRectMake(self.frame.size.width-selectWidth-5, self.frame.size.height-selectWidth-5, selectWidth, selectWidth)
        self.selectImageView.layer.cornerRadius = selectWidth/2
        self.selectImageView.layer.borderWidth = selectWidth/8
    }
    
    func update(image:YYImage){
        self.imageView.image = UIImage(CGImage: image.asset.thumbnail().takeUnretainedValue())
        self.selectView.hidden = !image.isSelect
    }
    
}
