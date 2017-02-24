//
//  SiSFirstViewController.h
//  Zolotoe_shitvo
//
//  Created by Stanly Shiyanovskiy on 08.11.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//  Первый контроллер, в котором проверяется наличие интернет для понимания откуда получать информацию (с сервера или из  архива в локальной папке). На время ожидания для пользователя загружается progressView. Потом идет переход к следующему вьюконтроллеру.

#import <UIKit/UIKit.h>


@interface SiSFirstViewController : UIViewController

- (void) showAlertWhenSiteIsNotAvaliableError;


@end
