

import UIKit
import AssetsLibrary

let mochaColorGreen = UIColor(red: 0x96/255.0, green: 0xc8/255.0, blue: 0x60/255.0, alpha: 1)
let dataSourceViewHeight:Float = 50

class YYImagePickerController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var dataSourceView:YYImageDataSourceView!
    
    var collectionView:UICollectionView!
    var imageDataArray:NSMutableArray!
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageDataArray = NSMutableArray()
        
        self.initCollectionView()
        
        
        self.dataSourceView = YYImageDataSourceView(frame:CGRectMake(0,self.view.frame.size.height-dataSourceViewHeight,self.view.frame.size.width,dataSourceViewHeight))
        self.view.addSubview(self.dataSourceView)
        
        self.dataSourceView.dismissBlock = {()->() in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.dataSourceView.completeBlock = {()->() in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.dataSourceView.selectGroupBlock = {(group:ALAssetsGroup)->Void in
            YYAssetHelper.sharedAssetHelper().getPhotoListOfGroup(group, result: {(array:NSArray) -> Void in
                self.imageDataArray.addObjectsFromArray(array)
                self.collectionView.reloadData()
                })
        }
    }

    func initCollectionView(){
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection =  UICollectionViewScrollDirection.Vertical
        self.collectionView = UICollectionView(frame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-dataSourceViewHeight-20),collectionViewLayout:flowLayout)
        self.collectionView.backgroundColor = UIColor.clearColor()
        //注册
        
        self.collectionView.registerClass(YYImageCell.self,forCellWithReuseIdentifier:"cell")
        //设置代理
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int{
        return self.imageDataArray.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!{
        var identify = "cell"
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identify,forIndexPath:indexPath) as YYImageCell
        cell.sizeToFit()
//        if (!cell) {
//            
//        }
        //    VideoModel *model = [self.videoModels objectAtIndex:indexPath.row];
        //    NSURL *url = [NSURL URLWithString:model.videoImgURL];
        //
        //    [cell.imgView setImageWithURL:url];
        //    cell.titleLbale.text = model.videoTitle;
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        var top = UIEdgeInsets(top: 5,left: 20,bottom: 5,right: 20)
        return top
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize{
        return CGSizeMake(80, 80)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
