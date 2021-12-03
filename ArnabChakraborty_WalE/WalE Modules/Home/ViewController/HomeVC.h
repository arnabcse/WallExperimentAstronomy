//
//  HomeVC.h
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 30/11/21.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController
{
    UIView *vwContainer;
    UIScrollView *vwScrllCont;
    UILabel *lblTitle;
    UILabel *lblDescription;
    UIImageView *imgvwNet;
}

@property (nonatomic, retain) IBOutlet UIView *vwContainer;
@property (nonatomic, retain) IBOutlet UIScrollView *vwScrllCont;
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblDescription;
@property (nonatomic, retain) IBOutlet UIImageView *imgvwNet;

@end

