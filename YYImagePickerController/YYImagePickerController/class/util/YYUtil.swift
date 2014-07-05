

import UIKit

class YYUtil: NSObject {
   
    func appDelegate()->UIApplicationDelegate{
        var del = UIApplication.sharedApplication().delegate
        return del
    }
}
