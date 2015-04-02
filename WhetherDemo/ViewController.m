//
//  ViewController.m
//  WhetherDemo
//
//  Created by Nanostuffs's Macbook on 02/04/15.
//  Copyright (c) 2015 Nanostuffs. All rights reserved.
//

#import "ViewController.h"
#import "whetherController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.hidden=YES;
    self.navigationController.navigationBar.hidden=YES;
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)whetherBtnClicked:(id)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"seguetowhether"])
    {
        whetherController *obj=[segue destinationViewController];
        obj.cityName=_searchTxtField.text;
        
        NSUserDefaults *prefNew=[NSUserDefaults standardUserDefaults];
     
      
        obj.Citylattitude= [prefNew valueForKey:@"dropLocationLattitude"];

        obj.CityLongitude=[prefNew valueForKey:@"dropLocationLongitude"];
        
        
    }

}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.tableView.hidden=YES;
      return YES;
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
      NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=false&key=AIzaSyBciR-U00DJwwJSLSUg3nJ3H7Zir0XsUg4&components=",textField.text];//country:in
        
        NSDictionary *returndata = [self getJSONDictionary:urlString];
        
        NSDictionary *returndata1 = [returndata objectForKey:@"predictions"];
        NSArray *tweets = (NSArray *) returndata1;
        
        [PredictAddressarray removeAllObjects];
        [PredictReferencearray removeAllObjects];
        PredictAddressarray = nil;
        PredictReferencearray = nil;
        PredictAddressarray = [[NSMutableArray alloc] init];
        PredictReferencearray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [tweets count]; i++)
        {
            [PredictAddressarray addObject:[[tweets objectAtIndex:i] objectForKey:@"description"]];
            [PredictReferencearray addObject:[[tweets objectAtIndex:i] objectForKey:@"reference"]];
        }
        
        if ([PredictAddressarray count] > 0)
        {
            _tableView.hidden = NO;
            [_tableView reloadData];
        }
        else
        {
            _tableView.hidden = YES;
        }
    
    
    return YES;
    
}
- (NSDictionary *)getJSONDictionary : (NSString *) urlString
{
    NSError* error;
    NSDictionary*json;
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *Final_Url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:Final_Url] ;
    [request setValue:@"Basic Z2xvYnVzdXNlcjpHbDBidVMyMDE0" forHTTPHeaderField:@"Authorization"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (data)
        json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    else
        json = nil;
    
    return json;
}



# pragma args - Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return [PredictAddressarray count];
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 30;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UILabel *subview in subviews)
        [subview removeFromSuperview];
    subviews = nil;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    //    [backView release];
    
    UILabel *itemName = [[UILabel alloc] init];
    
    //    if (tableView == tablviewLocation)
    //    {
    itemName.frame = CGRectMake(5, 5,tableView.frame.size.width-10,20);
    itemName.text = [PredictAddressarray objectAtIndex:indexPath.row];
    //    }
    //    else
    //    {
    //        itemName.frame = CGRectMake(5, 0,tableView.frame.size.width-10, 30);
    //        itemName.text = [countriesarray objectAtIndex:indexPath.row];
    //    }
    
    [itemName setTextColor:[UIColor blackColor]];
    
    itemName.numberOfLines = 0;
    itemName.lineBreakMode = NSLineBreakByWordWrapping;
    
    itemName.textAlignment = NSTextAlignmentLeft;
    [itemName setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    itemName.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:itemName];
    itemName = nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _searchTxtField.text = [PredictAddressarray objectAtIndex:indexPath.row];
    
    tableView.hidden = TRUE;
    [self.view endEditing:YES];
    [self performSelectorInBackground:@selector(getLocationFromString:) withObject:_searchTxtField.text];
}


-(void)getLocationFromString:(NSString *)str
{
    //str=@"rajk";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder geocodeAddressString:str
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if (placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         
                         NSDictionary *addressDictionary =
                         placemark.addressDictionary;
                         
                         //self.txtAddress.text=[addressDictionary valueForKey:@"Name"];
                         CLLocation *location = placemark.location;
                         CLLocationCoordinate2D coordinate = location.coordinate;
                         NSLog(@"coordinate = (%f, %f)", coordinate.latitude, coordinate.longitude);
                         strForCurLatitude=[NSString stringWithFormat:@"%lf",coordinate.latitude];
                         strForCurLongitude=[NSString stringWithFormat:@"%lf",coordinate.longitude];
                         
                         
                         NSUserDefaults *prefNew=[NSUserDefaults standardUserDefaults];
                         [prefNew setObject:strForCurLatitude forKey:@"dropLocationLattitude"];
                         [prefNew setObject:strForCurLongitude forKey:@"dropLocationLongitude"];
                         [prefNew setObject:_searchTxtField.text forKey:@"dropLocationAddress"];
                         [prefNew synchronize];
                         
                         
                     }
                     
                 }];
}

@end
