#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>


@interface FriendRecommendationsViewController : UITableViewController <GKFriendRequestComposeViewControllerDelegate>{}
@property(retain, nonatomic) NSArray *players;
-(void)addAll;
@end

%hook FriendRecommendationsViewController

%new(:@@)
-(void)addAll
{
    // Get the list of players
    NSArray *pl = [self players];
    
    NSMutableArray *identifiers = [[NSMutableArray alloc] initWithCapacity:[pl count]];
    
    // store their playerID in an array
    for (GKPlayer *player in pl) {
        [identifiers addObject:player.playerID];      
    }
    
    // send the friend requests
    GKFriendRequestComposeViewController *friendRequestViewController = [[GKFriendRequestComposeViewController alloc] init];
    friendRequestViewController.composeViewDelegate = self;
    [friendRequestViewController setMessage:@"GKFriendsAdder request. (Tweak by @mattlawer)"];
    if (identifiers)
    {
        if ([identifiers count] > [GKFriendRequestComposeViewController maxNumberOfRecipients]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You will add %i friends",[identifiers count]] message:[NSString stringWithFormat:@"Sending more than %i requests could make the Game Center crash.",[GKFriendRequestComposeViewController maxNumberOfRecipients]] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
        [friendRequestViewController addRecipientsWithPlayerIDs: identifiers];
    }
    [self presentModalViewController: friendRequestViewController animated: YES];
    [friendRequestViewController release];
    [identifiers release];
}

%new(:@@)
- (void)friendRequestComposeViewControllerDidFinish:(GKFriendRequestComposeViewController *)viewController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)arg1 {
   %orig;
    
    // add the button to the navigationItem
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc] initWithTitle:@"Add ALL" style:UIBarButtonItemStylePlain target:self action:@selector(addAll)];
    [[self navigationItem] setRightBarButtonItem:addButton animated:YES];
}

%end

%ctor {
	%init;
}

