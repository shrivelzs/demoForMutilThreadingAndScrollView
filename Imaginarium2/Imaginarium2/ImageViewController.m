//
//  ImageViewController.m
//  Imaginarium
//
//  Created by nazar on 4/4/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    self.scrollView.contentSize = self.image ? self.image.size :CGSizeZero;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)setImageURL:(NSURL *)ImageURL {
    
    _ImageURL = ImageURL;
//    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ImageURL]];
    [self startDownLoadingImage];
    
}

-(void)startDownLoadingImage
{
    self.image = nil;
    if (self.ImageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.ImageURL];
        //step 1, NSURLRequest
        NSURLSessionConfiguration *configuration= [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        //step 2, session, use default setting so that callback will on a different queue
        NSURLSessionDownloadTask *Task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual: self.ImageURL])
                {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    [self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
                    
                }
                
            }
        }];
        [Task resume];
    }
}

-(UIImageView*)imageView {
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

-(UIImage*)image {
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image {
    
    self.imageView.image = image;
    [self.imageView sizeToFit];
    //self.scrollView.contentSize = self.image?self.image.size:CGSizeZero;
    [self.spinner stopAnimating];
    
}
-(void)viewDidLoad {
    
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}
@end
