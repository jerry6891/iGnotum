//
//  ViewController.h
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-02-26.
//  Copyright © 2018 GWEB. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *labelOne;
    IBOutlet UILabel *labelTwo;
    
    __weak IBOutlet UIButton *Settings;
    __weak IBOutlet UIButton *Share;
    __weak IBOutlet UIButton *moviesGo;
    IBOutlet UIButton *ShareButton;
}
- (IBAction)sHare:(id)sender;
@end

