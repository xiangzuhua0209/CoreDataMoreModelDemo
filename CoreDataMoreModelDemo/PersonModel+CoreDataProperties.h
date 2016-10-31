//
//  PersonModel+CoreDataProperties.h
//  CoreDataMoreModelDemo
//
//  Created by xiangzuhua on 16/10/26.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "PersonModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonModel (CoreDataProperties)

+ (NSFetchRequest<PersonModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *pet;
@property (nullable, nonatomic, retain) NSSet<DogModel *> *dog;

@end

@interface PersonModel (CoreDataGeneratedAccessors)

- (void)addDogObject:(DogModel *)value;
- (void)removeDogObject:(DogModel *)value;
- (void)addDog:(NSSet<DogModel *> *)values;
- (void)removeDog:(NSSet<DogModel *> *)values;

@end

NS_ASSUME_NONNULL_END
