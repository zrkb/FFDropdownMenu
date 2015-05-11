//
//  FFDropDownMenuData.h
//  FFDropDownMenu
//
//  Created by Felix Ayala on 5/11/15.
//  Copyright (c) 2015 Felix Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFDropDownMenuData : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

+ (id)dropdownMenuDataWithKey:(NSString *)key value:(NSString *)value;
- (id)initWithKey:(NSString *)key value:(NSString *)value;

@end
