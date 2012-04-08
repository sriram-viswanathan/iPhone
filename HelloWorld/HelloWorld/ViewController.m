//
//  ViewController.m
//  HelloWorld
//
//  Created by Yahoo on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    myLabel.text = @"Hello World!";
    
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.font = [UIFont fontWithName:@"Zapfino" size:20.0];
    
    [self.view addSubview:myLabel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
