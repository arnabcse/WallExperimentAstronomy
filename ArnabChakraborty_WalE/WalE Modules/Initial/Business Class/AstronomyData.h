//
//  AstronomyData.h
//  ArnabChakraborty_WalE
//
//  Created by Arnab on 01/12/21.
//

#import <Foundation/Foundation.h>

@protocol callBackProtocol <NSObject>
@optional
- (void)callBackToVC;
@end

@interface AstronomyData : NSObject
{
}

@property(nonatomic,assign) id<callBackProtocol> m_dlgCallbackDelegate;
@property (nonatomic, retain) NSMutableArray *m_marrAstronomyModelObjs;

- (void)fetchAllAstronomyData;

@end


