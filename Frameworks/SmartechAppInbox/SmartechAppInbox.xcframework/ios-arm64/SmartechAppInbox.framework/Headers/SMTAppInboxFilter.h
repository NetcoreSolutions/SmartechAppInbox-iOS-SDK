//
//  SMTAppInboxFilter.h
//  SmartechAppInbox
//
//  Created by Netcore Solutions on 25/11/20.
//  Copyright © 2020 Netcore Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Define the enum for direction
typedef NS_ENUM(NSInteger, SMTInboxDirection) {
    SMTInboxDirectionAll,
    SMTInboxDirectionLatest,
    SMTInboxDirectionEarliest
};

@interface SMTAppInboxFilter : NSObject

@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,copy) NSString *direction;
@property(nonatomic,copy, readonly) NSString *timestamp;
// Add new enum property for type-safe usage
@property(nonatomic, assign) SMTInboxDirection directionType;

// Setter method for enum (alternative to direct property access)
-(void)setDirectionType:(SMTInboxDirection)directionType;

- (NSDictionary *)getFilterDictionary;

@end

NS_ASSUME_NONNULL_END
