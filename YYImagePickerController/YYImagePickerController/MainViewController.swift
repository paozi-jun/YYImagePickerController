

import UIKit

class MainViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var showBt = UIButton(frame:CGRectMake(0, 100, 320, 100))
        showBt.setTitleColor(mochaColorGreen, forState: UIControlState.Normal)
        showBt.setTitle("show", forState: UIControlState.Normal)
        showBt.addTarget(self, action: "show", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(showBt)
    }

    func show(){
        var imagePickerVC = YYImagePickerController()
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
        imagePickerVC.numberOfRow = 4
        imagePickerVC.completeBlock = {(array:NSArray)->Void in
            println("\(array.count)")
        }
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
