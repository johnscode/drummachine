//
//  ViewController.h
//  drums
//
//  Created by John Fowler on 3/26/13.
//  Copyright (c) 2013 John Fowler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#include "Stk.h"
#include "Drummer.h"

using namespace stk;
struct AudioData{
	Drummer *myDrum1;
  Drummer *myDrum2;
  Drummer *myDrum3;
  Drummer *myDrum4;
};



@interface ViewController : UIViewController {

  struct AudioData audioData;
}

@property (nonatomic,retain) IBOutlet UIButton *drum1;
@property (nonatomic,retain) IBOutlet UIButton *drum2;
@property (nonatomic,retain) IBOutlet UIButton *drum3;
@property (nonatomic,retain) IBOutlet UIButton *drum4;

-(IBAction)drum1Hit:(id)sender;
-(IBAction)drum2Hit:(id)sender;
-(IBAction)drum3Hit:(id)sender;
-(IBAction)drum4Hit:(id)sender;

@end
