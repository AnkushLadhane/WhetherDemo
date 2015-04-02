//
//  whetherController.h
//  WhetherDemo
//
//  Created by Nanostuffs's Macbook on 02/04/15.
//  Copyright (c) 2015 Nanostuffs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface whetherController : UIViewController
{
    UIAlertView *loadingAlert;
    
    NSMutableArray *mainArray;
    
}
@property (weak, nonatomic) IBOutlet UITableView *whetherTableView;
- (IBAction)backBtnClicked:(id)sender;


@property (nonatomic,retain)NSString *cityName;
@property (nonatomic,retain)NSString *Citylattitude;
@property (nonatomic,retain)NSString *CityLongitude;

@end
