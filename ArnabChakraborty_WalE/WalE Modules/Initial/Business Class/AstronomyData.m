//
//  AstronomyData.m
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 01/12/21.
//

#import "AstronomyData.h"

@implementation AstronomyData
@synthesize m_dlgCallbackDelegate,m_marrAstronomyModelObjs;

-(id)init{
    self=[super init];
    if(self){
    }
    return self;
}

- (void)fetchAllAstronomyData{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.nasa.gov/planetary/apod?api_key=tBcIJIzLhN3PtRmTAdeuFzXRIEq9Iyor7337lN8p"];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

                if (jsonError) {
                } else {
                        NSURL  *url = [NSURL URLWithString:[jsonResponse valueForKey:@"url"]];
                        NSData *urlData = [NSData dataWithContentsOfURL:url];
                        if ( urlData )
                        {
                            [self resetDefaults];
                            NSLog(@"Downloading started...");
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                            NSString *documentsDirectory = [paths objectAtIndex:0];
                            NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"dwnld_image.png"];
                            [urlData writeToFile:filePath atomically:YES];
                            NSMutableDictionary *dictData = [NSMutableDictionary dictionary];
                            [dictData setValue:[jsonResponse valueForKey:@"title"] forKey:@"title"];
                            [dictData setValue:[jsonResponse valueForKey:@"explanation"] forKey:@"description"];
                            [dictData setValue:filePath forKey:@"image"];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
                            NSDate *currentDate = [NSDate date];
                            NSString *dateString = [formatter stringFromDate:currentDate];
                            [dictData setValue:dateString forKey:@"currenttimestamp"];
                            [[NSUserDefaults standardUserDefaults] setObject:dictData forKey:@"data_Dictionary"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.m_dlgCallbackDelegate callBackToVC];
                        }
                }
            }  else {
                //Web server is returning an error
            }
        } else {
            NSLog(@"error : %@", error.description);
        }
    }] resume];
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

@end
