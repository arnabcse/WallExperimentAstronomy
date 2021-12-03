//
//  ViewController.m
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 30/11/21.
//

#import "InitialVC.h"

@interface InitialVC ()

@end

@implementation InitialVC
@synthesize vwContainer,btnLetsGo,activitySpinner,lblLoading;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.btnLetsGo addTarget:self action:@selector(letsGoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self makeBackgroudView];
    [self.lblLoading setHidden:YES];
    bcAstronomyData = [[AstronomyData alloc] init];
    bcAstronomyData.m_dlgCallbackDelegate = self;
}

- (void)makeBackgroudView
{
    UIColor *topColor = [UIColor colorWithRed: 0.74 green: 0.76 blue: 0.78 alpha: 1.00];
    UIColor *bottomColor = [UIColor colorWithRed: 0.17 green: 0.24 blue: 0.31 alpha: 1.00];
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    theViewGradient.frame = self.vwContainer.bounds;
    [self.vwContainer.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)letsGoButtonTapped:(UIButton *)sender
{
    [self.activitySpinner startAnimating];
    [self.lblLoading setHidden:NO];
    [self performSelectorInBackground:@selector(startBackGroundOperartion) withObject:nil];
}

- (void)startBackGroundOperartion
{
    [bcAstronomyData fetchAllAstronomyData];
}

- (void)callBackToVC
{
    [self performSelectorOnMainThread:@selector(uiRefreshOperation) withObject:nil waitUntilDone:YES];
}

- (void)uiRefreshOperation
{
    [self.activitySpinner startAnimating];
    [self.lblLoading setHidden:YES];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vcHome = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
    [self presentViewController:vcHome animated:YES completion:nil];
}

@end
