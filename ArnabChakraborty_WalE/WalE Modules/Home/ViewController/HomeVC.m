//
//  HomeVC.m
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 30/11/21.
//

#import "HomeVC.h"
#import "Connectivity.h"

@interface HomeVC ()

@end

@implementation HomeVC
@synthesize vwContainer,vwScrllCont,lblTitle,lblDescription,imgvwNet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblTitle setHidden:YES];
    [self.lblDescription setHidden:YES];
    [self.imgvwNet setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeBackgroudView];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [spinner stopAnimating];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self createAndPopulateUI];
}

- (void)makeBackgroudView{
    UIColor *topColor = [UIColor colorWithRed: 0.80 green: 0.33 blue: 0.20 alpha: 1.00];
    UIColor *bottomColor = [UIColor colorWithRed: 0.14 green: 0.03 blue: 0.30 alpha: 1.00];
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    theViewGradient.frame = self.vwContainer.bounds;
    [self.vwContainer.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)createAndPopulateUI{
    Connectivity * objConnct;
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dictUIdata = [NSMutableDictionary dictionary];
    dictUIdata = [data objectForKey:@"data_Dictionary"];
    if (![objConnct connected]) {
        if([dictUIdata count] > 0){
            NSString *dateString = [dictUIdata valueForKey:@"currenttimestamp"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:dateString];
            NSDate *currentDate = [NSDate date];
            NSInteger difference = [self daysBetweenDates:date currentDate:currentDate];
            [self.lblTitle setHidden:NO];
            [self.lblDescription setHidden:NO];
            [self.imgvwNet setHidden:NO];
            if(difference == 0){
                self.lblTitle.text = [dictUIdata valueForKey:@"title"];
                self.lblDescription.text = [dictUIdata valueForKey:@"description"];
                UIImage *image1=[UIImage imageWithContentsOfFile:[dictUIdata valueForKey:@"image"]];
                self.imgvwNet.image=image1;
            }else{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning.."
                                           message:@"We are not connected to the internet, showing you the last image we have."
                                           preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    self.lblTitle.text = [dictUIdata valueForKey:@"title"];
                    self.lblDescription.text = [dictUIdata valueForKey:@"description"];
                    UIImage *image1=[UIImage imageWithContentsOfFile:[dictUIdata valueForKey:@"image"]];
                    self.imgvwNet.image=image1;
                }];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            [self.lblTitle setHidden:YES];
            [self.lblDescription setHidden:YES];
            [self.imgvwNet setHidden:YES];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error.."
                                       message:@"Please connect with Internet to see the Astronomy Picture of the day and it's details!!"
                                       preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else {
        [self.lblTitle setHidden:NO];
        [self.lblDescription setHidden:NO];
        [self.imgvwNet setHidden:NO];
        self.lblTitle.text = [dictUIdata valueForKey:@"title"];
        self.lblDescription.text = [dictUIdata valueForKey:@"description"];
        UIImage *image1=[UIImage imageWithContentsOfFile:[dictUIdata valueForKey:@"image"]];
        self.imgvwNet.image=image1;
    }
}

- (NSInteger)daysBetweenDates: (NSDate *)startDate currentDate: (NSDate *)endDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:startDate toDate:endDate options:0];
    return [components day];
}

@end
