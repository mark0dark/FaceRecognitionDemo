//
//  AJViewController.m
//  FaceRecognitionDemo
//
//  Created by Jianwen on 13-8-7.
//  Copyright (c) 2013年 Dark. All rights reserved.
//

#import "AJViewController.h"
#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>

@interface AJViewController ()

@end

@implementation AJViewController

-(void)setFacePhoto:(UIImageView*)photoImageView
{
    
    UIImage *image = [UIImage imageNamed:@"test.png"];
     if (image)
     {

         CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                   context:nil
                                                   options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyLow
                                                                                       forKey:CIDetectorAccuracy]];
         
         NSArray* features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
         for(CIFaceFeature* faceFeature in features)
         {
             CGRect origRect = faceFeature.bounds;
             CGRect biggerRect = CGRectInset(origRect
                                             ,origRect.size.width*-0.5
                                             ,origRect.size.height*-0.5);
             
             CGRect flipRect = biggerRect;
             flipRect.origin.y = image.size.height - (biggerRect.origin.y + biggerRect.size.height);
             flipRect.origin.y = flipRect.origin.y - 4;
             
             CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], flipRect);
             UIImage* faceImage = [UIImage imageWithCGImage:imageRef];
             CGImageRelease(imageRef);
             
             photoImageView.image = faceImage;
             
             break;
         }
     }
}

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize

{
    
    CGPoint saveCenter = roundedView.center;
    
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    
    roundedView.frame = newFrame;
    
    roundedView.layer.cornerRadius = newSize / 2.0;
    
    roundedView.center = saveCenter;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UILabel *firstInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 200, 20)];
    [firstInfoLab setBackgroundColor:[UIColor clearColor]];
    [firstInfoLab setFont:[UIFont systemFontOfSize:13.0]];
    [firstInfoLab setText:@"this is the faceRecognition demo"];
    [self.view addSubview:firstInfoLab];

    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 58, 58)];
    [faceImageView setBackgroundColor:[UIColor clearColor]];
    [faceImageView setImage:[UIImage imageNamed:@"default.png"]];   //default Image
    
    [self setFacePhoto:faceImageView];
    [self.view addSubview:faceImageView];
    
    UILabel *secondInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 200, 20)];
    [secondInfoLab setBackgroundColor:[UIColor clearColor]];
    [secondInfoLab setFont:[UIFont systemFontOfSize:13.0]];
    [secondInfoLab setText:@"this is the round view demo"];
    [self.view addSubview:secondInfoLab];
    
    UIImageView *faceAndRoundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 58, 58)];
    [faceAndRoundImageView setBackgroundColor:[UIColor clearColor]];
    [faceAndRoundImageView setImage:[UIImage imageNamed:@"default.png"]];
    [faceAndRoundImageView setClipsToBounds:YES];   //yes, it's importance
    [self setRoundedView:faceAndRoundImageView toDiameter:50.0];
    
    [self setFacePhoto:faceAndRoundImageView];
    [self.view addSubview:faceAndRoundImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
