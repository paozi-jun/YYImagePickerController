YYImagePickerController
=======================

Swift 语言编写自定义控件 实现多选图片效果
代码会在这里停住
不知为何
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
