

import UIKit
import AssetsLibrary

class YYImageDataSourceView: UIView,UITableViewDataSource,UITableViewDelegate {

    var dataTypeButton:UIButton!
    var dataSourceArray:NSMutableArray = NSMutableArray()
    var dismissBlock:()->() = {()->() in}
    var completeBlock:()->() = {()->() in}
    
    var backgroundView:UIButton!
    var tableView:UITableView!
    
    var _title:String!
    var title:String!{
    set{
        self._title = newValue
        if self.dataTypeButton{
            self.dataTypeButton.setTitle(" \(newValue)", forState: UIControlState.Normal)
        }
    }
    get{
        return self._title
    }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = mochaColorGreen
        
        self.dataTypeButton = UIButton(frame:CGRectMake(0, 0, 200, dataSourceViewHeight))
        self.dataTypeButton.setImage(UIImage(named:"show"), forState: UIControlState.Normal)
        self.dataTypeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.dataTypeButton.addTarget(self, action: "selectDataSouce", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.dataTypeButton)
        
        var sepLineView = UIView(frame:CGRectMake(frame.size.width-2*dataSourceViewHeight, 0, 0.5, dataSourceViewHeight))
        sepLineView.backgroundColor = UIColor.whiteColor()
        self.addSubview(sepLineView)
        
        var dismissButton = UIButton(frame:CGRectMake(frame.size.width-dataSourceViewHeight, 0, dataSourceViewHeight, dataSourceViewHeight))
        dismissButton.setImage(UIImage(named:"close"), forState: UIControlState.Normal)
        dismissButton.addTarget(self, action: "closeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(dismissButton)
        
        var checkButton = UIButton(frame:CGRectMake(frame.size.width-2*dataSourceViewHeight, 0, dataSourceViewHeight, dataSourceViewHeight))
        checkButton.setImage(UIImage(named:"check"), forState: UIControlState.Normal)
        checkButton.addTarget(self, action: "checkButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(checkButton)
        
        self.initData()
    }

    func initData(){
        YYAssetHelper.sharedAssetHelper().getGroupList({(array:NSArray)->Void in
            self.dataSourceArray.removeAllObjects()
            self.dataSourceArray.addObjectsFromArray(array)
            if self.dataSourceArray.count > 0{
                var group = self.dataSourceArray.objectAtIndex(0) as ALAssetsGroup
                self.title = group.valueForProperty(ALAssetsGroupPropertyName) as String
            }
            })
    }
    
    func selectDataSouce(){
        let tableViewHeight:Float = 200
        if !self.superview{
            return
        }
        if !self.backgroundView {
            self.backgroundView = UIButton(frame:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height-dataSourceViewHeight))
            self.backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.backgroundView.addTarget(self, action: "didSelectDataSource", forControlEvents: UIControlEvents.TouchUpInside)
            self.superview.addSubview(self.backgroundView)
        }
        
        if !self.tableView{
            self.tableView = UITableView(frame:CGRectMake(0, self.backgroundView.frame.size.height-tableViewHeight, self.backgroundView.frame.size.width, tableViewHeight))
            self.tableView.backgroundColor = UIColor.whiteColor()
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.backgroundView.addSubview(self.tableView)
        }
        
        self.backgroundView.alpha = 0
        var frame = self.tableView.frame
        frame.origin.y = self.backgroundView.frame.size.height
        self.tableView.frame = frame
        frame.origin.y = self.backgroundView.frame.size.height-tableViewHeight
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = frame
            self.backgroundView.alpha = 1
            }, completion: {(_)->Void in
            })
    }
    
    func closeButtonClick(){
        self.dismissBlock()
    }
    
    func checkButtonClick(){
        self.completeBlock()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return dataSourceArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            var selectView = UIView()
            selectView.backgroundColor = mochaColorGreen
            cell.selectedBackgroundView = selectView
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        self.didSelectDataSource()
    }
    
    func didSelectDataSource(){
        var frame = self.tableView.frame
        frame.origin.y = self.backgroundView.frame.size.height
        UIView.animateWithDuration(0.3, animations: {
            self.tableView.frame = frame
            self.backgroundView.alpha = 0
            }, completion: {(_)->Void in
            })
    }
    
}
