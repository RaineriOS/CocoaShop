//
//  CSVenueInfoViewController.m
//  CocoaShop
//
//  Created by user on 22.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "CSVenueInfoViewController.h"

@interface CSVenueInfoViewController ()

@property (nonatomic, strong)   NSArray     *keys;
@property (nonatomic, strong)   RKMVenue    *venue;

-(void)_setupNavigationBar;
-(void)_setupTableView;
-(void)_setupTableViewKeys;

@end

@implementation CSVenueInfoViewController

static NSString *CellIdentifier = @"Cell";

-(id)initWithVenue:(RKMVenue*)venue
{
    self=[self initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.venue=venue;
    }
    
    return self;
}


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
    [self _setupNavigationBar];
    [self _setupTableView];
    [self _setupTableViewKeys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)_setupNavigationBar
{
    self.title=self.venue.name;
}


-(void)_setupTableView
{
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:CellIdentifier];
}


-(void)_setupTableViewKeys
{
    self.keys=@[
                @"address",
                @"city",
                @"country",
                ];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[self.venue.location valueForKey:[self.keys objectAtIndex:indexPath.row]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
