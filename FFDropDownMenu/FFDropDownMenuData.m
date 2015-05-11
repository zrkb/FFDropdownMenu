//
//  FFDropDownMenuData.m
//  FFDropDownMenu
//
//  Created by Felix Ayala on 5/11/15.
//  Copyright (c) 2015 Felix Ayala. All rights reserved.
//

#import "FFDropDownMenuData.h"

@implementation FFDropDownMenuData

+ (id)dropdownMenuDataWithKey:(NSString *)key value:(NSString *)value {
	
	return [[self alloc] initWithKey:key value:value];
}

- (id)initWithKey:(NSString *)key value:(NSString *)value {
	
	self = [super init];
	if (self) {
		self.key = key;
		self.value = value;
		
	}
	return self;
}

@end
