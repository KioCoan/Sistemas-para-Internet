//
//  Atualizacao.h
//  Sistemas para Internet
//
//  Created by Kio Coan on 17/09/14.
//  Copyright (c) 2014 Kio Coan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Atualizacao : NSManagedObject

@property (nonatomic, retain) NSDate * dtAtualizacaoHorario;
@property (nonatomic, retain) NSDate * dtNovaNotificacao;
@property (nonatomic, retain) NSDate * dtAtualizacaoNotificacao;

@end
