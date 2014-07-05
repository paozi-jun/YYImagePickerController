

import UIKit
import AssetsLibrary

var _sharedInstance:YYAssetHelper!

class YYAssetHelper: NSObject {
    
    var assetsLibrary:ALAssetsLibrary!
    var assetGroups:NSMutableArray!
    var assetPhotos:NSMutableArray!
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
            
            if !group{
                result(self.assetGroups)
            }else{
                self.assetGroups.addObject(group)
            }
        }
        
        var assetGroupEnumberatorFailure = {(error:NSError!)->Void in
        }
        
        self.assetGroups = NSMutableArray()
        self.assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupType(ALAssetsGroupSavedPhotos), usingBlock: assetGroupEnumerator, failureBlock:assetGroupEnumberatorFailure)
    }
    
    func getPhotoListOfGroup(alGroup:ALAssetsGroup,result:(NSArray)->Void){
        self.initAsset()
        
        self.assetPhotos = NSMutableArray()
        //alGroup.setAssetsFilter(ALAssetsFilter.allPhotos())
        
        alGroup.enumerateAssetsUsingBlock({(alPhoto:ALAsset!, index:Int,stop: CMutablePointer<ObjCBool>) -> Void in
            if alPhoto == nil || !alPhoto{
                result(self.assetPhotos)
                return
            }else{
                self.assetPhotos.addObject(alPhoto)
            }
            })
    }
    
}
