//
//  FFDropDownMenuView.m
//  FFDropDownMenu
//
//  Created by Felix Ayala on 5/11/15.
//  Copyright (c) 2015 Felix Ayala. All rights reserved.
//

#import "FFDropDownMenuView.h"
#import "RMPickerViewController.h"
#import <QuartzCore/QuartzCore.h>

static const BOOL kNoneOptionActivated = YES;

NSString * const kTitleDictionaryKey = @"title";
NSString * const kValueDictionaryKey = @"value";

@interface FFDropDownMenuView () <RMPickerViewControllerDelegate>

@property (nonatomic, strong) UIImageView *dropdownArrow;

@end

@implementation FFDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self initializeControl];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self initializeControl];
	}
	return self;
}

- (void)initializeControl {
	self.backgroundColor = [UIColor clearColor];
	self.userInteractionEnabled = YES;
	
	// Inicializamos el texto que va a ir dentro de la view
	self.title = [[UILabel alloc] init];
	self.title.userInteractionEnabled = NO;
	self.title.textAlignment = NSTextAlignmentCenter;
	
	self.title.text = @"Seleccione una opción ...";
	
	CGRect titleFrame = self.bounds;
	titleFrame.size.width -= 35;
	self.title.frame = titleFrame;
	self.title.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self addCenteredSubview:self.title];
	
	// Preparamos la imagen que va a funcionar como un indicador de un Dropdown Menu
	UIImage *dropdownArrowIcon = [UIImage imageNamed:@"dropdown-arrow"];
	self.dropdownArrow = [[UIImageView alloc] initWithImage:dropdownArrowIcon];
	
	self.dropdownArrow.frame = CGRectMake(CGRectGetWidth(self.bounds) - 20, (CGRectGetHeight(self.bounds) / 2) - 3, 9, 7);
	self.dropdownArrow.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
	
	[self addSubview:self.dropdownArrow];
	
	// Agregamos el Tap Gesture Recognizer
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDropdownMenuGesture:)];
	tap.numberOfTapsRequired = 1;
	tap.numberOfTouchesRequired = 1;
	tap.cancelsTouchesInView = NO;  // this prevents the gesture recognizers to 'block' touches
	
	[self addGestureRecognizer:tap];
	
	// Preparamos los delegates
	self.pickerView = [RMPickerViewController pickerController];
	[self.pickerView setTitle:@"Seleccione una opcion y luego presione Seleccionar"];
	self.pickerView.delegate = self;
}

- (void)tapDropdownMenuGesture:(UIGestureRecognizer *)gestureRecognizer {
	[self.pickerView show];
}


#pragma mark - RMPickerViewController Delegates
- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
	
	NSNumber *selectedOptionNumber = (NSNumber *)[selectedRows firstObject];
	NSUInteger index = (NSUInteger)[selectedOptionNumber integerValue];
	
	[self markOptionAsSelectedAtIndex:index];
	
	// Solo llamamos al delegate si el método existe
	if ([self.delegate respondsToSelector:@selector(pickerViewController:didSelectRow:)]) {
		
		NSString *title = ([self.options count] > 0) ? [self.options objectAtIndex:index] : @"No hay elementos a mostrar";
		NSString *value = ([self.values count] > 0) ? [self.values objectAtIndex:index] : @"";
		
		NSDictionary *selectedRow = @{ kTitleDictionaryKey: title, kValueDictionaryKey: value };
		
		
		[self.delegate pickerViewController:vc didSelectRow:selectedRow];
	}
}

- (void)markOptionAsSelectedAtIndex:(NSUInteger)index {
	
	self.title.text = ([self.options count] > 0) ? [self.options objectAtIndex:index] : @"No hay elementos a mostrar";
	self.value = ([self.values count] > 0) ? [self.values objectAtIndex:index] : @"";
	
	//	UALog(@"title: %@", self.title.text);
	//	UALog(@"value: %@", self.value);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.options count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return self.options[row];
}

- (NSString *)selectedValue {
	return self.value;
}

- (void)drawRect:(CGRect)rect {
	
	CGRect frame = self.bounds;
	
	//// Color Declarations
	UIColor* backgroundColor = [UIColor colorWithRed: 0.922 green: 0.922 blue: 0.922 alpha: 1];
	UIColor* borderColor = [UIColor colorWithRed: 0.8 green: 0.8 blue: 0.8 alpha: 1];
	
	//// Rectangle Drawing
	UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2, CGRectGetWidth(frame) - 4, CGRectGetHeight(frame) - 4) cornerRadius: 3];
	[backgroundColor setFill];
	[rectanglePath fill];
	[borderColor setStroke];
	rectanglePath.lineWidth = 1;
	[rectanglePath stroke];
}

- (void)setDataForPickerView:(NSArray *)pickerDataCollection {
	
	if ([pickerDataCollection count] > 0) {
		
		NSMutableArray *optionsArray = [NSMutableArray array];
		NSMutableArray *valuesArray = [NSMutableArray array];
		
		for (FFDropDownMenuData *dropdownMenuData in pickerDataCollection) {
			[valuesArray addObject:dropdownMenuData.key];
			[optionsArray addObject:dropdownMenuData.value];
		}
		
		self.options = [optionsArray copy];
		self.values = [valuesArray copy];
		
		[self.pickerView.picker reloadAllComponents];
		
		if (kNoneOptionActivated == YES) {
			[self markOptionAsSelectedAtIndex:0];
		}
	}
}

- (void)addCenteredSubview:(UIView *)subview {
	
	CGRect f = subview.frame;
	
	f.origin.x = (int)((self.bounds.size.width - subview.frame.size.width) / 2);
	f.origin.y = (int)((self.bounds.size.height - subview.frame.size.height) / 2);
	
	[self addSubview:subview];
}

@end
