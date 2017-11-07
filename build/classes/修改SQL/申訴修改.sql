--------------------------------------------------------------------------------
                                -- 申訴區 --
--------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- 四大服務
-------------------------------------------------------------------------------
--- 4大服務申訴欄位新增
1. COMPLAINDETAIL / DETAILDATE / COMPLAINREPLY / REPLYDATE / EMP_NO / COMPLAINSTATUS

--送餐申訴
1. 更改Table名：MEALCOMPLAIN


--------------------------------------------------------------------------------
                             -- DROP 四大服務申訴 --
--------------------------------------------------------------------------------
------DROP 派車申訴------
DROP SEQUENCE SHOPCOM_NO_SEQ;
DROP SEQUENCE HCCOM_NO_SEQ;
DROP SEQUENCE CARCOM_NO_SEQ;
DROP SEQUENCE MEALCOM_NO_SEQ;

------DROP 派車申訴------
DROP TABLE CARCOMPLAIN;
------DROP 派車申訴------

------DROP 商城申訴------
DROP TABLE SHOPAPPEALSCOMPLAIN;
------DROP 商城申訴------

------DROP 長照申訴------
DROP TABLE HCCOMPLAIN;
------DROP 長照申訴------

------DROP 派車申訴------
DROP TABLE MEALCOMPAIN;
------DROP 派車申訴------


--------------------------------------------------------------------------------
                             -- 派車申訴 --
--------------------------------------------------------------------------------

----------------- 派車申訴 Car-Complain: ----------------------
-------更新TABLE

CREATE TABLE CARCOMPLAIN(
 COMPLAINNO           VARCHAR2(15) NOT NULL,
 ORDER_NO             VARCHAR2(15) NOT NULL,
 COMPLAINDETAIL       CLOB,
 DETAILDATE           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 COMPLAINREPLY        CLOB,
 REPLYDATE            TIMESTAMP,
 EMP_NO               VARCHAR2(10),
 COMPLAINSTATUS       VARCHAR2(15) NOT NULL,

CONSTRAINT CARCOMPLAIN_NO_PRIMARY_KEY PRIMARY KEY (COMPLAINNO),
CONSTRAINT COMPLAIN_CAR_FK FOREIGN KEY(ORDER_NO)REFERENCES CAR_ORDER (ORDER_NO),
CONSTRAINT COMPLAIN_EMP_FK FOREIGN KEY(EMP_NO )REFERENCES EMPLOYEE (EMP_NO)
);

---------  派車自增主鍵
CREATE SEQUENCE CARCOM_NO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;


------------------------- 假資料 -------------------------

INSERT INTO CARCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('CR'||LPAD(to_char(CARCOM_NO_SEQ.NEXTVAL),6,'0')),'20171026-000001','車子太顛坡阿','EMP0001' ,'未處理');


INSERT INTO CARCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('CR'||LPAD(to_char(CARCOM_NO_SEQ.NEXTVAL),6,'0')),'20171102-000010','請問司機可以更改嗎','您好,已轉交客服,客服人員會再與您聯繫',CURRENT_TIMESTAMP ,'EMP0001' ,'處理中');

INSERT INTO CARCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('CR'||LPAD(to_char(CARCOM_NO_SEQ.NEXTVAL),6,'0')),'20171102-000012','司機好帥,請問單身嗎？','您好,已轉交司機,請司機給你line會再與您聯繫',CURRENT_TIMESTAMP,'EMP0001' ,'已完成');



--------------------------------------------------------------------------------
                             -- 送餐申訴 --
--------------------------------------------------------------------------------

----------------- 送餐申訴 Meal-Complain: ----------------------
-------更新TABLE

CREATE TABLE MEALCOMPLAIN(
 COMPLAINNO           VARCHAR2(15) NOT NULL,
 MO_NO                VARCHAR2(15) NOT NULL,
 COMPLAINDETAIL       CLOB,
 DETAILDATE           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 COMPLAINREPLY        CLOB,
 REPLYDATE            TIMESTAMP,
 EMP_NO               VARCHAR2(10), 
 COMPLAINSTATUS       VARCHAR2(15) NOT NULL,

CONSTRAINT MEALCOMPLAIN_NO_PRIMARY_KEY PRIMARY KEY (COMPLAINNO),
CONSTRAINT COMPLAIN_MEAL_FK FOREIGN KEY(MO_NO)REFERENCES MEAL_ORDER (MO_NO),
CONSTRAINT MEALCOMPLAIN_EMP_FK FOREIGN KEY(EMP_NO)REFERENCES EMPLOYEE(EMP_NO)
);

--------- 送餐 自增主鍵
CREATE SEQUENCE MEALCOM_NO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

------------------------- 假資料 -------------------------
INSERT INTO MEALCOMPLAIN(
COMPLAINNO, MO_NO,COMPLAINDETAIL,COMPLAINSTATUS)
VALUES (to_char('MO'||LPAD(to_char(MEALCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-000002','餐點太清淡,下一餐可以換別的餐點嗎?','未處理');

INSERT INTO MEALCOMPLAIN(
COMPLAINNO,MO_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('MO'||LPAD(to_char(MEALCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-000003','請問可以再多追加餐點嗎?','您好,已轉交客服,客服人員會再與您聯繫',CURRENT_TIMESTAMP ,'EMP0001' ,'處理中');

INSERT INTO MEALCOMPLAIN(
COMPLAINNO,MO_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('MO'||LPAD(to_char(MEALCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-000004','今天午餐的小黃瓜有點爛爛的','您好,已轉交客服,客服人員會再與您聯繫',CURRENT_TIMESTAMP ,'EMP0001' ,'處理中');

COMMIT;

,to_char(sysdate,'yyyymmdd')||'-'||LPAD('000001',6,'0'),


--------------------------------------------------------------------------------
                             -- 長照申訴 --
--------------------------------------------------------------------------------
CREATE TABLE HCCOMPLAIN(
 COMPLAINNO           VARCHAR2(15) NOT NULL,
 ORDER_NO             VARCHAR2(15) NOT NULL,
 COMPLAINDETAIL       CLOB,
 DETAILDATE           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 COMPLAINREPLY        CLOB,
 REPLYDATE            TIMESTAMP,
 EMP_NO               VARCHAR2(10), 
 COMPLAINSTATUS       VARCHAR2(15) NOT NULL,

CONSTRAINT HCCOMPLAIN_NO_PRIMARY_KEY PRIMARY KEY (COMPLAINNO),
CONSTRAINT COMPLAIN_HC_FK FOREIGN KEY(ORDER_NO)REFERENCES HC_ORDER_MASTER (ORDER_NO),
CONSTRAINT HCCOMPLAIN_EMP_FK FOREIGN KEY(EMP_NO)REFERENCES EMPLOYEE(EMP_NO)
);

---------長照 自增主鍵
CREATE SEQUENCE HCCOM_NO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

------------------------- 假資料 -------------------------
INSERT INTO HCCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,COMPLAINSTATUS)
VALUES (to_char('HC'||LPAD(to_char(HCCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-500007','突然臨時有事, 請問可更改日期嗎？','未處理');


INSERT INTO HCCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('HC'||LPAD(to_char(HCCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-500008','長照人員大遲到','您好,已收到您的申訴,轉交給長照部上層做處理,照成您的不便,不好意思。',CURRENT_TIMESTAMP ,'EMP0001' ,'處理中');


INSERT INTO HCCOMPLAIN(
COMPLAINNO,ORDER_NO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('HC'||LPAD(to_char(HCCOM_NO_SEQ.NEXTVAL),6,'0')),'20171103-500009','請問可以看到訂購成功媒合長照人員是哪位嗎？','您好在會員資料的訂單上可以看到',CURRENT_TIMESTAMP ,'EMP0001' ,'已完成');

--------------------------------------------------------------------------------
                             -- 商城申訴 --
--------------------------------------------------------------------------------



CREATE TABLE SHOPCOMPLAIN(
 COMPLAINNO           VARCHAR2(15) NOT NULL,
 ORDERNO              VARCHAR2(15) NOT NULL,
 COMPLAINDETAIL       CLOB,
 DETAILDATE           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 COMPLAINREPLY        CLOB,
 REPLYDATE            TIMESTAMP,
 EMP_NO               VARCHAR2(10), 
 COMPLAINSTATUS       VARCHAR2(15) NOT NULL,

CONSTRAINT SHOPCOMPLAIN_NO_PRIMARY_KEY PRIMARY KEY (COMPLAINNO),
CONSTRAINT COMPLAIN_SHOP_FK FOREIGN KEY(ORDERNO)REFERENCES SHOPORDER (ORDERNO),
CONSTRAINT SHOPCOMPLAIN_EMP_FK FOREIGN KEY(EMP_NO)REFERENCES EMPLOYEE(EMP_NO)
);

---------  商城 自增主鍵
CREATE SEQUENCE SHOPCOM_NO_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;


------------------------- 假資料 -------------------------
INSERT INTO SHOPCOMPLAIN(
COMPLAINNO,ORDERNO,COMPLAINDETAIL,COMPLAINSTATUS)
VALUES (to_char('SP'||LPAD(to_char(SHOPCOM_NO_SEQ.NEXTVAL),6,'0')),'20171026-000002','商品有瑕疵,我覺得不行,收到已破損','未處理');


INSERT INTO SHOPCOMPLAIN(
COMPLAINNO,ORDERNO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('SP'||LPAD(to_char(SHOPCOM_NO_SEQ.NEXTVAL),6,'0')),'20171026-000003','商品有瑕疵,我覺得不行,收到已破損','您好,已收到您的申訴,立馬幫你更換寄送新的。',CURRENT_TIMESTAMP ,'EMP0001' ,'已完成');


INSERT INTO SHOPCOMPLAIN(
COMPLAINNO,ORDERNO,COMPLAINDETAIL,COMPLAINREPLY,REPLYDATE, EMP_NO ,COMPLAINSTATUS)
VALUES (to_char('SP'||LPAD(to_char(SHOPCOM_NO_SEQ.NEXTVAL),6,'0')),'20171026-000004','有使用上的問題,不會用阿!','您好,我們會請客服人員與您聯繫',CURRENT_TIMESTAMP ,'EMP0001' ,'已完成');

COMMIT;
