
--------------------------------------------------------------------------------
                             -- DROP 四大服務訂單 --
--------------------------------------------------------------------------------
------DROP 派車SEQ------
DROP SEQUENCE carorder_seq;
DROP SEQUENCE cardetail_seq;
------DROP 派車SEQ------

--------DROP 送餐SEQ-----
DROP SEQUENCE mealOrderDetail_seq;
DROP SEQUENCE mealOrder_seq;
--------DROP 送餐SEQ-----

--------DROP 長照SEQ-----
DROP SEQUENCE HC_ORDER_DETAIL_NO_SEQ;
DROP SEQUENCE HC_ORDER_NO_SEQ;
--------DROP 長照SEQ-----

---------DROP 商城SEQ-------------
DROP sequence FORSHOPORDER;
DROP sequence FORSHOPITEM;
DROP sequence FORPROMOTION;
----------DROP 商城SEQ-------------

----------------DROP 商城TABLE--------------
DROP TABLE ORDERDETAIL;
DROP TABLE SHOPORDER;
----------------DROP 商城TABLE--------------

--------DROP 長照TABLE---------------------
DROP TABLE HC_ORDER_DETAIL;
DROP TABLE HC_ORDER_MASTER;
--------DROP 長照TABLE----------------------

--------DROP 送餐TABLE----------------------
DROP TABLE MEAL_ORDER_DETAIL;
DROP TABLE MEAL_ORDER;
--------DROP 送餐TABLE----------------------


--------------------------------------------------------------------------------
                                -- 商城訂單 --
--------------------------------------------------------------------------------

---------------------自增主鍵1(商品編號用)-----------------------------

create sequence FORSHOPITEM
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

---------------------自增主鍵2(促銷編號用)-----------------------------
create sequence FORPROMOTION
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

---------------------自增主鍵3(商品訂單專用)-----------------------------
create sequence FORSHOPORDER
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;


----------------商品訂單----------------------
CREATE TABLE SHOPORDER (
ORDERNO VARCHAR2(15) PRIMARY KEY,
MEM_NO VARCHAR2(10),
ORDER_DATE TIMESTAMP,
CUSTOMER_ADDRESS VARCHAR2(100),
CUSTOMER_PHNOE VARCHAR2(15),
CUSTOMER_NAME VARCHAR2(80),
CONSTRAINT FK_MEMBERNO  FOREIGN KEY (MEM_NO) REFERENCES MEMBER(MEM_NO)
);



----------------訂單明細----------------------
CREATE TABLE ORDERDETAIL (
ORDERNO      VARCHAR2(15) ,--20171023修改過--
ITEMNO         NUMBER(10),
ORDERCOUNT NUMBER(5),
constraint PR_SUPPLIER_EX_OR primary key(ORDERNO, ITEMNO),
CONSTRAINT FK_ORDERNO  FOREIGN KEY (ORDERNO) REFERENCES SHOPORDER(ORDERNO),
CONSTRAINT FK_NAME  FOREIGN KEY (ITEMNO) REFERENCES ShoppingMall(ITEMNO)
);

--------------------------商城商品假資料-----------------------------
INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,10,499,1,1,'【Daiwa】日本製通用輔助筷','長輩年紀漸長，手指力量退化，或者因為中風無法用慣用手執起筷子進食，樂齡網推薦此款筷子，可以讓其更容易自行進食而無需人餵食。連用不慣筷子的外國人亦可輕易使用本筷子而享用美食佳餚。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,20,350,1,1,'【Forsound】第三代防痔型凝膠坐墊','很多年長者皆有排便不順的困擾，「有痔難伸」更是很多年長者的共同問題，有沒有一個好的座墊可以減輕坐下時的不便呢?樂齡網為您介紹一款外銷德、日的新專利減壓坐墊，特殊的造型及SGEL凝膠與人體工學的結合，讓您從此不再如坐針氈。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,299,1,1,'Hi-Bone雙模式(骨傳導+空氣傳導)高感度耳機','您有多久沒有聽到優美的音樂? 家中是否有長者還不到要配戴助聽器，但是與人溝通不僅旁人要用較大的音量，而自己本身也聽的很辛苦，在溝通不良的狀況下，往往因此讓老人家逐漸封閉。對於有聽損的樂齡族而言，一定渴望再聆聽到美妙動人的音樂，享受沈浸在音樂中那美好的氛圍。樂齡網幫您實現願望，我們推薦您一款最新科技的雙模式(骨傳導+空氣傳導)高感度耳機，讓您再度感受到豐富的樂音，讓生命再度活躍起來。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,199,1,1,'日本製室內帽','樂齡族長時間待在冷氣房內或者外出寒流來襲，一定要注意頭部的保暖，稍一不慎就會受涼。樂齡網推薦一款日本製的室內帽，可有效保持頭部溫暖，對於髮量稀少或有掉髮困擾的銀髮族有也遮掩的效果。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,899,1,1,'眼鏡式放大鏡 2.3倍','隨著年齡增長，視力越來越模糊不清，這時需要一個不占用雙手的放大鏡來閱讀或工作，此款商品將是您的最佳選擇。戴眼鏡或老花眼鏡也可再戴上此放大鏡，不用再一手拿著放大鏡，一手拿著書。用雙眼看，視野更開闊!');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【LifePlus】開門式無障礙浴缸','家中長輩是不是很久沒有享受泡澡的幸福滋味? 一想到要腳跨過那高起的浴缸壁，便讓長輩打消泡澡的念頭。
※樂齡網台北民生店 (台北市民生東路五段91號)有實體展示，歡迎前往體驗
※本產品價格不含安裝施工費用
※台中市以北免運(偏遠山區除外)，以南、及花東偏遠地區運費需另計，請來電詢問喔');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【NISHIKI】女用防漏安心褲 - 吸水量150cc (輕失禁適用)','您有因為大笑、咳嗽或提重物，有不自主的漏尿情形嗎? 是否需要墊個護墊或衛生紙才敢外出? 其實熟年女性的漏尿情形是一個很普遍的現象，根據國民健康局96年調查，國人54歲以上女性每4位婦女中，就有1位有尿失禁困擾，65歲以上女性更是高達1/3，由於國人較為保守，大部分皆隱忍日常生活中因尿失禁的困擾。 樂齡網推薦您一款由日本手工精製，針對輕失禁婦女所設計的防漏內褲，吸水、消臭又輕薄，讓您隨時保持清爽，生活品質得以改善。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【SWANY】Walking Bag 134 復古風行李箱 (咖啡色)','日本行李箱大廠 - SWANY專為熟齡族群所設計的日用行李箱《Walking Bag》，符合人體工學，特殊的滑輪軸承設計超靜音，可360度旋轉，任意變換行走方向，無須上潤滑油即可保持 輪子的平順無聲。
可分離式的超輕量包，行李箱可變身為手提包，讓您到處趴趴走，不用擔心厚重的行李讓您的手臂過度疲勞。休息是為了走更長遠的路。可以讓您更省力，讓您雲遊四海無負擔!');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'樂齡室內福祉拖鞋','一般室內平底拖鞋由於整個鞋底機觸地面，容易造成跌倒。選購舒適的防跌、防滑鞋是老人做好居家防護的首選。為迎接高齡化社會的來臨，本公司自日本引進專為銀髮族人士設計的”福祉室內鞋”。造福年長者，創造健康舒適的家居生活。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【+VENTURE】多功能長效型速配鼎熱敷墊(未滅菌)家用型KB-243','衛字核可字號：衛部醫器製壹字第005451號');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【Mr. Pad】超柔軟記憶泡棉地墊 40X60cm','冬天快來了，長者下床若能踏在溫暖止滑的地墊，不僅防止夜晚燈光微弱滑倒的風險，而且也可防止足部血管突然緊縮的風險。
本地墊質感豐厚，給予雙腳溫柔的呵護，適用於浴室門口、廚房、玄關，茶几旁；產品使用SBR防滑底面加強止滑，不易滑動，結實耐用不掉毛，可搭配洗衣網洗滌，清洗方法簡單又省時，讓您對它愛不釋手喔~');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'SHIMA銀髮族購物散步車，10/5-10/31買就送五段調高傘，送完為止!','由日本老人車製造大廠 - 島製作所，專為銀髮族而設計的購物散步車，方便銀髮族外出購物，到超市只要將菜藍放在車上即可開始購物，買完了放在本車的置物藍中，即可將購買物品推回家，不用提重物，走累了還可坐下休息。
無論您是要公園散步、逛街購物，還是要休閒運動都方便、省力及及安全，是一項非常貼心的銀髮族商品。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【Famica】睡眠專用床護欄','有些銀髮長者由於各種因素，從床上起身或躺下時常會感到很吃力，現在有了這一款床邊護欄，除了為長輩的睡眠安全加分，起身時可以更輕鬆了，讓老人家從床上起身更加有支撐力。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【Ryka】RKF1272M1600女用健走鞋','你也是個喜愛休閒健走，到處趴趴造的銀髮族嗎？
運動是維持活力的最佳妙方，但如何挑選一雙避免運動傷害的鞋子可是非常重要的。
尤其對於長者來說，寬楦不束縛、避震緩衝等等，都是挑選的重點。
樂齡網推薦此款【Ryka】健走休閒鞋，
品牌創辦者因為飽受運動之苦，親自投入運動鞋研發，
特別針對女性的肌肉與骨骼結構，設計能夠避免運動傷害的專屬鞋款，
無論是要公園快走或運動健行都適合喔！');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【來可】側邊馬桶起身扶手','對於有些長輩來說，由於膝蓋、腰部的退化無力，要從馬桶站起來是相當辛苦的，而且在這顛沛起身的過程當中，還潛藏著跌倒的危險。
樂齡網推薦一款【來可側邊馬桶起身扶手】，不須安裝，直接擺放在廁所馬桶側邊，讓長輩要站起來時有所依靠，您貼心、他(她)窩心、全家都放心！');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'日本GREEN BELL腳指甲專用指甲剪','幫老人家剪腳指甲是不是很困難?

年長者由於細胞的新陳代新及再生能力退化，構成指甲的角質層的代謝也會減慢，導致角質層加厚，指甲變的堅硬難剪，尤其腳指甲若沒有泡軟，真的很難剪。 日本專業指甲剪大廠-GREEN BELL，便因此而開發了一系列專為厚指甲、變形指甲而設計的指甲剪，無論是自用或要幫老人家剪腳指甲皆方便多了。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【KeyCatch】磁力收納器','家裡大小事如麻，總是忘記鑰匙放在哪？
年長記憶力退化，緊急時刻就是找不到

推薦給您極簡收納的最佳方案【KeyCatch】磁力收納器
只要三秒鐘黏貼，家中任何平滑表面皆能收納，帶給您無限便利！');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'【MOTORIZED】活力手足健身機 (可正反轉)','銀髮族若能長期保持運動習慣，必會對身心產生極大的助益，本健身器可坐臥兩用，手腳皆可運動。 不用出力，本健身器會以電動的方式帶動您的手腳活動，讓您輕鬆自在達到運動效果。');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'相片輔記助聽電話','電話聽不清楚嗎? 怕記不住電話嗎? 按鍵太小看不清嗎? 不用擔心，本電話一次解決您所有問題!!!孝親最佳贈禮!');

INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES)  
VALUES (FORSHOPITEM.Nextval,50,100,1,1,'SHIMA銀髮族購物散步車，10/5-10/31買就送五段調高傘，送完為止!','由日本老人車製造大廠 - 島製作所，專為銀髮族而設計的購物散步車，方便銀髮族外出購物，到超市只要將菜藍放在車上即可開始購物，買完了放在本車的置物藍中，即可將購買物品推回家，不用提重物，走累了還可坐下休息。
無論您是要公園散步、逛街購物，還是要休閒運動都方便、省力及及安全，是一項非常貼心的銀髮族商品。');

--
--INSERT INTO ShoppingMall(ITEMNO, STOCK, PRICE, STATE, CLASSNO, NAME, DES,PICTURE1,PICTURE2,PICTURE3)  
--VALUES (FORSHOPITEM.Nextval,50,100,1,1,'鐵牛運功散2','強身健體2',?,?,?);

----------------商品訂單明細假資料(未來購物車新增以此方法為基底)------------------------------

INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000001',6,'0'),1,15);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000001',6,'0'),5,4);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000001',6,'0'),3,5);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000001',6,'0'),2,2);

INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000002',6,'0'),1,7);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000002',6,'0'),5,5);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000002',6,'0'),6,1);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000002',6,'0'),3,1);

INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),1,5);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),2,7);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),3,9);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),4,10);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),5,15);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000003',6,'0'),6,20);

INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000004',6,'0'),3,1);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000004',6,'0'),5,1);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000004',6,'0'),7,1);

INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000005',6,'0'),4,1);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000005',6,'0'),7,5);
INSERT INTO ORDERDETAIL (ORDERNO,ITEMNO,ORDERCOUNT) VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD('000005',6,'0'),2,10);

COMMIT;


--------------------------------------------------------------------------------
                                -- 長照訂單 --
--------------------------------------------------------------------------------
-------------------------------- 長照 -------------------------------------------
--------CREATE 長照SEQ-----
CREATE SEQUENCE HC_ORDER_NO_SEQ
INCREMENT BY 1
START WITH 500001
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE HC_ORDER_DETAIL_NO_SEQ
INCREMENT BY 1
START WITH 600001
NOMAXVALUE
NOCYCLE
NOCACHE;


CREATE TABLE HC_ORDER_MASTER (
ORDER_NO VARCHAR2(15) PRIMARY KEY,
MEM_NO VARCHAR2(10),
ORDER_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CARED_NO VARCHAR2(10),
ORDER_STATUS VARCHAR2(15),
CONSTRAINT FK_MEM_NO FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO),
CONSTRAINT FK_CARED_NO FOREIGN KEY (CARED_NO) REFERENCES THECARED (CARED_NO)
);

CREATE TABLE HC_ORDER_DETAIL (
ORDER_DETAIL_NO VARCHAR2 (15) PRIMARY KEY,
ORDER_NO VARCHAR2(15),
SERVICE_DATE DATE,
SERVICE_TIME VARCHAR2(15),
EMP_NO VARCHAR2(7),
ORDER_DEDIAL_STATUS VARCHAR2(15),
CONSTRAINT FK_ORDER_NO1 FOREIGN KEY (ORDER_NO) REFERENCES HC_ORDER_MASTER (ORDER_NO),
CONSTRAINT FK_EMP_NO2 FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE (EMP_NO),
constraint CSTNT_HC_ORDER_DETAIL unique (ORDER_NO, SERVICE_DATE, SERVICE_TIME,EMP_NO)
);


INSERT INTO HC_ORDER_MASTER (ORDER_NO,MEM_NO,ORDER_DATE,CARED_NO,ORDER_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_NO_SEQ.NEXTVAL,6,'0'),'MEM0002',CURRENT_TIMESTAMP,'CRD0001','未確認');
INSERT INTO HC_ORDER_MASTER (ORDER_NO,MEM_NO,ORDER_DATE,CARED_NO,ORDER_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_NO_SEQ.NEXTVAL,6,'0'),'MEM0002',CURRENT_TIMESTAMP,'CRD0002','已確認');
INSERT INTO HC_ORDER_MASTER (ORDER_NO,MEM_NO,ORDER_DATE,CARED_NO,ORDER_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_NO_SEQ.NEXTVAL,6,'0'),'MEM0002',CURRENT_TIMESTAMP,'CRD0001','服務中');
INSERT INTO HC_ORDER_MASTER (ORDER_NO,MEM_NO,ORDER_DATE,CARED_NO,ORDER_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_NO_SEQ.NEXTVAL,6,'0'),'MEM0002',CURRENT_TIMESTAMP,'CRD0002','已完成');
INSERT INTO HC_ORDER_MASTER (ORDER_NO,MEM_NO,ORDER_DATE,CARED_NO,ORDER_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_NO_SEQ.NEXTVAL,6,'0'),'MEM0003',CURRENT_TIMESTAMP,'CRD0003','已取消');



INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500001',6,'0'),to_date('2017/10/17','yyyy/mm/dd'),'上午','EMP0001','已完成');
INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500002',6,'0'),to_date('2017/10/17','yyyy/mm/dd'),'上午','EMP0002','已完成');
INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500003',6,'0'),to_date('2017/10/17','yyyy/mm/dd'),'上午','EMP0003','已完成');
INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500004',6,'0'),to_date('2017/10/17','yyyy/mm/dd'),'上午','EMP0004','已完成');
INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500005',6,'0'),to_date('2017/11/17','yyyy/mm/dd'),'上午','EMP0005','未完成');
INSERT  INTO HC_ORDER_DETAIL (ORDER_DETAIL_NO,ORDER_NO,SERVICE_DATE,SERVICE_TIME,EMP_NO,ORDER_DEDIAL_STATUS)
VALUES(TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD(HC_ORDER_DETAIL_NO_SEQ.NEXTVAL,6,'0'),TO_CHAR(SYSDATE,'yyyymmdd')||'-'||LPAD('500005',6,'0'),to_date('2017/11/18','yyyy/mm/dd'),'上午','EMP0005','未完成');

COMMIT;


--------------------------------------------------------------------------------
                                -- 送餐訂單 --
--------------------------------------------------------------------------------

-------------------------------- 送餐 -------------------------------------------

CREATE TABLE MEAL_ORDER(
MO_NO VARCHAR2(15) PRIMARY KEY NOT NULL,
MEM_NO VARCHAR2(10) NOT NULL,
MO_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
MO_STATUS VARCHAR2(15) NOT NULL,
RCPT_NAME VARCHAR2(15) NOT NULL,
RCPT_ADD VARCHAR2(100) NOT NULL,
RCPT_PHONE VARCHAR2(10) NOT NULL,
CONSTRAINT MEAL_ORDER_MEM_NO_FK FOREIGN KEY (MEM_NO) REFERENCES MEMBER(MEM_NO)
);
 
--送餐訂單自增主鍵--
CREATE SEQUENCE mealOrder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;

--送餐訂單明細--
CREATE TABLE MEAL_ORDER_DETAIL(
MO_DETAIL_NO VARCHAR2(15) PRIMARY KEY NOT NULL,
MO_NO VARCHAR2(15) NOT NULL,
DELIVER_DATE DATE NOT NULL,
DELIVER_TIME VARCHAR2(15) NOT NULL,
SM_NO NUMBER(10) NULL,
ORDER_QTY NUMBER(5) NOT NULL,
CONSTRAINT MO_DET_MO_NO_FK FOREIGN KEY (MO_NO) REFERENCES MEAL_ORDER(MO_NO),
CONSTRAINT MO_DET_SM_NO_FK FOREIGN KEY (SM_NO) REFERENCES SET_MEAL(SM_NO)
);
 
 
--送餐訂單明細自增主鍵--
CREATE SEQUENCE mealOrderDetail_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE;


--新曾送餐訂單--
INSERT INTO MEAL_ORDER(MO_NO,MEM_NO,MO_STATUS,RCPT_NAME,RCPT_ADD,RCPT_PHONE)
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrder_seq.NEXTVAL),6,'0'),'MEM0001','未處理','三井壽','桃園市中壢區中大路300號','0987390369');
INSERT INTO MEAL_ORDER(MO_NO,MEM_NO,MO_STATUS,RCPT_NAME,RCPT_ADD,RCPT_PHONE)
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrder_seq.NEXTVAL),6,'0'),'MEM0002','未處理','牧神一','桃園市中壢區中大路300號','0987390369');


--新增送餐訂單明細--
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000001',to_date('2017-10-16', 'yyyy-mm-dd'),'早餐',10,1);
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000001',to_date('2017-10-17', 'yyyy-mm-dd'),'早餐',10,1);
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000001',to_date('2017-10-18', 'yyyy-mm-dd'),'早餐',10,1);
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000002',to_date('2017-10-20', 'yyyy-mm-dd'),'午晚餐',20,1);
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000002',to_date('2017-10-21', 'yyyy-mm-dd'),'午晚餐',20,1);
INSERT INTO MEAL_ORDER_DETAIL
VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(mealOrderDetail_seq.NEXTVAL),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||'000002',to_date('2017-10-23', 'yyyy-mm-dd'),'午晚餐',20,1);


--------------------------------------------------------------------------------
                             -- 派車訂單 --
--------------------------------------------------------------------------------

CREATE SEQUENCE carorder_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE cardetail_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

commit;

  ------------------------------------------------------------------------------
 CREATE TABLE CAR_ORDER(
 ORDER_NO                  VARCHAR2(15) NOT NULL,
 MEM_NO                    VARCHAR2(10) NOT NULL, 
 ORDER_DATE                TIMESTAMP(6), 
 ORDER_STATUS              VARCHAR2(15) NOT NULL, 
 
 CONSTRAINT ORDER_NO_PRIMARY_KEY PRIMARY KEY (ORDER_NO),
 CONSTRAINT CAR_ORDER_MEM_FK FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO));
 ------------------------------------------------------------------------------
 CREATE TABLE CAR_DETAIL(
 DETAIL_NO                VARCHAR2(15) NOT NULL,
 ORDER_NO                 VARCHAR2(15) NOT NULL,
 VEHICLE_NO               NUMBER(10)   NOT NULL,
 DETAIL_DATE              DATE         NOT NULL,
 DETAIL_TIME              VARCHAR2(15) NOT NULL,
 PASSENGER_NAME           VARCHAR2(15) NOT NULL,
 PASSENGER_PHONE          NUMBER(10)   NOT NULL,
 GETINTO_ADDRESS          VARCHAR2(100)NOT NULL,
 ARRIVAL_ADDRESS          VARCHAR2(100)NOT NULL,
 SENDCAR_STATUS           VARCHAR2(15) NOT NULL,
 
 CONSTRAINT DETAIL_NO_PRIMARY_KEY PRIMARY KEY (DETAIL_NO),
 CONSTRAINT DETAIL_VEHICLE_FK FOREIGN KEY (VEHICLE_NO)REFERENCES VEHICLE (VEHICLE_NO),
 CONSTRAINT DETAIL_CARORDER_FK FOREIGN KEY(ORDER_NO) REFERENCES CAR_ORDER(ORDER_NO));
  ------------------------------------------------------------------------------

commit;
 
--假資料建立:派車訂單-------------------------------------------------------------------
INSERT INTO CAR_ORDER　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(CARORDER_SEQ.Nextval),6,'0'),'MEM0001',CURRENT_TIMESTAMP,'A');
INSERT INTO CAR_ORDER　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(CARORDER_SEQ.Nextval),6,'0'),'MEM0002',CURRENT_TIMESTAMP,'A');
INSERT INTO CAR_ORDER　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(CARORDER_SEQ.Nextval),6,'0'),'MEM0003',CURRENT_TIMESTAMP,'A');
commit;
--假資料建立:派車明細-------------------------------------------------------------------
INSERT INTO CAR_DETAIL　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),1001,TO_DATE('2017/10/25','YYYY/MM/DD'),'O','李興隆',0963117220,'桃園市中壢區中大路300號','桃園市平鎮區廣泰路77號','A');
INSERT INTO CAR_DETAIL　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),1001,TO_DATE('2017/10/25','YYYY/MM/DD'),'M','黃建業',0963117220,'台中市南屯區文心路一段521號','台中市中區柳川東路三段36號','B');
INSERT INTO CAR_DETAIL　VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(cardetail_seq.Nextval),6,'0'),1001,TO_DATE('2017/10/25','YYYY/MM/DD'),'A','陳宛婷',0963117220,'高雄市三民區建國二路320號','高雄市新興區中山一路14之27號','C');

commit;