//
//  ViewController.h
//  WhetherDemo
//
//  Created by Nanostuffs's Macbook on 02/04/15.
//  Copyright (c) 2015 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController
{
    NSMutableArray *PredictAddressarray;
    NSMutableArray *PredictReferencearray;
    NSString *strForCurLatitude,*strForCurLongitude;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;

@property (weak, nonatomic) IBOutlet UIButton *displayWhetherBtn;
- (IBAction)whetherBtnClicked:(id)sender;
@end
