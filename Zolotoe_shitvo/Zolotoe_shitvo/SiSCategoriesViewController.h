//
//  SiSGategoriesViewController.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 10.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//  В этом вьюконтроллере показывается коллекшн вью с товарами на стартовой странице сайта (их всего 7 штук, поэтому в коллекшн вью добавляются в цикле 7 фотографий по 100 раз - чтобы для пользователя создалось впечатление цикличности коллекшн). Далее отображается скролл со списком разделов приложения (сайта). Внизу будет отображаться таб бар с "горячими" переходами: "Главная", "О нас", "Контакты", "Новости". Может быть, в будущем тут будет добавлена левая менюшка (пока не очень понимаю ее необходимость).

#import <UIKit/UIKit.h>
#import "SiSUITabBarItem.h"

@interface SiSCategoriesViewController : SiSUITabBarItem

@property (strong, nonatomic) NSMutableArray* offerProducts;


@end
