

import UIKit
import AssetsLibrary

class YYImageCell: UICollectionViewCell {

    var imageView:UIImageView!
    var selectView:UIImageView!
    init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame:CGRectZero)
        self.addSubview(self.imageView)
        
        self.selectView = UIImageView(frame:CGRectZero)
        self.selectView.backgroundColor = mochaColorGreen
        self.selectView.layer.borderColor = UIColor.whiteColor().CGColor
        self.addSubview(self.selectView)
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.bounds
        
        var selectWidth = self.frame.size.width/5
        self.selectView.frame = CGRectMake(self.frame.size.width-selectWidth-5, self.frame.size.height-selectWidth-5, selectWidth, selectWidth)
        self.selectView.layer.cornerRadius = selectWidth/2
        self.selectView.layer.borderWidth = selectWidth/8
    }
    
    func update(image:YYImage){
        self.imageView.image = UIImage(CGImage: image.asset.thumbnail().takeUnretainedValue())
        self.selectView.hidden = !image.isSelect
    }
    
}
