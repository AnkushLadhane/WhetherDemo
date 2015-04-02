//
//  whetherController.m
//  WhetherDemo
//
//  Created by Nanostuffs's Macbook on 02/04/15.
//  Copyright (c) 2015 Nanostuffs. All rights reserved.
//

#import "whetherController.h"
#import "whetherControllerCustomCell.h"

@interface whetherController ()

@end

@implementation whetherController
@synthesize CityLongitude,Citylattitude,cityName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=NO;
    NSLog(@"cityName=%@ lattitude == %@ Longitude==%@",cityName,Citylattitude,CityLongitude);
    
    [self initializeArray];
    [self performSelector:@selector(getWhetherDetails) withObject:nil afterDelay:0.1];

    // Do any additional setup after loading the view.
}
-(void)initializeArray
{
    mainArray=[[NSMutableArray alloc]init];
}

-(void)getWhetherDetails
{
    
    loadingAlert=[[UIAlertView alloc]initWithTitle:@"Please wait..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil] ;
    [loadingAlert show];
    

    NSString *urlReqStr=[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%@&lon=%@&cnt=10&mode=json&APPID=d66cee1287a097952fd320927d784ad1",Citylattitude,CityLongitude] ;
    
    urlReqStr=[urlReqStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"l url %@",urlReqStr);
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlReqStr]];
    [request setHTTPMethod:@"POST"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
     {
         [loadingAlert dismissWithClickedButtonIndex:0 animated:YES];
         
         if(data)
         {
             [mainArray removeAllObjects];
             
             NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"login response: %@",json_string);
             
             //uisng nsjason serilaization:
             NSError *error;
             NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSLog(@"response: dict: %@",responseDict);
             
             NSArray *array = [responseDict objectForKey:@"list"];
             
             NSLog(@"response: array: %@",array);

             if([array count]!=0)
             {
                 for(int i=0;i<array.count ;i++)
                 {
                     
                
                 NSDictionary *array1 = [[responseDict objectForKey:@"list"] objectAtIndex:i];
                     
                     if([array1 count]!=0)
                     {
                         NSMutableDictionary *tempDict=[[NSMutableDictionary alloc] init];
                         
                         NSString *data=[NSString stringWithFormat:@"%@",[array1 objectForKey:@"dt"]];
                         if(data)
                         {
                             [tempDict setObject:data forKey:@"dt"];
                         }
                         
                         data=[NSString stringWithFormat:@"%@",[array1 objectForKey:@"humidity"]];
                         if(data)
                         {
                             [tempDict setObject:data forKey:@"humidity"];
                         }
                         
                         data=[NSString stringWithFormat:@"%@",[array1 objectForKey:@"speed"]];
                         if(data)
                         {
                             [tempDict setObject:data forKey:@"speed"];
                         }
                         
                         data=[NSString stringWithFormat:@"%@",[array1 objectForKey:@"pressure"]];
                         if(data)
                         {
                             [tempDict setObject:data forKey:@"pressure"];
                         }
                         
                            NSDictionary *array = [array1 objectForKey:@"temp"];
                       // NSLog(@"response: temp: %@",array);
                         
                        for(int i=0; i<array.count;i++)
                         {
                             NSString *data=[NSString stringWithFormat:@"%@",[array objectForKey:@"day"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"day"];
                             }
                             
                             data=[NSString stringWithFormat:@"%@",[array objectForKey:@"eve"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"eve"];
                             }
                             
                             data=[NSString stringWithFormat:@"%@",[array objectForKey:@"max"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"max"];
                             }
                             
                             data=[NSString stringWithFormat:@"%@",[array objectForKey:@"min"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"min"];
                             }
                             
                             data=[NSString stringWithFormat:@"%@",[array objectForKey:@"morn"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"morn"];
                             }
                             
                             data=[NSString stringWithFormat:@"%@",[array objectForKey:@"night"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"night"];
                             }
                         }
                       
                        
                         
                         NSDictionary *arraTemp = [[array1 objectForKey:@"weather"]objectAtIndex:0];
                         
                       for(int i=0; i<arraTemp.count;i++)
                         {
                             NSString *data=[NSString stringWithFormat:@"%@",[arraTemp objectForKey:@"description"]];
                             if(data)
                             {
                                 [tempDict setObject:data forKey:@"description"];
                             }
                             
                        }
                      
                       NSLog(@"response: weather: %@",arraTemp);
                        
                        [mainArray addObject:tempDict];
                         NSLog(@"MainArray== %@",mainArray);
                     }
                
                     
                    
                 }
                 
                 [_whetherTableView reloadData];
             }
             
             
         }
         
         else
         {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connection not available" message:@"Connection failed to load data. Please try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
             
         }
     }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma args - Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return mainArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    whetherControllerCustomCell *cell=(whetherControllerCustomCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil)
    {
        cell=[[whetherControllerCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    
    
    id str =[[mainArray objectAtIndex:indexPath.row] objectForKey:@"dt"];
    
 
    //[timeStampString stringByAppendingString:@"000"];   //convert to ms
    NSTimeInterval _interval=[str doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd/MM/yy"];
     NSString *str1=[_formatter stringFromDate:date];
  

   
    cell.dateTxt.text=str1;

   
    id hum=[[mainArray objectAtIndex:indexPath.row] objectForKey:@"humidity"];
     NSString *humi1=hum;
    
    cell.humidityTxt.text=humi1;
   
    cell.descriptionTxt.text=[[mainArray objectAtIndex:indexPath.row]objectForKey:@"description"];
    
    cell.pressureTxt.text=[[mainArray objectAtIndex:indexPath.row]objectForKey:@"pressure"];
    
    cell.dayLblTxt.text=[[mainArray objectAtIndex:indexPath.row]objectForKey:@"day"];
    
    cell.speedTxt.text=[[mainArray objectAtIndex:indexPath.row]objectForKey:@"speed"];
    
    CGFloat lbl_font_size=15.0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont systemFontOfSize:lbl_font_size];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
