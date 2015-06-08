//
//  ViewController.h
//  Imaginarium2
//
//  Created by Shu Zhang on 6/5/15.
//  Copyright (c) 2015 Shu Zhang. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController*)segue.destinationViewController;
        ivc.ImageURL = [NSURL  URLWithString:[NSString stringWithFormat:@"http://www.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg",segue.identifier]];
        ivc.title = segue.identifier;
    }
    
}

@end
