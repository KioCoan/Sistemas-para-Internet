//
//  CCWS.m
//  Sistemas para Internet
//
//  Created by Kio Coan on 17/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import "CCWS.h"

@implementation CCWS

-(void)atualizarHorarios{
    
    NSURL* urlWs = [NSURL URLWithString:@"http://sistemasparainternet.azurewebsites.net/horarios/getHorarios.php"];
    NSData* content = [NSData dataWithContentsOfURL:urlWs];
    
    NSError* error;
    NSMutableDictionary* dictJson = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
    
    _horarios = [dictJson objectForKey:@"horarios"];
    _horarios_temp = [[NSMutableArray alloc]init];
    
    NSManagedObjectContext* contexto = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    for (int i = 0; i < [_horarios count]; i++) {
        
        Horarios* horario = [NSEntityDescription insertNewObjectForEntityForName:@"Horarios" inManagedObjectContext:contexto];
        
        NSNumber* diaSnumber = [NSNumber numberWithInt:[[[_horarios objectAtIndex:i]objectForKey:@"diaS"]intValue]];
        NSNumber* codHnumber = [NSNumber numberWithInt:[[[_horarios objectAtIndex:i]objectForKey:@"codH"]intValue]];
        NSNumber* semestreNumber = [NSNumber numberWithInt:[[[_horarios objectAtIndex:i]objectForKey:@"semestre"]intValue]];
        horario.diaS = diaSnumber;
        horario.cods = [[_horarios objectAtIndex:i]objectForKey:@"cods"];
        horario.codH = codHnumber;
        horario.nomeDisc = [[_horarios objectAtIndex:i]objectForKey:@"nomeDisc"];
        horario.nomeProf = [[_horarios objectAtIndex:i]objectForKey:@"nomeProf"];
        horario.semestre = semestreNumber;
        horario.localizacao = [[_horarios objectAtIndex:i]objectForKey:@"localizacao"];
        
        
        NSError* error;
        [contexto save:&error];
        
    }

}


-(void)atualizarNotificacoes{
    
}

-(void)verificarAtualizacoes{
    NSURL* urlWs = [NSURL URLWithString:@"http://sistemasparainternet.azurewebsites.net/horarios/getAtualizacao.php"];
    NSData* content = [NSData dataWithContentsOfURL:urlWs];
    
    NSError* error;
    NSMutableDictionary* dictJson = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&error];
    
    _datasAtt = [dictJson objectForKey:@"atualizacao"];
    
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc]init];
    dtFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    
    NSDate* dtAtualizacaoHorario = [dtFormatter dateFromString:[[_datasAtt objectAtIndex:0] objectForKey:@"dtAtualizacaoHorario"]];
    
    NSDate* diaAtual = [NSDate date];
    NSDate* dataSalva = [[NSUserDefaults standardUserDefaults]objectForKey:@"ultimaAtualizacao"];
    
    
    NSString* dataSalvas = [dtFormatter stringFromDate:dataSalva];
    NSLog(@"data salva: %@",dataSalvas);
    if([dataSalva compare:dtAtualizacaoHorario] == NSOrderedDescending){
        //data Salva é mais recente que a atual
        NSLog(@"não precisaria atualizar");
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"primeiraAtualizacao"] == YES){
            [self atualizarHorarios];
            [[NSUserDefaults standardUserDefaults]setObject:diaAtual forKey:@"ultimaAtualizacao"];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"primeiraAtualizacao"];
            NSLog(@"dsadsaoidnoaidmw");
        }
    }else if([dataSalva compare:dtAtualizacaoHorario] == NSOrderedAscending){
        //data salva é mais antiga que a atualizacao, então tem que atualizar o horario
        [self limparHorarios];
        NSLog(@"Deveria atualizar");
        [self atualizarHorarios];
        [[NSUserDefaults standardUserDefaults]setObject:diaAtual forKey:@"ultimaAtualizacao"];
    }else{
        //data igual, não precisa atualizar
        NSLog(@"igual");
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"primeiraAtualizacao"] == YES){
            [self atualizarHorarios];
            [[NSUserDefaults standardUserDefaults]setObject:diaAtual forKey:@"ultimaAtualizacao"];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"primeiraAtualizacao"];
            NSLog(@"dsadsaoidnoaidmw");
        }
    }
    
}

-(void)limparHorarios{
    NSManagedObjectContext* deleteContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Horarios" inManagedObjectContext:deleteContext];
    request.entity = desc;
    request.includesPropertyValues = NO;
    NSError* error;
    
    NSArray* results = [deleteContext executeFetchRequest:request error:&error];
    if(results.count == 0){
        return;
    }else{
        for (Horarios* horario in results) {
            [deleteContext deleteObject:horario];
        }
        [deleteContext save:&error];
    }
    
}

-(void)limparMensagens{
    NSManagedObjectContext* deleteContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    NSEntityDescription* desc = [NSEntityDescription entityForName:@"Notificacoes" inManagedObjectContext:deleteContext];
    request.entity = desc;
    request.includesPropertyValues = NO;
    NSError* error;
    
    NSArray* results = [deleteContext executeFetchRequest:request error:&error];
    if(results.count == 0){
        return;
    }else{
        for (Notificacoes* notificacao in results) {
            [deleteContext deleteObject:notificacao];
        }
        [deleteContext save:&error];
    }
}


@end
