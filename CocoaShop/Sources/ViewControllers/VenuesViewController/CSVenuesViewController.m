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

#define TEST_SEARCH_QUERY   @"cocoa"

@interface CSVenuesViewController ()

@property (nonatomic, strong)   NSFetchedResultsController      *fetchedResultsController;
@property (nonatomic, strong)   UISearchBar                     *searchBar;

-(void)_setupNavigationBar;
-(void)_setupTableView;
-(void)_reloadData;

@end

@implementation CSVenuesViewController

-(void)dealloc
{
    self.fetchedResultsController.delegate=nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupNavigationBar];
    [self _setupTableView];
    [self _reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.fetchedResultsController=nil;
}



-(void)_setupNavigationBar
{
    self.title=@"Venues";
}


-(void)_setupTableView
{
    self.refreshControl=[[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(_reloadData) forControlEvents:UIControlEventValueChanged];
}


-(void)_reloadData
{
    //resigning first responder on reload
    [self.searchBar resignFirstResponder];
    
    //first clear cached objects (just for test use in this project)
    [[RKMVenue MR_findAll] makeObjectsPerformSelector:@selector(MR_deleteEntity)];

    CLLocationCoordinate2D coordinate=TEST_COORDINATE1;
    NSString *queryString=self.searchBar.text;
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



-(UISearchBar*)searchBar
{
    if (!_searchBar)
    {
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.view.bounds), 44.f)];
        _searchBar.text=TEST_SEARCH_QUERY;
        _searchBar.delegate=self;
    }
    
    return _searchBar;
}


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



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchBar;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }

    RKMVenue *venue=(RKMVenue*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=venue.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f km",(venue.location.distance.floatValue/1000)];
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







#pragma mark - UISearchBar Delegate -

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    [searchBar resignFirstResponder];
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self _reloadData];
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
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            RKMVenue *venue=(RKMVenue*)anObject;
            cell.textLabel.text=venue.name;
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.1f km",(venue.location.distance.floatValue/1000)];
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
