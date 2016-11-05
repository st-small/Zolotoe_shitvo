Создаю приложение "Золотое шитье" полностью с материалами сайта www.zolotoe-shitvo.kr.ua. Проект является учебным и не несет никакой коммерческой цели (разве что, чуть-чуть... для популяризации предприятия, на котором я сейчас работаю). Логика работы приложения заключается в:

1. Загружается лаунчер с фоном и картинкой-логотипом, после него такая же, но уже с индикатором, - это уже загрузился стоиборд. Индикатор загрзки работает до тех пор, пока не загрузится контент на основной вью (контент, наполняющий SiSCollectionView).

2. Загружается второй вью, в нем есть SiSCollectionView и перечень разделов с рубриками. Работает нажатие на элемент SiSCollectionView и переводит пользователя в подробное описание товара или нажатие на рубрику, где открывается третье вью с перечнем товаров этой рубрики.

Паттерн проектирования для себя определи как MVC: будет группа классов по работе с АПИ (..............), классы модели (.................), классы контроллеров (................) и вывод самих представлений (................).

Parser the posts:

To get all posts: http://www.zolotoe-shitvo.kr.ua/wp-json/wp/v2/posts

To get posts with offset: http://www.zolotoe-shitvo.kr.ua/wp-json/wp/v2/posts?offset=

To get posts from start page with offset: http://www.zolotoe-shitvo.kr.ua/wp-json/wp/v2/posts?filter[meta_key]=offer&filter[meta_value]=1&offset=

To get all media files from one post: http://www.zolotoe-shitvo.kr.ua/wp-json/wp/v2/media?parent=6699
