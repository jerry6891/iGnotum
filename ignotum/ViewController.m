//
//  ViewController.m
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-02-26.
//  Copyright © 2018 GWEB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [labelOne setText:@"Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit, sed\nLorem ipsum Lorem ipsum Lorem"];
    
    // Do any additional setup after loading the view, typically from a nib.
    /* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width *3, self.view.frame.size.height)];
    
    [scrollView addSubview:labelOne];
    [scrollView addSubview:labelTwo]; */
    
    NSString *labelText = @"An iOS application that uses the TMDB API to search the “nowadays” movies\n"
    "where the user can view the movie’s title, poster, synopsis, cast members, rating, etc.";
    [labelOne setText:labelText];
    
    [labelOne sizeToFit];
    labelOne.numberOfLines = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sHare:(id)sender {
    NSArray* sharedObjects=[NSArray arrayWithObjects:@"sharecontent",  nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]                                                                initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}


@end
