//
//  DogModel+CoreDataProperties.h
//  CoreDataMoreModelDemo
//
//  Created by xiangzuhua on 16/10/31.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "DogModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DogModel (CoreDataProperties)

+ (NSFetchRequest<DogModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *color;
@property (nullable, nonatomic, copy) NSString *kind;
@property (nullable, nonatomic, copy) NSString *master;
@property (nonatomic) int64_t weight;
@property (nullable, nonatomic, retain) PersonModel *person;

@end

NS_ASSUME_NONNULL_END
