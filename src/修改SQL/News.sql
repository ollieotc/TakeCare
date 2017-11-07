

--------------------------------------------------------------------------------
                             -- Drop 保健資訊 & 最新消息 --
--------------------------------------------------------------------------------

DROP TABLE HEALTHNEWSDETAIL;
DROP SEQUENCE HEALTHNO_SEQ;

DROP TABLE NEWSDETAIL;
DROP SEQUENCE NEWSNO_SEQ;


--------------------------------------------------------------------------------
                             -- 建立 最新資訊 --
--------------------------------------------------------------------------------

---------------------------------  自增主鍵 -------------------------------------
--------- 1. 保健消息
CREATE SEQUENCE HEALTHNO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------- 2. 最新消息
CREATE SEQUENCE NEWSNO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-------------------- 最新資訊 NEWSDETAIL -----------------------


CREATE TABLE NEWSDETAIL(
 NEWSNO         VARCHAR2(15)   NOT NULL,
 NEWSTITLE      VARCHAR2(200) NOT NULL,
 NEWSINTRO      CLOB,
 EMP_NO         VARCHAR2(10)   NOT NULL,
 COVERPIC       BLOB,
 NEWSPIC1       BLOB,
 NEWSPIC2       BLOB,
 NEWSDATE       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 STATUS			VARCHAR2(15)  NOT NULL,
 

CONSTRAINT NEWS_NO_PRIMARY_KEY PRIMARY KEY (NEWSNO),
CONSTRAINT NEWS_EMP_FK FOREIGN KEY(EMP_NO)REFERENCES EMPLOYEE(EMP_NO)
);


------------------------- 最新資訊  假資料 -------------------------

INSERT INTO NEWSDETAIL(NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('ND'||LPAD(to_char(NEWSNO_SEQ.NEXTVAL),4,'0'))),'居家安寧照護菁英班】讓我們一起學習有尊嚴的照護，熱烈報名中',
'人生最後一哩路該怎麼走?!讓我們一起學習有尊嚴的照護，與長輩分享這份「愛的禮物」!由深耕社區安寧照護超過20年的專業團隊及醫學中心安寧療護領域之專業人員組成之講師陣容。
以末期病人的生理、心理及心靈需求為中心，認識臨床症狀及規劃居家照護重點，瞭解照顧者的心理支持需求及陪伴關懷技巧，更將倫理議題及遺囑與預立醫療自主計畫納入課程重點；每個單元都有實務操作，透過角色扮演，讓學習更有成效。','EMP0014' , '上架'
);

INSERT INTO NEWSDETAIL(NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('ND'||LPAD(to_char(NEWSNO_SEQ.NEXTVAL),4,'0'))),'精彩花絮暨活動分享-8/1《照護放輕鬆》系列-在宅照護放鬆有撇步講座',
'8月1日與日本大王合作舉辦的第三場《照護放輕鬆》講座，現場獲得許多貴賓朋友支持，包括台北市社會局局長、新北市衛生局局長、衛生福利部照護司研究員前來，還有許多關心在宅照護議題的醫師、學者好朋友們，講座人潮爆滿，謝謝沒位置坐的朋友包容。','EMP0014','上架'
);

INSERT INTO NEWSDETAIL(NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('ND'||LPAD(to_char(NEWSNO_SEQ.NEXTVAL),4,'0'))),'南部的鄉親久等了，有我罩你7月起開始在大高雄地區服務囉!',
'居家照顧已經邁入第12年，服務範圍橫跨雙北、桃園及大台中、累積了上萬人次的服務經驗，今年七月將跨越濁水溪，成立「南區照護管理中心」，將以最完整且全方位的銀髮居家照顧網絡，來服務大高雄區域!
有我罩你以長輩為中心的服務設計，希望陪伴長輩的每一個老化階段:除了基本的生活、營養備餐、身體照顧、輔具及相關銀髮產品諮詢之外，還有更多客製化的服務，幫助長輩自主生活得愈久愈好，滿足長輩在家享老的願望。
為了提供更完整的服務，除了一直以來的優質居家照顧服務，更於2016年建構了一站式的整合平台，將優質的銀髮照護用品納入「有我罩你」網站，同時整合了以雙北為主的「北區照護管理中心」、涵蓋大台中區的「中區照護管理中心」，
加上最新成立的「南區照護管理中心」，並以全台通用的「412-8178」服務諮詢專線，增加使用服務的便利性，提供更多長輩優質的照護服務。','EMP0007','下架'  
);

commit;


--------------------------------------------------------------------------------
                             -- 保健資訊 --
--------------------------------------------------------------------------------

-------------------- 保健資訊 HEALTHNEWSDETAIL -----------------

CREATE TABLE HEALTHNEWSDETAIL(
 HEALTHNO       VARCHAR2(15)  NOT NULL,
 NEWSTITLE      VARCHAR2(200) NOT NULL,
 NEWSINTRO      CLOB,
 EMP_NO         VARCHAR2(10)  NOT NULL,
 COVERPIC       BLOB,
 NEWSPIC1       BLOB,
 NEWSPIC2       BLOB,
 NEWSDATE       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 STATUS			VARCHAR2(15)  NOT NULL,

CONSTRAINT HEALTH_NO_PRIMARY_KEY PRIMARY KEY (HEALTHNO),
CONSTRAINT HEALTH_EMP_FK FOREIGN KEY(EMP_NO)REFERENCES EMPLOYEE(EMP_NO)
);



------------------------- 保健資訊  假資料 -------------------------

INSERT INTO HEALTHNEWSDETAIL(HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('HD'||LPAD(to_char(HEALTHNO_SEQ.NEXTVAL),4,'0'))),'吃零食也可以顧健康！巧克力不僅能養顏美容，連老年失智都可以預防',
'秋冬季節只要涼風一吹、空氣濕度下降，許多女性的肌膚馬上有感，出現緊繃、乾癢，甚至脫屑的現象，再加上有些人以為秋冬的紫外線較弱，疏忽了防曬，
根據國際期刊《Journal of Cosmetic Dermatology》（化妝品皮膚病學雜誌）於2009年刊載一篇文章，研究團隊發現巧克力中的黃酮類化合物（flavanols）
成分是一種抗氧化物，具有降低體內自由基、減少促發炎因子（如：前發炎性細胞激素、一氧化氮）的作用，每天攝取20公克巧克力，持續12周，
可以保護皮膚免受傷害，減少因紫外線暴露所引起的紅斑。鄭欣宜營養師說明，研究使用的巧克力，每20公克平均含600毫克的可可類黃酮（cocoa flavanols）
，抗氧化能力（ORAC）數值大於1萬，抗發炎和抗氧化的表現優異，因此運用於肌膚保養方面，可以減少慢性紫外線暴露，進而預防皮膚提早老化。','EMP0006' ,'上架' 
);

INSERT INTO HEALTHNEWSDETAIL(HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('HD'||LPAD(to_char(HEALTHNO_SEQ.NEXTVAL),4,'0'))),'居家照護好便利　到宅護理「足」感心',
'居家護理以人為本，管理更入心!
居家護理係以人為本、以家庭為單位、以社區為基礎，提供被照顧者及照顧者持續性的照護。根據統計，目前居家護理所共計有534家，其設置的型態有醫院附設型態、獨立型態及衛生所附設型態；
其中醫院附設型態計194家(36.4%)、獨立型為224家(41.9%)，而衛生所附設則有116家(21.7%)。呂郁芳指出，居家護理師所提供服務內容，除大眾所熟知的到家進行傷口護理、管路更換（如鼻胃管、
導尿管、氣管套管等）、注射及代採檢體送檢外，還包括一般身體檢查和評估、居家安全評估與建議、健康問題處理和指導及社會資源諮詢和轉介，護理師一旦發現個案現存健康問題或潛在危險因素後，
並可提供個別化的護理諮詢、指導及護理措施。居家照護小細節　足部護理很重要。「?之於未有，治之於未亂」，呂郁芳理事長以足部健康危害因子舉例，如龜裂、趾甲增厚、長趾甲、趾甲嵌入症、
老繭皮、雞眼、趾甲疾病與變形等問題，都可透過居家足部照護而獲得改善。','EMP0011' ,'上架' 
);

INSERT INTO HEALTHNEWSDETAIL(HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, STATUS)
VALUES ((to_char('HD'||LPAD(to_char(HEALTHNO_SEQ.NEXTVAL),4,'0'))),'醬料重鹹吃多傷腎 這些疾病也跟著來',
'天氣濕濕冷冷，此時吃火鍋、羊肉爐、薑母鴨最適合了！不過，營養師蔡素琴提醒，民眾吃鍋物最喜歡沾加工醬料，重口味飲食容易鈉含量攝取超標，增加高血壓、腎臟負擔，也容易加速骨質流失。
醬料不鹹　含鈉量卻很高。台北市立聯合醫院松德院區營養科營養師蔡素琴指出，常見的加工醬料，如番茄醬、辣椒醬、
豆乳醬、沙茶醬、豆瓣醬，雖然嚐起來不鹹，但所含的鹽分卻很驚人。根據衛福部建議，每人每天鈉攝取量是2400毫克，相當6克的鹽，但吃一餐火鍋就超過一天建議量。
吃太鹹　容易得這些病。蔡素琴營養師表示，鹽攝取過多容易存積在血管壁內，當血管壁管徑失去彈性，血流通過的阻力愈大、血壓就愈高，鹽也會影響新陳代謝、阻礙水分排出及鈣質吸收，
增加高血壓、中風、腎臟病，以及骨質疏鬆的風險。天然蔬果醬料較健康蔡素琴營養師強調，健康飲食觀念是吃食物的原味，許多蔬菜水果具有天然重口味，
且富含維生素等營養素，如番茄、檸檬帶有酸味，洋蔥、大蒜、辣椒帶有辛辣味，柳橙、蘋果帶有甜味，建議民眾可將食材切碎，
加上橄欖油混均勻，搭配食物吃得出天然美味。','EMP0001'  ,'下架'
);

commit;
