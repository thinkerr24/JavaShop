/*
 * Create on 2018/9/20 by rr for java_shop project!
 * DBType:Mysql5.5
 * Five tables: user, category, product, orders, orderitem!
 */

-- Create and use database java_shop
CREATE DATABASE IF NOT EXISTS java_shop DEFAULT CHARACTER SET utf8;
USE java_shop;


-- Create tables
DROP TABLE IF EXISTS USER;
CREATE TABLE  USER (
   uid VARCHAR(40) NOT NULL PRIMARY KEY,
   username VARCHAR(20) NOT NULL,
   PASSWORD VARCHAR(20) DEFAULT NULL,
   NAME VARCHAR(20) DEFAULT NULL,
   email VARCHAR(30) DEFAULT NULL,
   telephone VARCHAR(20) DEFAULT NULL,
   birthday DATE DEFAULT NULL,
   sex VARCHAR(10) DEFAULT NULL,
   state CHAR(1) DEFAULT '0',
   CODE VARCHAR(64) DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS category;
CREATE TABLE category (
   cid VARCHAR(40) NOT NULL  PRIMARY KEY,
   cname VARCHAR(20) DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS product;
CREATE TABLE product (
  pid VARCHAR(40) NOT NULL PRIMARY KEY,
  pname VARCHAR(50) DEFAULT NULL,
  price DOUBLE DEFAULT NULL,
  pimage VARCHAR(200) DEFAULT NULL,
  pdate DATE DEFAULT NULL,
  is_hot CHAR(1) DEFAULT '1',
  pdesc VARCHAR(255) DEFAULT NULL,
  pflag INT(11) DEFAULT NULL,
  cid VARCHAR(40) DEFAULT NULL,
  CONSTRAINT product_category_fk FOREIGN KEY (cid) REFERENCES category (cid)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
   oid VARCHAR(40) NOT NULL PRIMARY KEY,
   ordertime DATETIME DEFAULT NULL,
   total DOUBLE DEFAULT NULL,
   state CHAR(1) DEFAULT '0',
   address VARCHAR(30) DEFAULT NULL,
   NAME VARCHAR(20) DEFAULT NULL,
   telephone VARCHAR(20) DEFAULT NULL,
   uid VARCHAR(40) DEFAULT NULL,
   CONSTRAINT orders_user_fk FOREIGN KEY (uid) REFERENCES USER(uid)
) ENGINE=INNODB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS orderitem;
CREATE TABLE  orderitem (
   itemid VARCHAR(40) NOT NULL  PRIMARY KEY,
   count  INT(11) DEFAULT NULL,
   subtotal DOUBLE DEFAULT NULL,
   pid  VARCHAR(40) DEFAULT NULL,
   oid  VARCHAR(40) DEFAULT NULL,
  CONSTRAINT orderitem_product_fk FOREIGN KEY (pid) REFERENCES product (pid),
  CONSTRAINT orderitem_orders_fk FOREIGN KEY (oid) REFERENCES orders (oid)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- Insert data of table category 
INSERT INTO `category` VALUES
 ('1','�ֻ�����'),
('10','�˶�����'),
('2','���԰칫'),
('3','�Ҿ߼Ҿ�'),
('4','Ьѥ���'),
('5','ͼ������'),
('6','ĸӤ��Ӥ'),
('afdba41a139b4320a74904485bdb7719','������Ʒ');

-- Insert data of table user 
INSERT INTO `user` VALUES 
('373eb242933b4f5ca3bd43503c34668b','liubei','1234567','aaa','bbb@store.com','15723689921','2015-11-04','��',1,'9782f3e837ff422b9aee8b6381ccf927bdd9d2ced10d48f4ba4b9f187edf7738'),
('3ca76a75e4f64db2bacd0974acc7c897','bb','bb','lisa','sss@store.com','15723689921','1990-02-01','��',0,'1258e96181a9457987928954825189000bae305094a042d6bd9d2d35674684e6'),
('62145f6e66ea4f5cbe7b6f6b954917d3','cc','cc','����','bbb@store.com','15723689921','2015-11-03','��',0,'19f100aa81184c03951c4b840a725b6a98097aa1106a4a38ba1c29f1a496c231'),
('c95b15a864334adab3d5bb6604c6e1fc','bbb','bbb','����','zzz@store.com','15712344823','2000-02-01','��',0,'71a3a933353347a4bcacff699e6baa9c950a02f6b84e4f6fb8404ca06febfd6f'),
('f55b7d3a352a4f0782c910b2c70f1ea4','xiaowang','7777777','С��','xiaowang@store.com','15712344823','2000-02-01','��',1,NULL);

-- Insert data of product 
INSERT INTO `product` VALUES
 ('1','С�� 4c ��׼��',1399,'products/1/c_0001.jpg','2015-11-02',1,'С�� 4c ��׼�� ȫ��ͨ ��ɫ �ƶ���ͨ����4G�ֻ� ˫��˫��',0,'1'),
 ('10','��Ϊ Ascend Mate7',2599,'products/1/c_0010.jpg','2015-11-02',1,'��Ϊ Ascend Mate7 �¹��� �ƶ�4G�ֻ� ˫��˫��˫ͨ6Ӣ�����������˱��������ܳ��˺ˣ���ѹʽָ��ʶ��!ѡ���·����ƶ����û�4G�����Լ�������軻�ţ����л���ÿ�·�����',0,'1'),
 ('11','vivo X5Pro',2298,'products/1/c_0014.jpg','2015-11-02',1,'�ƶ���ͨ˫4G�ֻ� 3G�˴�� ����ס���������������+�������ĸˡ�������3G�����ڴ桤˫2.5D���沣��������ʶ����',0,'1'),
 ('12','Ŭ���ǣ�nubia��My ������',1799,'products/1/c_0013.jpg','2015-11-02',0,'Ŭ���ǣ�nubia��My ������ ���� �ƶ���ͨ4G�ֻ� ˫��˫������11���µ�����100�������������ٳ�磡���������ȫ�����飡',0,'1'),
 ('13','��Ϊ ��â4',2499,'products/1/c_0012.jpg','2015-11-02',1,'��Ϊ ��â4 ���ؽ� ȫ��ͨ��4G�ֻ� ˫��˫���������� 2.5D������ ָ�ƽ��� ��ѧ����',0,'1'),
 ('14','vivo X5M',1799,'products/1/c_0011.jpg','2015-11-02',0,'vivo X5M �ƶ�4G�ֻ� ˫��˫�� ���Ľ𡾹�������������+�������ĸˡ�5.0Ӣ�������ʾ���˺�˫��˫����Hi-Fi�ƶ�KTV',0,'1'),
 ('15','Apple iPhone 6 (A1586)',4288,'products/1/c_0015.jpg','2015-11-02',1,'Apple iPhone 6 (A1586) 16GB ��ɫ �ƶ���ͨ����4G�ֻ�����ʡ�������ʡ����������ͷѰ棬�����ͻ��ѣ��������Żݣ�����4G���磬������ͨ4G��',0,'1'),
 ('16','��Ϊ HUAWEI Mate S �����',4200,'products/1/c_0016.jpg','2015-11-03',0,'��Ϊ HUAWEI Mate S ����� �ֻ� ����� �ƶ���ͨ˫4G(����)�������ۼ���30Ԫ������������͵�Դ+��ˮ��+�����ֻ�֧�ܣ����Ż�����mate7������',0,'1'),
 ('17','����(SONY) E6533 Z3+',4099,'products/1/c_0017.jpg','2015-11-02',0,'����(SONY) E6533 Z3+ ˫��˫4G�ֻ� ��ˮ���� ����������z3רҵ��ˮ 2070������ �ƶ���ͨ˫4G',0,'1'),
 ('18','HTC One M9+',3499,'products/1/c_0018.jpg','2015-11-02',0,'HTC One M9+��M9pw�� ������ �ƶ���ͨ˫4G�ֻ�5.2Ӣ�磬8��CPU��ָ��ʶ��UltraPixel������ǰ�����+2000��/200�����˫��ͷ�����������������ϲ���ϣ�',0,'1'),
 ('19','HTC Desire 826d 32G �����',1469,'products/1/c_0020.jpg','2015-11-02',1,'����1300��+UltraPixel������ǰ������ͷ+��˫��ǰ��������+5.5Ӣ�硾1080p��������',0,'1'),
 ('2','���� AXON',2899,'products/1/c_0002.jpg','2015-11-05',1,'���� AXON ��� mini ѹ������ B2015 ������ �ƶ���ͨ����4G ˫��˫��',0,'1'),
 ('20','С�� ����2A ��ǿ�� ��ɫ',549,'products/1/c_0019.jpg','2015-11-02',0,'������2GB �ڴ�+16GB������4G˫��˫������о 4 �� 1.5GHz ��������',0,'1'),
 ('21','���� ����note2 16GB ��ɫ',999,'products/1/c_0021.jpg','2015-11-02',0,'�ֻ����������꼴ֹ��5.5Ӣ��1080P�ֱ�����Ļ��64λ�˺�1.3GHz��������1300����������ͷ��˫ɫ��˫����ƣ�',0,'1'),
 ('22','���� Galaxy S5 (G9008W) ��ҫ��',1999,'products/1/c_0022.jpg','2015-11-02',1,'5.1Ӣ��ȫ������������2.5GHz�ĺ˴�������1600������',0,'1'),
 ('23','sonim XP7700 4G�ֻ�',1699,'products/1/c_0023.jpg','2015-11-09',1,'���������ֻ� �ƶ�/��ͨ˫4G ��ȫ �ڻ�ɫ ˫4G��������IP69 30�쳤���� 3�׷�ˮ��ˤ ����',0,'1'),
 ('24','Ŭ���ǣ�nubia��Z9��Ӣ�� ��ɫ',3888,'products/1/c_0024.jpg','2015-11-02',1,'�ƶ���ͨ����4G�ֻ� ˫��˫���������ޱ߿򣡽�ɫ���棡4GB+64GB���ڴ棡',0,'1'),
 ('25','Apple iPhone 6 Plus (A1524) 16GB ��ɫ',4988,'products/1/c_0025.jpg','2015-11-02',0,'Apple iPhone 6 Plus (A1524) 16GB ��ɫ �ƶ���ͨ����4G�ֻ� Ӳ�� Ӳʵ��',0,'1'),
 ('26','Apple iPhone 6s (A1700) 64G õ���ɫ',6088,'products/1/c_0026.jpg','2015-11-02',0,'Apple iPhone 6 Plus (A1524) 16GB ��ɫ �ƶ���ͨ����4G�ֻ� Ӳ�� Ӳʵ��',0,'1'),
 ('27','���� Galaxy Note5��N9200��32G��',5388,'products/1/c_0027.jpg','2015-11-02',0,'�콢���ͣ�5.7Ӣ�������4+32G�ڴ棡��һ����SPen���Ż��ĸ���ָ������߳��壡',0,'1'),
 ('28','���� Galaxy S6 Edge+��G9280��32G�� �����',5999,'products/1/c_0028.jpg','2015-11-02',0,'���ƶ���Դ+���ĸ�+����OTG����U��+���߳����+͸��������',0,'1'),
 ('29','LG G4��H818���մɰ� ���ʰ�',2978,'products/1/c_0029.jpg','2015-11-02',0,'��������ԣ�F1.8���Ȧ1600���������ͷ��5.5Ӣ��2K����3G+32G�ڴ棬LG����콢����',0,'1'),
 ('3','��Ϊ��ҫ6',1499,'products/1/c_0003.jpg','2015-11-02',0,'��ҫ 6 (H60-L01) 3GB�ڴ��׼�� ��ɫ �ƶ�4G�ֻ�',0,'1'),
 ('30','΢��(Microsoft) Lumia 640 LTE DS (RM-1113)',999,'products/1/c_0030.jpg','2015-11-02',0,'΢���׿�˫��˫��˫4G�ֻ���5.0Ӣ����������˫��˫��˫4G��',0,'1'),
 ('31','�곞��acer��ATC705-N50 ̨ʽ����',2399,'products/1/c_0031.jpg','2015-11-02',0,'����ֱ������ǧ���٣�Ʒ�ʺ곞���ػ���Ϯ���αؿ��11.11����������ˣ�',0,'2'),
 ('32','Apple MacBook Air MJVE2CH/A 13.3Ӣ��',6688,'products/1/c_0032.jpg','2015-11-02',0,'�����ʼǱ����� 128GB ����',0,'2'),
 ('33','���루ThinkPad�� �ᱡϵ��E450C(20EH0001CD)',4199,'products/1/c_0033.jpg','2015-11-02',0,'���루ThinkPad�� �ᱡϵ��E450C(20EH0001CD)14Ӣ��ʼǱ�����(i5-4210U 4G 500G 2G���� Win8.1)',0,'2'),
 ('34','���루Lenovo��С��V3000�����',4599,'products/1/c_0034.jpg','2015-11-02',0,'14Ӣ�糬���ʼǱ����ԣ�i7-5500U 4G 500G+8G SSHD 2G���� ȫ����������ɫ��1000�p100�����������ȫ������ɨ3�죡',0,'2'),
 ('35','��˶��ASUS������ϵ��R557LI',3799,'products/1/c_0035.jpg','2015-11-02',0,'15.6Ӣ��ʼǱ����ԣ�i5-5200U 4G 7200ת500G 2G���� D�� ���� Win8.1 ��ɫ��',0,'2'),
 ('36','��˶��ASUS��X450J',4399,'products/1/c_0036.jpg','2015-11-02',0,'14Ӣ��ʼǱ����� ��i5-4200H 4G 1TB GT940M 2G���� ����4.0 D�� Win8.1 ��ɫ��',0,'2'),
 ('37','������DELL����Խ ��ϻ3000ϵ��',3299,'products/1/c_0037.jpg','2015-11-03',0,' Ins14C-4528B 14Ӣ��ʼǱ���i5-5200U 4G 500G GT820M 2G���� Win8����',0,'2'),
 ('38','����(HP)WASD ��Ӱ����',5499,'products/1/c_0038.jpg','2015-11-02',0,'15.6Ӣ����Ϸ�ʼǱ�����(i5-6300HQ 4G 1TB+128G SSD GTX950M 4G���� Win10)',0,'2'),
 ('39','Apple �䱸 Retina ��ʾ���� MacBook',10288,'products/1/c_0039.jpg','2015-11-02',0,'Pro MF840CH/A 13.3Ӣ������ʼǱ����� 256GB ����',0,'2'),
 ('4','���� P1',1999,'products/1/c_0004.jpg','2015-11-02',0,'���� P1 16G ������ �ƶ���ͨ4G�ֻ����5���ӣ�ͨ��3Сʱ���Ƽ�Դ�ڳ�Խ��Ʒ��Դ�ڳ���5000mAh���أ��߶�������䣡',0,'1'),
 ('40','��е������MECHREVO��MR X6S-M',6599,'products/1/c_0040.jpg','2015-11-02',0,'15.6Ӣ����Ϸ��(I7-4710MQ 8G 64GSSD+1T GTX960M 2G���� IPS�� WIN7)��ɫ',0,'2'),
 ('41','���ۣ�HASEE�� ս��K660D-i7D2',5499,'products/1/c_0041.jpg','2015-11-02',0,'15.6Ӣ����Ϸ��(i7-4710MQ 8G 1TB GTX960M 2G���� 1080P)��ɫ',0,'2'),
 ('42','΢�ǣ�MSI��GE62 2QC-264XCN',5999,'products/1/c_0042.jpg','2015-11-02',0,'15.6Ӣ����Ϸ�ʼǱ����ԣ�i5-4210H 8G 1T GTX960MG DDR5 2G ������̣���ɫ',0,'2'),
 ('43','����ThundeRobot��G150S',5499,'products/1/c_0043.jpg','2015-11-02',0,'15.6Ӣ����Ϸ�� ( i7-4710MQ 4G 500G GTX950M 2G���� ��������ȫ������) ��',0,'2'),
 ('44','���գ�HP���ᱡϵ�� HP',3199,'products/1/c_0044.jpg','2015-11-02',0,'15-r239TX 15.6Ӣ��ʼǱ����ԣ�i5-5200U 4G 500G GT820M 2G���� win8.1��������',0,'2'),
 ('45','δ�����ࣨTerrans Force��T5',10999,'products/1/c_0045.jpg','2015-11-02',0,'15.6Ӣ����Ϸ����i7-5700HQ 16G 120G��̬+1TB GTX970M 3G GDDR5���ԣ���',0,'2'),
 ('46','������DELL��Vostro 3800-R6308 ̨ʽ����',3199,'products/1/c_0046.jpg','2015-11-02',0,'��i3-4170 4G 500G DVD �������ŷ��� Win7����',0,'2'),
 ('47','���루Lenovo��H3050 ̨ʽ����',5099,'products/1/c_0047.jpg','2015-11-11',0,'��i5-4460 4G 500G GT720 1G���� DVD ǧ������ Win10��23Ӣ��',0,'2'),
 ('48','Apple iPad mini 2 ME279CH/A',1888,'products/1/c_0048.jpg','2015-11-02',0,'���䱸 Retina ��ʾ�� 7.9Ӣ�� 16G WLAN ���� ��ɫ��',0,'2'),
 ('49','С�ף�MI��7.9Ӣ��ƽ��',1299,'products/1/c_0049.jpg','2015-11-02',0,'WIFI 64GB��NVIDIA Tegra K1 2.2GHz 2G 64G 2048*1536����Ĥ�� 800W����ɫ',0,'2'),
 ('5','Ħ������ moto x��x+1��',1799,'products/1/c_0005.jpg','2015-11-01',0,'Ħ������ moto x��x+1��(XT1085) 32GB ��Ȼ�� ȫ��ͨ4G�ֻ�11��11�죡MOTO X���ػ���Ϯ��1699Ԫ��������ת�ڿƼ�����Ȼ���ʣ�ԭ������ϵͳ��',0,'1'),
 ('50','Apple iPad Air 2 MGLW2CH/A',2299,'products/1/c_0050.jpg','2015-11-12',0,'��9.7Ӣ�� 16G WLAN ���� ��ɫ��',0,'2'),
 ('6','���� MX5 16GB ����ɫ',1799,'products/1/c_0006.jpg','2015-11-02',0,'���� MX5 16GB ����ɫ �ƶ���ͨ˫4G�ֻ� ˫��˫����ԭ���ֻ�Ĥ+������+������5.5Ӣ�����Ļ��3G�����ڴ棬2070��+500����������ͷ������ʡ�������ʡ��',0,'1'),
 ('7','���� Galaxy On7',1398,'products/1/c_0007.jpg','2015-11-14',0,'���� Galaxy On7��G6000����С�� ��ɫ ȫ��ͨ4G�ֻ� ˫��˫����Ʒ�������У���������ǧԪ������5.5Ӣ����������1300+500W���أ�����Ӯ30Ԫ����ȯ��',0,'1'),
 ('8','NUU NU5',1288,'products/1/c_0008.jpg','2015-11-02',0,'NUU NU5 16GB �ƶ���ͨ˫4G�����ֻ� ˫��˫�� ɹ������ ��������Ʒ�� 2.5D����ǰ��ֻ����� ��������ֻ���+�ֻ���Ĥ ɹ�����ƶ���Դ+��������',0,'1'),
 ('9','���ӣ�Letv����1pro��X800��',2299,'products/1/c_0009.jpg','2015-11-02',0,'���ӣ�Letv����1pro��X800��64GB ��ɫ �ƶ���ͨ4G�ֻ� ˫��˫��������̬UI+5.5Ӣ��2K��+��ͨ8�˴�����+4GB�����ڴ�+64GB�洢+1300������ͷ��',0,'1');


