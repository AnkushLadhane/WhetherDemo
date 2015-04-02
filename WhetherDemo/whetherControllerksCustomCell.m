//
//  gradeMarksCustomCell.m
//  SchoolApp
//
//  Created by Nanostuffs's Macbook on 27/01/15.
//  Copyright (c) 2015 Nanostuffs. All rights reserved.
//

#import "whetherControllerCustomCell.h"
#define IPHONE_LBL_FONT_SIZE 15.0
@implementation whetherControllerCustomCell


@synthesize  dayLbl;
@synthesize dayLblTxt;

@synthesize description1;
@synthesize descriptionTxt;

@synthesize pressure;
@synthesize pressureTxt;

@synthesize date1;
@synthesize dateTxt;

@synthesize humidity;
@synthesize humidityTxt;

@synthesize speed;
@synthesize speedTxt;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"studentinfobg.png"]];
        
        CGFloat cellheight=145/2;
        CGFloat cellWidth=320;  //iphone
       
        CGFloat imgH_n_w=cellheight-15;  //10 above n below
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            imgH_n_w=cellheight-25;
        }
        
               //name
        date1=[[UILabel alloc] init];
        date1.frame=CGRectMake(5,5,100,25); //
        date1.backgroundColor=[UIColor clearColor];
        date1.textAlignment=NSTextAlignmentLeft;
        date1.textColor=[UIColor blackColor];
        date1.text=@"Date";
        date1.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
       
        [self.contentView addSubview:date1];
        

        dateTxt=[[UILabel alloc] init];
        dateTxt.frame=CGRectMake(120,5,100,25); //
        dateTxt.backgroundColor=[UIColor clearColor];
        dateTxt.textAlignment=NSTextAlignmentLeft;
        dateTxt.textColor=[UIColor blackColor];
        dateTxt.text=@"";
        dateTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        
        [self.contentView addSubview:dateTxt];
        //Humidity
    
        humidity=[[UILabel alloc] init];
        humidity.frame=CGRectMake(5,dateTxt.frame.origin.y+dateTxt.frame.size.height+5,213/2,56/2);
      
        humidity.backgroundColor=[UIColor clearColor];
        humidity.textAlignment=NSTextAlignmentLeft;
        humidity.textColor=[UIColor blackColor];
        humidity.text=@"Humidity";
        humidity.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:humidity];
        
        humidityTxt=[[UILabel alloc] init];
        
        
        humidityTxt.frame=CGRectMake(120,dateTxt.frame.origin.y+dateTxt.frame.size.height+5,213/2,56/2);
        
        humidityTxt.backgroundColor=[UIColor clearColor];
        humidityTxt.textAlignment=NSTextAlignmentLeft;
        humidityTxt.textColor=[UIColor blackColor];
        humidityTxt.text=@"";
        humidityTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:humidityTxt];
        
        //Description
        
        description1=[[UILabel alloc] init];
        description1.frame=CGRectMake(5,humidity.frame.origin.y+humidity.frame.size.height+5,213/2,56/2);
        
        description1.backgroundColor=[UIColor clearColor];
        description1.textAlignment=NSTextAlignmentLeft;
        description1.textColor=[UIColor blackColor];
        description1.text=@"Description";
        description1.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:description1];
        
        descriptionTxt=[[UILabel alloc] init];
        
        
        descriptionTxt.frame=CGRectMake(120,humidity.frame.origin.y+humidity.frame.size.height+5,213,56/2);
        
        descriptionTxt.backgroundColor=[UIColor clearColor];
        descriptionTxt.textAlignment=NSTextAlignmentLeft;
        descriptionTxt.textColor=[UIColor blackColor];
        descriptionTxt.text=@"";
        descriptionTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:descriptionTxt];

        //Pressure
        
        pressure=[[UILabel alloc] init];
        pressure.frame=CGRectMake(5,descriptionTxt.frame.origin.y+descriptionTxt.frame.size.height+5,213/2,56/2);
        
        pressure.backgroundColor=[UIColor clearColor];
        pressure.textAlignment=NSTextAlignmentLeft;
        pressure.textColor=[UIColor blackColor];
        pressure.text=@"Pressure";
        pressure.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:pressure];
        
        pressureTxt=[[UILabel alloc] init];
       
        pressureTxt.frame=CGRectMake(120,descriptionTxt.frame.origin.y+descriptionTxt.frame.size.height+5,213,56/2);
        
        pressureTxt.backgroundColor=[UIColor clearColor];
        pressureTxt.textAlignment=NSTextAlignmentLeft;
        pressureTxt.textColor=[UIColor blackColor];
        pressureTxt.text=@"";
        pressureTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:pressureTxt];
        
        //Day
        
        dayLbl=[[UILabel alloc] init];
        dayLbl.frame=CGRectMake(5,pressure.frame.origin.y+pressure.frame.size.height+5,213/2,56/2);
        
        dayLbl.backgroundColor=[UIColor clearColor];
        dayLbl.textAlignment=NSTextAlignmentLeft;
        dayLbl.textColor=[UIColor blackColor];
        dayLbl.text=@"Day";
        dayLbl.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:dayLbl];
        
        dayLblTxt=[[UILabel alloc] init];
        
        dayLblTxt.frame=CGRectMake(120,pressure.frame.origin.y+pressure.frame.size.height+5,213,56/2);
        
        dayLblTxt.backgroundColor=[UIColor clearColor];
        dayLblTxt.textAlignment=NSTextAlignmentLeft;
        dayLblTxt.textColor=[UIColor blackColor];
        dayLblTxt.text=@"";
        dayLblTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:dayLblTxt];
        
        
        //Speed
        
        speed=[[UILabel alloc] init];
        speed.frame=CGRectMake(5,dayLbl.frame.origin.y+dayLbl.frame.size.height+5,213/2,56/2);
        
        speed.backgroundColor=[UIColor clearColor];
        speed.textAlignment=NSTextAlignmentLeft;
        speed.textColor=[UIColor blackColor];
        speed.text=@"Speed";
        speed.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:speed];
        
        speedTxt=[[UILabel alloc] init];
        
        speedTxt.frame=CGRectMake(120,dayLbl.frame.origin.y+dayLbl.frame.size.height+5,213,56/2);
        
        speedTxt.backgroundColor=[UIColor clearColor];
        speedTxt.textAlignment=NSTextAlignmentLeft;
        speedTxt.textColor=[UIColor blackColor];
        speedTxt.text=@"";
        speedTxt.font=[UIFont systemFontOfSize:IPHONE_LBL_FONT_SIZE];
        [self.contentView addSubview:speedTxt];
        
        CGFloat lbsFontSize=14.0;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            lbsFontSize=18.0;
        }
        
   

        
        //sign in lbl

        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end