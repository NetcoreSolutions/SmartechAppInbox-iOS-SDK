//
//  SMTAppInboxMessageModel.h
//  SmartechAppInbox
//
//  Created by Netcore Solutions on 20/11/20.
//  Copyright © 2020 Netcore Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SMTInboxMessageStatus) {
    SMTInboxMessageUnread = 1,
    SMTInboxMessageViewed = 2,
    SMTInboxMessageClicked = 3,
    SMTInboxMessageDeleted = 4
};

@class SMTAppInboxMessageModel;
@class SMTAps;
@class SMTAlert;
@class SMTCustomPayload;
@class SMTPayload;
@class SMTAttributionParameter;
@class SMTActionButton;
@class SMTCarousel;
@class SMTActionButtonConfiguration;
@class SMTNotificationConstants;

#pragma mark - Object interfaces

/**
 @brief This is base model class of Push Notification.
 */
@interface SMTBase : NSObject

/**
 @brief This method gives back the dictionary object of self object.
 
 @return NSMutableDictionary The key value pair for self parameters.
 */
- (NSMutableDictionary *)toNSDictionary;

/**
 @brief This method gives back the array object of self object.
 
 @param SMTBaseArray - array of self object.
 
 @return NSArray The array of dictionary.
 */
- (NSArray *)SMTBaseDictionaryArray :(NSArray <SMTBase *> *) SMTBaseArray;

@end

/**
 @brief This model class contains complete payload of Push Notification.
 */
@interface SMTAppInboxMessageModel : SMTBase <NSCoding>

@property (nonatomic, strong) SMTAps *aps;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) SMTPayload *smtPayload;
@property (nonatomic, strong) NSDictionary *smtCustomPayload;

@end

///**
// @brief This model class contains complete payload of Push Notification.
// */
//@interface SMTNotificationCategoryModel : SMTBase <NSCoding>
//
//@property (nonatomic) NSInteger categoryId;
//@property (nonatomic, copy) NSString *categoryName;
//
//@end

/**
 @brief This model class contains APS.
 */
@interface SMTAps : SMTBase <NSCoding>

@property (nonatomic, strong) SMTAlert *alert;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *sound;

@end

/**
 @brief This model class contains Alert.
 */
@interface SMTAlert : SMTBase <NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *body;

@end

/**
 @brief This model class contains the actual payload.
 */
@interface SMTPayload : SMTBase <NSCoding>

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *trid;
@property (nonatomic, copy) NSString *mediaURL;
@property (nonatomic, copy) NSString *mediaURLPath;
@property (nonatomic, copy) NSString *deeplink;
@property (nonatomic, copy) NSArray <SMTActionButton *> *actionButton;
@property (nonatomic, copy) NSArray <SMTCarousel *> *carousel;
@property (nonatomic, strong) SMTAttributionParameter *smtAttribution;
@property (nonatomic, copy) NSDictionary *pnMeta;
@property (nonatomic, copy) NSString *publishedDate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *sound;
@property (nonatomic, copy) NSString *collapseKey;
@property (nonatomic, copy) NSString *modifiedDate;
@property (nonatomic, copy) NSString *appInBoxCategory;
@property (nonatomic, copy) NSString *appInBoxTimestamp;
@property (nonatomic, copy) NSString *aappInBoxTtl;


- (void)deleteStoredMedia;

@end

/**
 @brief This model class contains the attribution parameters.
 */
@interface SMTAttributionParameter : SMTBase <NSCoding>

// This is used to store the complete attrParams which is used by the smartech server for PN attribution.
@property (nonatomic, copy) NSDictionary *attrParams;

// This variable get value when we break down __sta parameter comming in attrParams.
@property (nonatomic, copy) NSString *attrIdentity;

@end

/**
 @brief This model class contains the action buttons.
 */
@interface SMTActionButton : SMTBase <NSCoding>

typedef NS_ENUM(NSUInteger, SMTActionType) {
    SMTActionTypeNone = 1,
    SMTActionTypeCopyCode = 2,
    SMTActionTypeDismiss = 3,
    SMTActionTypeSnooze = 4,
    SMTActionTypeReply = 5
};

@property (nonatomic, copy) NSString *actionName;
@property (nonatomic, copy) NSString *actionDeeplink;
@property (nonatomic, copy) NSNumber *actionType;
@property (nonatomic, copy) NSDictionary *actionConfig;

@end

/**
 @brief This model class contains the action buttons configurations.
 */
@interface SMTActionButtonConfiguration : SMTBase <NSCoding>

@property (nonatomic, copy) NSString *promoCode;
@property (nonatomic, copy) NSString *snoozeInterval;

@end

/**
 @brief This model class contains the carousel.
 */
@interface SMTCarousel : SMTBase <NSCoding>

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *imgUrlPath;
@property (nonatomic, copy) NSString *imgTitle;
@property (nonatomic, copy) NSString *imgMsg;
@property (nonatomic, copy) NSString *imgDeeplink;

@end

NS_ASSUME_NONNULL_END

