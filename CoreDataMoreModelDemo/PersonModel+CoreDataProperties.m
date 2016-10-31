//
//  PersonModel+CoreDataProperties.m
//  CoreDataMoreModelDemo
//
//  Created by xiangzuhua on 16/10/26.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "PersonModel+CoreDataProperties.h"

@implementation PersonModel (CoreDataProperties)

+ (NSFetchRequest<PersonModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PersonModel"];
}

@dynamic name;
@dynamic sex;
@dynamic pet;
@dynamic dog;

@end
