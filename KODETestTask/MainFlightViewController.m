//
//  PurchaseViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 06.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "MainFlightViewController.h"
#import "RouteViewController.h"
#import "TravelDatesViewController.h"
#import "PassengersViewController.h"
#import "FoundFlightsViewController.h"

static NSString *const kRouteViewControllerSegueName        = @"RouteViewController";
static NSString *const kTravelDatesViewControllerSegueName  = @"TravelDatesViewController";
static NSString *const kPassengersViewControllerSegueName   = @"PassengersViewController";
static NSString *const kFoundFlightsPushSegueName           = @"FoundFlightsPushSegue";

@interface MainFlightViewController ()

@property (weak, nonatomic) RouteViewController *routeViewController;

@end


@implementation MainFlightViewController


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure navbar to display logo and be transparent
    UIImage *logo = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logo];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Events


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kRouteViewControllerSegueName]) {
        _routeViewController = (RouteViewController *) [segue destinationViewController];
    }
    else if([segue.identifier isEqualToString:kFoundFlightsPushSegueName]) {
        // Passing cities as departure and destination to found flights view controller
        FoundFlightsViewController *foundFlightsViewController = (FoundFlightsViewController *)segue.destinationViewController;
        [foundFlightsViewController prepareForDepartureCity:_routeViewController.departureCity destinationCity:_routeViewController.destinationCity];
    }
}

- (IBAction)FindFlightsButtonTapped:(id)sender
{
    if([_routeViewController validateRouteData])
        [self performSegueWithIdentifier:kFoundFlightsPushSegueName sender:sender];
}




@end
