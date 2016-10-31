//
//  DogModel+CoreDataProperties.m
//  CoreDataMoreModelDemo
//
//  Created by xiangzuhua on 16/10/31.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "DogModel+CoreDataProperties.h"

@implementation DogModel (CoreDataProperties)

+ (NSFetchRequest<DogModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DogModel"];
}

@dynamic color;
@dynamic kind;
@dynamic master;
@dynamic weight;
@dynamic person;

@end
