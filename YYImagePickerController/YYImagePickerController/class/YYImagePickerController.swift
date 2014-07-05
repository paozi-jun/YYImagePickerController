

import UIKit

let mochaColorGreen = UIColor(red: 0x96/255.0, green: 0xc8/255.0, blue: 0x60/255.0, alpha: 1)
let dataSourceViewHeight:Float = 50

class YYImagePickerController: UIViewController {
    
    var dataSourceView:YYImageDataSourceView!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSourceView = YYImageDataSourceView(frame:CGRectMake(0,self.view.frame.size.height-dataSourceViewHeight,self.view.frame.size.width,dataSourceViewHeight))
        self.view.addSubview(self.dataSourceView)
        self.dataSourceView.title = "这是一个例子"
        self.dataSourceView.dismissBlock = {()->() in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.dataSourceView.completeBlock = {()->() in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
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
