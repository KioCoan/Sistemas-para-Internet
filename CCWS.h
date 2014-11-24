//
//  CCWS.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 17/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Horarios.h"
#import "Atualizacao.h"
#import "Notificacoes.h"

@interface CCWS : NSObject

@property NSMutableArray* horarios;
@property NSMutableArray* horarios_temp;
@property NSMutableArray* datasAtt;

-(void)atualizarHorarios;
-(void)verificarAtualizacoes;
-(void)atualizarNotificacoes;
-(void)limparHorarios;
-(void)limparMensagens;

@end
