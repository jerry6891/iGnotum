//
//  SectionDetailViewController.h
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-03-10.
//  Copyright © 2018 GWEB. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef SectionDetailViewController_h
#define SectionDetailViewController_h


#endif /* SectionDetailViewController_h */

@interface SectionDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (readwrite) NSString *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *cast;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *downloadedView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroller;
@property (readwrite) NSString *release_segue;
@property (readwrite) NSString *rating_segue;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *productionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *synopsisHeight;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;


@end
