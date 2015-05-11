//
//  ViewController.m
//  FFDropDownMenu
//
//  Created by Felix Ayala on 5/11/15.
//  Copyright (c) 2015 Felix Ayala. All rights reserved.
//

#import "ViewController.h"
#import "FFDropDownMenuView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet FFDropDownMenuView *myDropdown;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self configureDropdownMenu];
}

- (void)configureDropdownMenu {
	
	// Cargamos los datos para el picker
	FFDropDownMenuData *data_1 = [FFDropDownMenuData dropdownMenuDataWithKey:@"PYG" value:@"Paraguay"];
	FFDropDownMenuData *data_2 = [FFDropDownMenuData dropdownMenuDataWithKey:@"USD" value:@"Yankis Imperialistas"];
	FFDropDownMenuData *data_3 = [FFDropDownMenuData dropdownMenuDataWithKey:@"EUR" value:@"Europa"];

	
	[self.myDropdown setDataForPickerView:@[data_1, data_2, data_3]];
}

- (IBAction)showSelectedOption:(id)sender {
	NSString *selectedValue = [self.myDropdown selectedValue];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FFDropdownMenu"
													message:[NSString stringWithFormat:@"El valor seleccionado es: %@", selectedValue]
												   delegate:nil
										  cancelButtonTitle:@"Aceptar"
										  otherButtonTitles:nil];
	
	[alert show];
	
}

@end
