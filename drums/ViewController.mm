//
//  ViewController.m
//  drums
//
//  Created by John Fowler on 3/26/13.
//  Copyright (c) 2013 John Fowler. All rights reserved.
//
// http://arivibes.com/realtime-audio-on-ios-tutorial-making-a-mandolin/
// http://abletonlife.com/learning-drum-synthesis-with-abletons-operator
//
// http://www.phy.mtu.edu/~suits/notefreqs.html
// http://www.pearldrummersforum.com/showthread.php?195170-Drum-Tuning-Notes-Pitches-Intervals
// http://soundprogramming.net/file_formats/general_midi_drum_note_numbers
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <dispatch/dispatch.h>

#import "mo_audio.h"

#define SRATE 44100
#define FRAMESIZE 128
#define NUMCHANNELS 2

void audioCallback( Float32 * buffer, UInt32 framesize, void* userData )
{
  AudioData * data = (AudioData*) userData;
  
  for(int i=0; i<framesize; i++)
  {
    SAMPLE out = data->myDrum1->tick();
    
    buffer[2*i] = buffer[2*i+1] = out;
  }
}

@interface ViewController ()

@end

@implementation ViewController

@synthesize drum1;
@synthesize drum2;
@synthesize drum3;
@synthesize drum4;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  
  audioData.myDrum1 = new Drummer();
//  audioData.myDrum1->setFrequency(400);
  
  // init audio
  NSLog(@"Initializing Audio");
  
  // init the MoAudio layer
  bool result = MoAudio::init(SRATE, FRAMESIZE, NUMCHANNELS);
  
  if (!result)
  {
    NSLog(@"cannot initialize real-time audio!");
    return;
  }
  
  // start the audio layer, registering a callback method
  result = MoAudio::start( audioCallback, &audioData);
  if (!result)
  {
    NSLog(@"cannot start real-time audio!");
    return;
  }
  
}

/**
 *     
 "dope.raw",
 "bassdrum.raw",
 "snardrum.raw",
 "tomlowdr.raw",
 "tommiddr.raw",
 "tomhidrm.raw",
 "hihatcym.raw",
 "ridecymb.raw",
 "crashcym.raw",
 "cowbell1.raw",
 "tambourn.raw"
 */

-(IBAction)drum1Hit:(id)sender {

  audioData.myDrum1->noteOn(1, 1.0);
  
  audioData.myDrum1->noteOff(0.75);
}

-(IBAction)drum2Hit:(id)sender {
  audioData.myDrum1->noteOn(2, 1.0);

  audioData.myDrum1->noteOff(0.75);
}

-(IBAction)drum3Hit:(id)sender {
  audioData.myDrum1->noteOn(3, 1.0);
  
  audioData.myDrum1->noteOff(0.75);
}

-(IBAction)drum4Hit:(id)sender {
  audioData.myDrum1->noteOn(4, 1.0);
  
  audioData.myDrum1->noteOff(0.75);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
