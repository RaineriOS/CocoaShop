//
//  CSViewController.m
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "CSVenuesViewController.h"
#import "CSVenueInfoViewController.h"
#import "RKMVenue+additional.h"
#import "RKMVenue+apiRequests.h"

static NSString *cellIdentifier = @"cellIdentifier";


@interface CSVenuesViewController ()

@property (nonatomic, strong)   NSFetchedResultsController  *fetchedResultsController;

-(void)_setupTableView;
-(void)_reloadData;

@end

@implementation CSVenuesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupTableView];
    
    [self _reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)_setupTableView
{
    self.refreshControl=[[UIRefreshControl alloc] init];;
        [self.refreshControl addTarget:self action:@selector(_reloadData) forControlEvents:UIControlEventValueChanged];
}


-(void)_reloadData
{
    CLLocationCoordinate2D coordinate=COCOAHEADS_MOSCOW_SKYLIGHT_HEADQUARTERS_COORDINATE;
    NSString *queryString=@"cocoa";
    [RKMVenue venuesWithQuery:queryString fromCoordinate:coordinate finishBlock:^(NSArray *objects)
    {
        [self.refreshControl endRefreshing];
        //here you can do some additional stuff
        //after operation ends
    } errorBlock:^(NSError *error)
    {
        [self.refreshControl endRefreshing];
        //any operations if error occured
    }];
}





#pragma mark - Properties -



-(NSFetchedResultsController*)fetchedResultsController
{
    if (!_fetchedResultsController)
        _fetchedResultsController=[RKMVenue MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"order" ascending:YES delegate:self];
    
    return _fetchedResultsController;
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }

    RKMVenue *venue=(RKMVenue*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=venue.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1f km",(venue.location.distance.floatValue/1000)];
    return cell;
}

#pragma mark - Table view delegate



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RKMVenue *venue=(RKMVenue*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    CSVenueInfoViewController *venueInfoViewController=[[CSVenueInfoViewController alloc] initWithVenue:venue];
    [self.navigationController pushViewController:venueInfoViewController animated:YES];
}








#pragma mark - Fetched results controller Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            //JLUserCardCell *cell = (JLUserCardCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            //RKMVisitingCard *visitingCard=anObject;
            //[cell setUser:visitingCard.user];
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


@end
