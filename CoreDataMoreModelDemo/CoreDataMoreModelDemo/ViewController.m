//
//  ViewController.m
//  CoreDataMoreModelDemo
//
//  Created by xiangzuhua on 16/10/26.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Dog.h"
#import "PersonModel+CoreDataProperties.h"
#import "DogModel+CoreDataProperties.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加数据
    Person * person = [[Person alloc] init];
    person.name = @"云中六";
    person.sex = @"man";
    person.pet = @"狗";
    
    Dog * dog = [[Dog alloc] init];
    dog.kind = @"柴狗";
    dog.color = @"黑色";
    dog.master = @"大傻";
    dog.weight = 30;
    [self addPerson:person Dog:dog];
    //查询
    [self selectDataWithEntityName:@"PersonModel" key:@"name" value:@"云中六" sortKey:@"sex"];
    //更改
    [self changeDataWithEntityName:@"PersonModel" key:@"name" oldValue:@"云中六" changeValue:@"刚刚刚" sortKey:@"sex"];
    //查询
    [self selectDataWithEntityName:@"PersonModel" key:@"name" value:@"刚刚刚" sortKey:@"sex"];
    //删除
    [self deletDataWithEntityName:@"PersonModel" key:@"name" value:@"刚刚刚" sortKey:@"sex"];
    //查询
    [self selectDataWithEntityName:@"PersonModel" key:@"name" value:@"刚刚刚" sortKey:@"sex"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 实现数据存储的增删改查方法
#pragma mark - 增加
//存储人的信息
-(void)addPerson:(Person*)person Dog:(Dog*)dog
{
    //初始化数据库可存储的实体对象,并赋值,放到上下文
    PersonModel * personM = [NSEntityDescription insertNewObjectForEntityForName:@"PersonModel" inManagedObjectContext:[self context]];
    personM.name = person.name;
    personM.sex = person.sex;
    personM.pet = person.pet;
    DogModel * dogM = [NSEntityDescription insertNewObjectForEntityForName:@"DogModel" inManagedObjectContext:[self context]];
    dogM.kind = dog.kind;
    dogM.color = dog.color;
    dogM.master = dog.master;
    dogM.weight = dog.weight;
    personM.dog = [NSSet setWithObject:dogM];
    dogM.person = personM;
    //保存
    [self save];
}

#pragma mark - 查找
-(NSArray *)selectDataWithEntityName:(NSString *)entityName key:(NSString*)key value:(NSString*)value sortKey:(NSString*)sortKey{
    //根据条件查询出数据库中的数据
    NSArray *fetchedObjects = [self searchDataInCoreDataWithEntityName:entityName key:key value:value sortKey:sortKey];
    //如果返回的数组内容大于0则遍历输出
    if (fetchedObjects.count > 0) {
        if ([fetchedObjects.firstObject isKindOfClass:[PersonModel class]]) {
            for (PersonModel * item in fetchedObjects) {
                NSSet * dog = item.dog;
                for (DogModel * dogModel in dog) {
                    NSLog(@"name = %@, sex = %@,pet = %@,dogKind = %@,dogColor = %@,dogMaster = %@,weight = %lld",item.name,item.sex,item.pet,dogModel.kind,dogModel.color,dogModel.master,dogModel.weight);
                }
            }
        }
        if([fetchedObjects.firstObject isKindOfClass:[DogModel class]]) {
            for (DogModel * item in fetchedObjects) {
                NSLog(@"kind = %@, color = %@,master = %@,weight = %lld,personName = %@,personSex = %@,personPet = %@",item.kind,item.color,item.master,item.weight,item.person.name,item.person.sex,item.person.pet);
            }
        }
    }
    //返回搜索结果
    return fetchedObjects;
}
#pragma mark - 删除
-(void)deletDataWithEntityName:(NSString*)entityName key:(NSString*)key value:(NSString*)value sortKey:(NSString*)sortKey{
    NSArray *fetchedObjects = [self searchDataInCoreDataWithEntityName:entityName key:key value:value sortKey:sortKey];
    if (fetchedObjects.count > 0) {
        if ([fetchedObjects.firstObject isKindOfClass:[PersonModel class]]) {
            for (PersonModel * item in fetchedObjects) {
                [[self context] deleteObject:item];
            }
        }
        if([fetchedObjects.firstObject isKindOfClass:[DogModel class]]) {
            for (DogModel * item in fetchedObjects) {
                [[self context] deleteObject:item];
            }
        }
    }
}

#pragma mark - 修改
-(void)changeDataWithEntityName:(NSString*)entityName key:(NSString*)key oldValue:(NSString*)oldValue changeValue:(NSString*)changeValue sortKey:(NSString*)sortKey
{
       NSArray *fetchedObjects = [self searchDataInCoreDataWithEntityName:entityName key:key value:oldValue sortKey:sortKey];
    if (fetchedObjects.count > 0) {
        if ([fetchedObjects.firstObject isKindOfClass:[PersonModel class]]) {
            for (PersonModel * item in fetchedObjects) {
                if ([key isEqualToString:@"name"]) {
                    item.name = changeValue;
                } else if([key isEqualToString:@"sex"]){
                    item.sex = changeValue;
                }else{
                    item.pet = changeValue;
                }
            }
        }
        if([fetchedObjects.firstObject isKindOfClass:[DogModel class]]) {
            for (DogModel * item in fetchedObjects) {
                if ([key isEqualToString:@"name"]) {
                    item.kind = changeValue;
                } else if([key isEqualToString:@"sex"]){
                    item.color = changeValue;
                }else{
                    item.master = changeValue;
                }
            }
        }
    }
    [self save];
}
//获取appdelegate中的context即上下文
-(NSManagedObjectContext *)context
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return app.managedObjectContext;
}
//将数据保存到上下文的方法
-(void)save
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app saveContext];
}
//在coreData中按照一定的条件来查询出数据
-(NSArray*)searchDataInCoreDataWithEntityName:(NSString*)entityName key:(NSString*)key value:(NSString*)value sortKey:(NSString*)sortKey{
    //创建搜索请求对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self context]];
    //给搜索请求对象添加实体描述
    [fetchRequest setEntity:entity];
    //创建谓词--即搜索条件,根据传入的参数来创造搜索条件
    NSPredicate *predicate;
    if ([key isEqualToString:@"name"]) {
        predicate = [NSPredicate predicateWithFormat:@"name = %@",value];
    } else if([key isEqualToString:@"sex"]){
        predicate = [NSPredicate predicateWithFormat:@"sex = %@",value];
    }else if ([key isEqualToString:@"kind"]){
        predicate = [NSPredicate predicateWithFormat:@"kind = %@",value];
    }else if([key isEqualToString:@"color"]){
        predicate = [NSPredicate predicateWithFormat:@"color = %@",value];
    }
    //给搜索请求对象设置搜索条件
    [fetchRequest setPredicate:predicate];
    //创建一个排序条件
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
    //设置搜索请求对象的排序条件 SortDescriptors是一个数组,里面存放排序条件,也就是说,排序条件可有多种,不唯一
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    //创建一个错误信息存储的对象
    NSError *error = nil;
    //执行搜索,返回的是一个存储了数据库需求的对象的数组
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}
@end
