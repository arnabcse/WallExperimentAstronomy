//
//  ViewController.h
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 30/11/21.
//

#import <UIKit/UIKit.h>
#import "AstronomyData.h"

@interface InitialVC : UIViewController
{
    UIView *vwContainer;
    AstronomyData *bcAstronomyData;
    UIButton *btnLetsGo;
    UILabel *lblLoading;
}
@property (nonatomic, retain) IBOutlet UIView *vwContainer;
@property (nonatomic, retain) IBOutlet UIButton *btnLetsGo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;
@property (nonatomic, retain) IBOutlet UILabel *lblLoading;


@end

