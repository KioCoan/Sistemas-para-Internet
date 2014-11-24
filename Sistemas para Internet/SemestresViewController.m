
//
//  SemestresViewController.m
//  Sistemas para Internet
//
//  Created by Kio Coan on 18/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import "SemestresViewController.h"
#import "CCWS.h"

@interface SemestresViewController ()

@end

@implementation SemestresViewController

@synthesize fechedResultsController, managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CCWS* ccws = [[CCWS alloc]init];
    
    [ccws verificarAtualizacoes];
    
    [self carregarSemestres];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)carregarSemestres{
    
    NSManagedObjectContext* contexto = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Horarios" inManagedObjectContext:contexto];
    
    [fetchRequest setEntity:entity];
    NSAttributeDescription* sem = [entity.attributesByName objectForKey:@"semestre"];
    
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:sem]];
    [fetchRequest setPropertiesToGroupBy:[NSArray arrayWithObject:sem]];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    NSError* error;
    _semestres = [contexto executeFetchRequest:fetchRequest error:&error];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_semestres count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"celula"];
    // Configure the cell...
    NSString* numeroDoSemestre = [NSString stringWithFormat:@"%@ Semestre",[[_semestres objectAtIndex:indexPath.row] objectForKey:@"semestre"]];
    UILabel* semestre = [[UILabel alloc]initWithFrame:CGRectMake(40, cell.frame.size.height / 2, 200, 50)];
    semestre.text = numeroDoSemestre;
    [cell addSubview:semestre];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
