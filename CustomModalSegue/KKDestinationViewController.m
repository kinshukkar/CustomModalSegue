//
//  KKDestinationViewController.m
//  CustomModalSegue
//
//  Created by Kinshuk Kar on 01/05/13.
//  Copyright (c) 2013 Kinshuk Kar. All rights reserved.
//

#import "KKDestinationViewController.h"

@interface KKDestinationViewController ()

@end

@implementation KKDestinationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissModal:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
