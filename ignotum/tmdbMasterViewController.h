//
//  tmdbMasterViewController.h
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-03-10.
//  Copyright © 2018 GWEB. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef tmdbMasterViewController_h
#define tmdbMasterViewController_h


#endif /* tmdbMasterViewController_h */

@interface tmdbMasterViewController : UIViewController <UISearchDisplayDelegate>
@property (readwrite) int index;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (readwrite) NSString *chosenTitle;
@property (strong, nonatomic) IBOutlet UITableView *masterView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *scrollWheel;
@property (nonatomic, strong) NSMutableArray *searchResult;

@end
