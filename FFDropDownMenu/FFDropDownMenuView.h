//
//  FFDropDownMenuView.h
//  FFDropDownMenu
//
//  Created by Felix Ayala on 5/11/15.
//  Copyright (c) 2015 Felix Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kTitleDictionaryKey;
extern NSString * const kValueDictionaryKey;

@class RMPickerViewController;

@protocol DropdownMenuDelegate <NSObject>

@optional

- (void)pickerViewController:(RMPickerViewController *)vc didSelectRow:(NSDictionary *)selectedRow;

@end

@interface FFDropDownMenuView : UIView

@property (nonatomic, assign) id <DropdownMenuDelegate> delegate;

@property (nonatomic, strong) RMPickerViewController *pickerView;

@property (nonatomic, strong) NSArray *options;
@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSString *value;

- (void)setDataForPickerView:(NSDictionary *)pickerDataCollection;
- (NSString *)selectedValue;

@end
