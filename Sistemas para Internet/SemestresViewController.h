//
//  SemestresViewController.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 18/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Horarios.h"

@interface SemestresViewController : UITableViewController

@property NSArray* semestres;
@property NSManagedObjectContext* managedObjectContext;
@property NSFetchedResultsController* fechedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)carregarSemestres;

@end
