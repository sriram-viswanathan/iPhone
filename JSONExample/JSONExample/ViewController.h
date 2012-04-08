//
//  ViewController.h
//  JSONExample
//
//  Created by Yahoo on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableData *responseData;
    NSMutableArray *photoURLs;
    
    IBOutlet UIScrollView *myPhotoScroll;
}

@end
