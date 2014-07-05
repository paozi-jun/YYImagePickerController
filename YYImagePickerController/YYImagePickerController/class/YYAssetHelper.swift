

import UIKit
import AssetsLibrary

var _sharedInstance:YYAssetHelper!

class YYAssetHelper: NSObject {
    
    var assetsLibrary:ALAssetsLibrary!
    var assetGroups:NSMutableArray!
    var bReverse:Bool!
    
    class func sharedAssetHelper()->YYAssetHelper{
        if !_sharedInstance{
            _sharedInstance = YYAssetHelper()
            _sharedInstance.initAsset()
        }
        return _sharedInstance
    }
    
    func initAsset(){
        if !self.assetsLibrary{
            self.assetsLibrary = ALAssetsLibrary()
            
            var strVersion = UIDevice()
            self.assetsLibrary.writeImageToSavedPhotosAlbum(nil, metadata: nil, completionBlock: {(assetURL:NSURL!, error:NSError!) -> Void in})
        }
    }
    
    func getGroupList(result:(NSArray)->()){
        self.initAsset()
        
      
        var assetGroupEnumerator = {(group:ALAssetsGroup!, stop:CMutablePointer<ObjCBool>)->Void in
            group.setAssetsFilter(ALAssetsFilter.allPhotos())
            
            if !group{
                if self.bReverse{
                    self.assetGroups = NSMutableArray(array:self.assetGroups.reverseObjectEnumerator().allObjects)
                }
                result(self.assetGroups)
                return;
            }
            
            self.assetGroups.addObject(group)
        }
        
        var assetGroupEnumberatorFailure = {(error:NSError!)->Void in
        }
        
        self.assetGroups = NSMutableArray()
        self.assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupType(ALAssetsGroupAll), usingBlock: {(group:ALAssetsGroup!, stop:CMutablePointer<ObjCBool>)->Void in
            group.setAssetsFilter(ALAssetsFilter.allPhotos())
            
            if !group{
                if self.bReverse{
                    self.assetGroups = NSMutableArray(array:self.assetGroups.reverseObjectEnumerator().allObjects)
                }
                result(self.assetGroups)
                return;
            }
            
            self.assetGroups.addObject(group)
            }, failureBlock:assetGroupEnumberatorFailure)
    }
    
}
