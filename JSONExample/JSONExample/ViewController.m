//
//  ViewController.m
//  JSONExample
//
//  Created by Yahoo on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "JSON.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    responseData = [[NSMutableData data] retain];
    
    NSString *url = @"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20partner.cricket.albums%20where%20album_id%20%3D%20%2287398479-1371-3563-aec4-97453996906b%22%20and%20region%3D%22in%22&format=json&env=store%3A%2F%2FydEH9sBsu89t0cRAA07eBC&callback=";

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [responseData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"didReceiveData");
    [responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed with error %@", [error description]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    
    NSLog(@"didFinishLoading");
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    [responseData release];
    
    //NSLog(@"Response string is %@", responseString);
    
    SBJSON *sbjson = [[[SBJSON alloc] init] autorelease];
    
    NSError *error;
    NSDictionary *results = [sbjson objectWithString:responseString error:&error];
    
    NSMutableArray *photos = [results valueForKeyPath:@"query.results.PhotoAlbum.Photos.Photo"];
    
    //NSLog(@"Photos %@", photos);
    
    photoURLs = [[NSMutableArray alloc] init];
    
    for (NSDictionary *photoDetails in photos) {
        [photoURLs addObject:[photoDetails valueForKey:@"PhotoURL"]];
    }
    
    NSLog(@"URLs: %@", photoURLs);
    
    [self showPhotos];
}

- (void) showPhotos {
    NSUInteger numPhotos = [photoURLs count];
        
    myPhotoScroll.contentSize = CGSizeMake(myPhotoScroll.frame.size.width * numPhotos, myPhotoScroll.frame.size.height);
    myPhotoScroll.delegate = self;
    
    [self loadImageForPage:0];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = myPhotoScroll.frame.size.width;
    int pageNum = floor((myPhotoScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self loadImageForPage:pageNum];
}

- (void) loadImageForPage:(int)pageNum {
    
    NSString *url = [photoURLs objectAtIndex:pageNum];
    
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    CGRect frame = myPhotoScroll.frame;
    frame.origin.x = frame.size.width * pageNum;
    frame.origin.y = 0;
    imageView.frame = frame;
    
    [myPhotoScroll addSubview:imageView];
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
