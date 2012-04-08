//
//  ViewController.m
//  MemoryLeaks
//
//  Created by Yahoo on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (IBAction)open {
    
    SecondViewController *s = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    [self.navigationController pushViewController:s animated:YES];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"key1", @"key2", @"key3", nil];
    NSArray *objs = [[NSArray alloc] initWithObjects:@"obj1", @"obj2", @"obj3", nil];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
    
    NSLog(@"Dictionary %@",dictionary);
}

@end
